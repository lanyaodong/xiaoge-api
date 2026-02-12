import os
import sys
import json
from datetime import datetime, timezone, timedelta
import requests

BASE_URL = os.getenv("XIAOGE_BASE_URL", "http://127.0.0.1:8000").rstrip("/")

USER_ID = os.getenv("XIAOGE_USER_ID", "11111111-1111-1111-1111-111111111111")

TZ8 = timezone(timedelta(hours=8))

def iso(dt: datetime) -> str:
    return dt.astimezone(TZ8).isoformat()

def req(method: str, path: str, *, params=None, json_body=None, timeout=10):
    url = f"{BASE_URL}{path}"
    r = requests.request(method, url, params=params, json=json_body, timeout=timeout)
    try:
        data = r.json()
    except Exception:
        data = r.text
    if r.status_code >= 400:
        raise RuntimeError(f"{method} {path} -> {r.status_code}: {data}")
    return data

def main():
    # 0) health + db health
    print("0) health_check")
    print(req("GET", "/health"))

    print("0) db_health_check")
    print(req("GET", "/health/db"))

    # 1) create rhr (device)
    now = datetime.now(TZ8)
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
        "accuracy_tier": "standard"
    }

    print("1) create_observation rhr")
    r1 = req("POST", "/observations", json_body=rhr_payload)
    print(json.dumps(r1, ensure_ascii=False, indent=2))

    # 2) create fpg (bio_sample) - must have sample_type
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
        "accuracy_tier": "standard"
    }

    print("2) create_observation fpg")
    r2 = req("POST", "/observations", json_body=fpg_payload)
    print(json.dumps(r2, ensure_ascii=False, indent=2))

    # 3) confirm latest
    print("3) get_latest_observation rhr")
    latest_rhr = req("GET", "/observations/latest", params={"user_id": USER_ID, "biomarker_code": "rhr"})
    print(json.dumps(latest_rhr, ensure_ascii=False, indent=2))

    print("3) get_latest_observation fpg")
    latest_fpg = req("GET", "/observations/latest", params={"user_id": USER_ID, "biomarker_code": "fpg"})
    print(json.dumps(latest_fpg, ensure_ascii=False, indent=2))

    # 4) refresh assessments (metabolic)
    print("4) refresh_assessments metabolic")
    refresh = req("POST", "/assessments/refresh", json_body={"user_id": USER_ID, "system_codes": ["metabolic"]})
    print(json.dumps(refresh, ensure_ascii=False, indent=2))

    # 5) read system state
    print("5) get_system_state metabolic")
    state = req("GET", "/systems/metabolic/state", params={"user_id": USER_ID})
    print(json.dumps(state, ensure_ascii=False, indent=2))

    # 6) recommendations (only if not invisible)
    if state.get("system_state") != "invisible":
        print("6) get_recommendations metabolic")
        recs = req("GET", "/recommendations", params={"user_id": USER_ID, "system_code": "metabolic"})
        print(json.dumps(recs, ensure_ascii=False, indent=2))
    else:
        print("6) skip recommendations (system_state=invisible)")
        print("missing_core:", state.get("evidence", {}).get("missing_core", []))

    print("\nDONE ✅")

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print("\nFAILED ❌", str(e))
        sys.exit(1)
