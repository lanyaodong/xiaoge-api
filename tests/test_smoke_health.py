import os
import requests

BASE_URL = os.getenv("XIAOGE_BASE_URL", "http://127.0.0.1:8000").rstrip("/")

def test_health_ok():
    r = requests.get(f"{BASE_URL}/health", timeout=10)
    assert r.status_code == 200
    data = r.json()
    assert data.get("ok") is True or data.get("状态") is True  # 兼容你之前中英输出

def test_db_health_ok():
    r = requests.get(f"{BASE_URL}/health/db", timeout=10)
    assert r.status_code == 200
    data = r.json()
    assert data.get("ok") is True
    assert data.get("db") == "connected"
