import os
from datetime import datetime, timezone, timedelta
import requests

BASE_URL = os.getenv("XIAOGE_BASE_URL", "http://127.0.0.1:8000").rstrip("/")
USER_ID = os.getenv("XIAOGE_USER_ID", "11111111-1111-1111-1111-111111111111")

TZ8 = timezone(timedelta(hours=8))

def iso(dt: datetime) -> str:
    return dt.astimezone(TZ8).isoformat()

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
    assert r.status_code == 200

    # 2) POST fpg (bio_sample 必须 sample_type)
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
        "measured_at": iso(now + timedelta(minutes=1)),
        "freshness_state": "fresh",
        "accuracy_tier": "standard",
    }
    r = requests.post(f"{BASE_URL}/observations", json=fpg_payload, timeout=10)
    assert r.status_code == 200

    # 3) refresh metabolic
    refresh_payload = {"user_id": USER_ID, "system_codes": ["metabolic"]}
    r = requests.post(f"{BASE_URL}/assessments/refresh", json=refresh_payload, timeout=10)
    assert r.status_code == 200

    # 4) state should not say missing fpg
    r = requests.get(f"{BASE_URL}/systems/metabolic/state", params={"user_id": USER_ID}, timeout=10)
    assert r.status_code == 200
    state = r.json()

    missing = (state.get("evidence") or {}).get("missing_core") or []
    assert "fpg" not in missing, f"metabolic should NOT miss fpg, but got missing_core={missing}"
