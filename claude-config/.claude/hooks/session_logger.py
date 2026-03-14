#!/usr/bin/env python3
"""
session_logger.py
セッション終了時に自動実行されるHook。
セッションのメタ情報をログに記録する。
"""

import json
import sys
import datetime
import os

def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        data = {}

    log_dir = os.path.expanduser("~/.claude/learning")
    os.makedirs(log_dir, exist_ok=True)

    log_entry = {
        "timestamp": datetime.datetime.now().isoformat(),
        "session_id": data.get("session_id", "unknown"),
        "transcript_path": data.get("transcript_path", ""),
        "stop_reason": data.get("stop_reason", "unknown")
    }

    log_path = os.path.join(log_dir, "session_log.jsonl")
    with open(log_path, "a", encoding="utf-8") as f:
        f.write(json.dumps(log_entry, ensure_ascii=False) + "\n")

if __name__ == "__main__":
    main()
