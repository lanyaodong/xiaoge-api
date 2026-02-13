import os
import requests
from datetime import datetime, timezone, timedelta

BASE_URL = os.getenv("BASE_URL", "http://127.0.0.1:8000")
USER_ID = "11111111-1111-1111-1111-111111111111"
TZ8 = timezone(timedelta(hours=8))


def iso(dt: datetime) -> str:
    """
    Always send an RFC3339 timestamp with timezone.
    In CI, this avoids 'naive datetime' / timezone parsing edge cases.
    """
    if dt.tzinfo is None:
        dt = dt.replace(tzinfo=timezone.utc)
    # deterministic + log-friendly
    dt = dt.astimezone(timezone.utc).replace(microsecond=0)
    return dt.isoformat().replace("+00:00", "Z")


def assert_http_ok(r: requests.Response, step: str) -> None:
    """
    If we hit 422 (or anything unexpected), print server detail to speed up debugging.
    """
    if r.status_code in (200, 201):
        return
    try:
        body = r.json()
    except Exception:
        body = r.text
    raise AssertionError(f"[{step}] expected 200/201, got {r.status_code}. body={body}")


def test_e2e_metabolic_state_not_missing_fpg():
    now = datetime.now(TZ8)

    # 1) POST rhr
    rhr_payload = {
        "user_id": USER_ID,
        "biomarker_code": "rhr",
        "data_source_id": None,
        "observation_medium": "device",
        "sample_type": None,
        "sample_method": "wearable",
        "sampling_context": {"state": "resting"},
        "value_num": 58,
        "value_text": None,
        "value_json": {},
        "unit": "bpm",
        "measured_at": iso(now),
        "freshness_state": "fresh",
        "accuracy_tier": "standard",
    }
    r = requests.post(f"{BASE_URL}/observations", json=rhr_payload, timeout=10)
    assert_http_ok(r, "POST /observations (rhr)")

    # 2) POST fpg
    fpg_payload = {
        "user_id": USER_ID,
        "biomarker_code": "fpg",
        "data_source_id": None,
        "observation_medium": "bio_sample",
        "sample_type": "blood",
        "sample_method": "venous",
        "sampling_context": {"fasting": True},
        "value_num": 5.2,
        "value_text": None,
        "value_json": {},
        "unit": "mmol/L",
        "measured_at": iso(now + timedelta(minutes=5)),
        "freshness_state": "fresh",
        "accuracy_tier": "standard",
    }
    r = requests.post(f"{BASE_URL}/observations", json=fpg_payload, timeout=10)
    assert_http_ok(r, "POST /observations (fpg)")

    # 3) Refresh assessment
    refresh_payload = {"user_id": USER_ID, "system_codes": ["metabolic"]}
    r = requests.post(f"{BASE_URL}/assessments/refresh", json=refresh_payload, timeout=10)
    assert_http_ok(r, "POST /assessments/refresh")

    # 4) Get system state
    r = requests.get(f"{BASE_URL}/systems/metabolic/state", params={"user_id": USER_ID}, timeout=10)
    assert_http_ok(r, "GET /systems/metabolic/state")
    data = r.json()

    assert data["system_state"] != "invisible"
    assert data.get("evidence", {}).get("missing_core", []) == []
