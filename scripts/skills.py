#!/usr/bin/env python3
"""스킬 저장소 관리: 목록(index), 추가(add), 활성/보관 이동(activate/archive), 점검(check).

  python3 scripts/skills.py index
  python3 scripts/skills.py add <폴더> --provider hix-ai --category writing [--active]
  python3 scripts/skills.py activate <이름>     # library -> .claude/skills (자동 로딩, 토큰 소비)
  python3 scripts/skills.py archive <이름>      # .claude/skills -> library (로딩 안 됨, 토큰 0)
  python3 scripts/skills.py check

구조: 사용 중 = .claude/skills/<이름>/ (평평해야 자동 발견됨), 보관 = library/<출처>/<종류>/<이름>/
메타데이터(출처·종류·라이선스·공개 가능 여부) = skills.json
"""
import argparse, json, re, shutil, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
ACTIVE = ROOT / ".claude" / "skills"
LIB = ROOT / "library"
MANIFEST = ROOT / "skills.json"
INDEX = ROOT / "docs" / "skill-index.md"
CATS = {
    "video": "영상제작", "image-design": "이미지·디자인", "planning-marketing-writing": "기획·마케팅·글",
    "web-docs": "웹·문서", "coding-etc": "코딩·기타", "writing": "글쓰기", "other": "기타",
}
SECRET = re.compile(r"(sk-[A-Za-z0-9_-]{20,}|AKIA[0-9A-Z]{16}|ghp_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{30,}|"
                    r"xox[baprs]-[A-Za-z0-9-]{10,}|(api[_-]?key|secret|token|password)[\"' :=]+[A-Za-z0-9_./+-]{20,})", re.I)


def load():
    return json.loads(MANIFEST.read_text(encoding="utf-8")) if MANIFEST.exists() else {"skills": {}}


def save(m):
    MANIFEST.write_text(json.dumps(m, ensure_ascii=False, indent=2, sort_keys=True) + "\n", encoding="utf-8")


def front(path):
    t = path.read_text(encoding="utf-8", errors="replace")
    m = re.match(r"^---\s*\n(.*?)\n---", t, re.S)
    out = {}
    if m:
        for line in m.group(1).splitlines():
            k, _, v = line.partition(":")
            if k.strip() in ("name", "description"):
                out[k.strip()] = v.strip().strip('"').strip("'")
    return out


def est_tokens(s):
    ascii_n = sum(1 for c in s if ord(c) < 128)
    return round(ascii_n / 4 + (len(s) - ascii_n) / 1.5)


def scan():
    rows = []
    for base, status in ((ACTIVE, "사용중"), (LIB, "보관")):
        if not base.exists():
            continue
        for sk in sorted(base.rglob("SKILL.md")):
            if "references" in sk.parts:
                continue
            d = sk.parent
            fm = front(sk)
            rows.append({"name": d.name, "status": status, "dir": d, "desc": fm.get("description", ""),
                         "files": sum(1 for p in d.rglob("*") if p.is_file())})
    return rows


def cmd_index():
    m = load()["skills"]
    rows = scan()
    active = [r for r in rows if r["status"] == "사용중"]
    tok = sum(est_tokens(r["name"] + r["desc"]) for r in active)
    lines = ["# 스킬 목록 (자동 생성 — 직접 고치지 말고 `python3 scripts/skills.py index`)", "",
             f"- 사용중 {len(active)}개 (매 세션 description만 로딩, 추정 약 {tok} 토큰) / 보관 {len(rows) - len(active)}개 (토큰 0)",
             "- 공개 가능: true=확인됨, false=비공개 전용, unverified=확인 필요 (공개 저장소에는 true만)", ""]
    groups = {}
    for r in rows:
        meta = m.get(r["name"], {})
        groups.setdefault((meta.get("provider", "미분류"), meta.get("category", "other")), []).append((r, meta))
    for (prov, cat), items in sorted(groups.items()):
        lines += [f"## {prov} / {CATS.get(cat, cat)}", "", "| 스킬 | 상태 | 파일 | 공개 가능 | 한 줄 설명 |", "|---|---|---|---|---|"]
        for r, meta in items:
            one = re.split(r"[.。]\s", r["desc"])[0][:90].replace("|", "/")
            lines.append(f"| {r['name']} | {r['status']} | {r['files']} | {str(meta.get('public_ok', '?')).lower()} | {one} |")
        lines.append("")
    INDEX.parent.mkdir(parents=True, exist_ok=True)
    INDEX.write_text("\n".join(lines), encoding="utf-8")
    print(f"index: 사용중 {len(active)} / 보관 {len(rows) - len(active)} / 추정 {tok} 토큰 -> {INDEX.relative_to(ROOT)}")


