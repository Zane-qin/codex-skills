import json
import subprocess

PYTHON = r"D:\Codex\.codex\skills\rent-ops\.venv\Scripts\python.exe"
SCRIPT = r"D:\Codex\.codex\skills\rent-ops\scripts\amap_query.py"
CWD = r"D:\Codex\.codex\skills\rent-ops"

PLACES = [
    ("未来科技大厦", "未来科技大厦"),
    ("万泉河桥", "万泉河桥"),
    ("苏州桥", "苏州桥"),
    ("西苑", "西苑"),
    ("农大南路", "农大南路"),
    ("马连洼", "马连洼"),
    ("西北旺", "西北旺"),
    ("永丰南", "永丰南"),
    ("永丰", "永丰"),
    ("上地元中心", "上地元中心"),
    ("西二旗", "西二旗"),
    ("五道口", "五道口"),
    ("中关村", "中关村"),
    ("清河永泰园", "清河永泰园"),
    ("永泰庄", "永泰庄"),
    ("霍营", "霍营"),
    ("回龙观东大街", "回龙观东大街"),
    ("龙泽", "龙泽"),
]


def query(name, dest):
    cp = subprocess.run(
        [PYTHON, SCRIPT, "commute", "--to", dest, "--pretty"],
        cwd=CWD,
        capture_output=True,
        text=True,
        encoding="utf-8",
        timeout=60,
    )
    if cp.returncode != 0:
        return {"name": name, "dest": dest, "status": "error", "error": cp.stderr.strip() or cp.stdout.strip()}
    data = json.loads(cp.stdout)
    anchor = (data.get("anchors") or [{}])[0]
    return {
        "name": name,
        "dest": dest,
        "status": data.get("status"),
        "duration_min": anchor.get("duration_min"),
        "transfers": anchor.get("transfers"),
        "walking_m": anchor.get("walking_distance_m"),
        "score": data.get("aggregate_score_5"),
        "over_max": anchor.get("over_max"),
    }


def main():
    results = [query(name, dest) for name, dest in PLACES]
    print(json.dumps(results, ensure_ascii=False, indent=2))
    print("\n排序:")
    def key(item):
        value = item.get("duration_min")
        return 999 if value is None else value
    for item in sorted(results, key=key):
        if item["status"] == "ok":
            print(
                f"{item['duration_min']:5.1f} min | 换乘{item['transfers']} | "
                f"步行{item['walking_m']}m | {'超60' if item['over_max'] else 'OK'} | "
                f"{item['name']} -> {item['dest']}"
            )
        else:
            print(f"ERR | {item['name']} -> {item['dest']} | {item.get('error', '')[:120]}")


if __name__ == "__main__":
    main()
