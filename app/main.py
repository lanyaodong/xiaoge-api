import os
import json
import asyncpg
from uuid import UUID
from pathlib import Path
from datetime import datetime
from typing import Optional, Any, Dict, List, Literal

from fastapi import FastAPI, HTTPException, Query
from pydantic import BaseModel, Field
from dotenv import load_dotenv


BASE_DIR = Path(__file__).resolve().parents[1]
load_dotenv(BASE_DIR / ".env")

app = FastAPI(title="Xiaoge v0 API", version="0.1")


# -------------------------
# DB helpers
# -------------------------
def get_database_url() -> str:
    return os.getenv("DATABASE_URL", "").strip()


def normalize_dsn(dsn: str) -> str:
    # asyncpg expects "postgresql://"
    return dsn.replace("postgresql+asyncpg://", "postgresql://")


async def get_conn() -> asyncpg.Connection:
    dsn = get_database_url()
    if not dsn:
        raise RuntimeError("DATABASE_URL is empty")
    return await asyncpg.connect(normalize_dsn(dsn))


# -------------------------
# Models
# -------------------------
ObservationMedium = Literal["bio_sample", "device", "questionnaire", "imaging", "clinical_exam", "estimate", "unknown"]
SampleType = Literal[
    "blood", "urine", "stool", "saliva", "buccal_epithelial", "cervical_fluid", "pleural_fluid", "respiratory_mucosa",
    "other", "unknown"
]
SampleMethod = Literal["venous", "capillary", "cgm", "wearable", "cuff_bp", "imaging", "questionnaire", "estimate", "unknown"]
FreshnessState = Literal["fresh", "stale", "expired", "unknown"]
AccuracyTier = Literal["gold", "standard", "low", "unknown"]

SystemCode = Literal["energy", "metabolic", "cardiopulmonary", "musculoskeletal", "neurocognitive", "repair_immune"]
SystemState = Literal["ideal", "normal", "limited", "impaired", "invisible"]


class ObservationIn(BaseModel):
    user_id: UUID
    biomarker_code: str

    data_source_id: Optional[UUID] = None

    observation_medium: ObservationMedium = "unknown"
    sample_type: Optional[SampleType] = None
    sample_method: SampleMethod = "unknown"
    sampling_context: Dict[str, Any] = Field(default_factory=dict)

    value_num: Optional[float] = None
    value_text: Optional[str] = None
    value_json: Dict[str, Any] = Field(default_factory=dict)
    unit: Optional[str] = None

    measured_at: datetime # ISO datetime string
    freshness_state: FreshnessState = "unknown"
    accuracy_tier: AccuracyTier = "unknown"


class AssessmentRefreshIn(BaseModel):
    user_id: UUID
    system_codes: List[SystemCode]


# -------------------------
# Health
# -------------------------
@app.get("/health")
def health():
    return {"状态": True, "环境": os.getenv("APP_ENV", "dev")}


@app.get("/health/db")
async def health_db():
    dsn = get_database_url()
    if not dsn:
        return {"ok": False, "error": "DATABASE_URL 为空"}

    try:
        conn = await get_conn()
        v = await conn.fetchval("SELECT 1;")
        await conn.close()
        return {"ok": True, "db": "connected", "select1": v}
    except Exception as e:
        return {"ok": False, "error": str(e)}