def cmd_add(a):
    src = Path(a.folder)
    if not (src / "SKILL.md").exists():
        sys.exit(f"SKILL.md가 없습니다: {src}")
    name = src.name
    dst = ACTIVE / name if a.active else LIB / a.provider / a.category / name
    if dst.exists():
        sys.exit(f"이미 있습니다: {dst}")
    for p in src.rglob("*"):
        if p.is_file() and SECRET.search(p.read_text(encoding="utf-8", errors="ignore")):
            sys.exit(f"중단: 비밀키로 의심되는 문자열 → {p}")
    shutil.copytree(src, dst)
    m = load()
    m["skills"][name] = {"provider": a.provider, "category": a.category, "source": a.source or "", "license": a.license or "",
                         "public_ok": a.public_ok}
    save(m)
    print(f"추가: {dst.relative_to(ROOT)}")
    cmd_index()


def find(name):
    for r in scan():
        if r["name"] == name:
            return r
    sys.exit(f"스킬을 찾을 수 없습니다: {name}")


def cmd_move(name, to_active):
    r = find(name)
    meta = load()["skills"].get(name)
    if not meta:
        sys.exit("skills.json에 등록되지 않았습니다. 먼저 add 하거나 메타를 추가하세요.")
    if to_active == (r["status"] == "사용중"):
        sys.exit("이미 그 상태입니다.")
    dst = ACTIVE / name if to_active else LIB / meta["provider"] / meta["category"] / name
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.move(str(r["dir"]), str(dst))
    print(f"이동: {dst.relative_to(ROOT)}")
    cmd_index()


def cmd_check():
    m = load()["skills"]
    bad = 0
    for r in scan():
        meta = m.get(r["name"])
        if not meta:
            print(f"! 메타 없음: {r['name']}"); bad += 1
        if r["status"] == "사용중" and len(r["desc"]) > 400:
            print(f"! description 길다({len(r['desc'])}자, 토큰 부담): {r['name']}"); bad += 1
        if not r["desc"]:
            print(f"! description 없음(자동 로딩 불가): {r['name']}"); bad += 1
        if meta and meta.get("public_ok") is not True:
            print(f"· 공개 저장소 주의({meta.get('public_ok')}): {r['name']}")
        for p in r["dir"].rglob("*"):
            if p.is_file() and SECRET.search(p.read_text(encoding="utf-8", errors="ignore")):
                print(f"! 비밀키 의심: {p.relative_to(ROOT)}"); bad += 1
    print("check 완료" + (f": 문제 {bad}건" if bad else ": 문제 없음"))
    return 1 if bad else 0


if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    sp = ap.add_subparsers(dest="cmd", required=True)
    sp.add_parser("index"); sp.add_parser("check")
    p = sp.add_parser("add"); p.add_argument("folder"); p.add_argument("--provider", required=True)
    p.add_argument("--category", required=True); p.add_argument("--source"); p.add_argument("--license")
    p.add_argument("--public-ok", default="unverified", choices=["true", "false", "unverified"])
    p.add_argument("--active", action="store_true")
    for c in ("activate", "archive"):
        sp.add_parser(c).add_argument("name")
    a = ap.parse_args()
    if a.cmd == "add":
        a.public_ok = {"true": True, "false": False}.get(a.public_ok, "unverified")
    {"index": cmd_index, "check": lambda: sys.exit(cmd_check()), "add": lambda: cmd_add(a),
     "activate": lambda: cmd_move(a.name, True), "archive": lambda: cmd_move(a.name, False)}[a.cmd]()