# -------------------------
# Observations
# -------------------------
@app.post("/observations")
async def create_observation(payload: ObservationIn):
    # NOTE: 这里是真正落库；user_id 会写进 biomarker_observations.user_id
    try:
        conn = await get_conn()

        row = await conn.fetchrow(
            """
            INSERT INTO biomarker_observations (
              user_id, biomarker_code, data_source_id,
              observation_medium, sample_type, sample_method, sampling_context,
              value_num, value_text, value_json, unit,
              measured_at, freshness_state, accuracy_tier
            )
            VALUES (
              $1::uuid, $2::text, $3::uuid,
              $4::observation_medium_enum, $5::sample_type_enum, $6::sample_method_enum, $7::jsonb,
              $8::numeric, $9::text, $10::jsonb, $11::text,
              $12::timestamptz, $13::freshness_state_enum, $14::accuracy_tier_enum
            )
            RETURNING id, user_id, biomarker_code, observation_medium, sample_type, sample_method,
                      sampling_context, value_num, value_text, value_json, unit, measured_at,
                      freshness_state, accuracy_tier;
            """,
            str(payload.user_id),
            payload.biomarker_code,
            str(payload.data_source_id) if payload.data_source_id else None,
            payload.observation_medium,
            payload.sample_type,
            payload.sample_method,
            json.dumps(payload.sampling_context),
            payload.value_num,
            payload.value_text,
            json.dumps(payload.value_json),
            payload.unit,
            payload.measured_at,
            payload.freshness_state,
            payload.accuracy_tier,
        )
        await conn.close()
        return dict(row) if row else {"ok": False}
    except asyncpg.PostgresError as e:
        # 例如你触发了 CHECK：bio_sample 必须有 sample_type
        raise HTTPException(status_code=422, detail=str(e))
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@app.get("/observations/latest")
async def get_latest_observation(
    user_id: UUID = Query(...),
    biomarker_code: str = Query(...)
):
    try:
        conn = await get_conn()
        row = await conn.fetchrow(
            """
            SELECT id, user_id, biomarker_code, observation_medium, sample_type, sample_method,
                   sampling_context, value_num, value_text, value_json, unit, measured_at,
                   freshness_state, accuracy_tier
            FROM biomarker_observations
            WHERE user_id = $1::uuid
              AND biomarker_code = $2::text
            ORDER BY measured_at DESC
            LIMIT 1;
            """,
            str(user_id),
            biomarker_code,
        )
        await conn.close()
        return dict(row) if row else None
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# -------------------------
# Assessments / System state (v0 placeholder logic)
# -------------------------
CORE_BY_SYSTEM: Dict[str, List[str]] = {
    "energy": ["rhr", "hrv"],
    "metabolic": ["fpg"],
}


@app.post("/assessments/refresh")
async def refresh_assessments(payload: AssessmentRefreshIn):
    results = []
    for sc in payload.system_codes:
        state = await _calc_system_state(payload.user_id, sc)
        results.append(state)
    return results


@app.get("/systems/{system_code}/state")
async def get_system_state(system_code: SystemCode, user_id: UUID = Query(...)):
    return await _calc_system_state(user_id, system_code)


async def _calc_system_state(user_id: UUID, system_code: str):
    required = CORE_BY_SYSTEM.get(system_code, [])
    missing = []
    try:
        conn = await get_conn()
        for code in required:
            v = await conn.fetchval(
                """
                SELECT 1
                FROM biomarker_observations
                WHERE user_id = $1::uuid AND biomarker_code = $2::text
                LIMIT 1;
                """,
                str(user_id),
                code,
            )
            if not v:
                missing.append(code)
        await conn.close()
    except Exception as e:
        return {"user_id": str(user_id), "system_code": system_code, "system_state": "invisible", "confidence_note": str(e), "evidence": {}}

    if missing:
        note = f"状态不可见：缺少核心标志物 {', '.join(missing)}"
        return {
            "user_id": str(user_id),
            "system_code": system_code,
            "system_state": "invisible",
            "confidence_note": note,
            "evidence": {"missing_core": missing},
        }

    # v0 占位：核心齐了先给 normal（后续再接规则引擎）
    return {
        "user_id": str(user_id),
        "system_code": system_code,
        "system_state": "normal",
        "confidence_note": "v0：核心标志物已齐（占位状态：normal）",
        "evidence": {"missing_core": []},
    }


@app.get("/recommendations")
async def get_recommendations(
    user_id: UUID = Query(...),
    system_code: SystemCode = Query(...)
):
    # v0：从 calculation_rules + products_services / product_system_map 做一个最小拼装
    try:
        conn = await get_conn()

        rule = await conn.fetchrow(
            """
            SELECT rule_code, system_code, title, editorial_status
            FROM calculation_rules
            WHERE system_code = $1::system_code_enum
            ORDER BY updated_at DESC
            LIMIT 1;
            """,
            system_code,
        )

        products = await conn.fetch(
            """
            SELECT
              p.id, p.name, p.product_type, p.applicable_system_code,
              p.member_price_cny, p.market_price_cny, p.commission_cny, p.purchase_url,
              m.system_code AS mapped_system_code
            FROM products_services p
            JOIN product_system_map m ON m.product_service_id = p.id
            WHERE m.system_code = $1::system_code_enum
            ORDER BY p.created_at DESC
            LIMIT 20;
            """,
            system_code,
        )

        await conn.close()

        return [{
            "user_id": str(user_id),
            "system_code": system_code,
            "title": (rule["title"] if rule else f"{system_code} 建议（v0）"),
            "items": ["v0：先跑通端到端，后续接规则引擎生成个性化建议。"],
            "products": [dict(r) for r in products],
        }]
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
