---
name: learned
description: このセッションで学んだことを記録し、CLAUDE.mdとSkillの改善案を提案する
---

以下の手順を実行してください。

## Phase 1: セッションの振り返り

このセッションを振り返り、以下を特定してください：

**うまくいかなかったこと（失敗パターン）**
- 何が起きたか
- なぜうまくいかなかったか
- 次回どうすれば防げるか

**うまくいったこと（成功パターン）**
- 何が効果的だったか
- なぜうまくいったか
- 再現可能なパターンか（Skill候補かどうか）

## Phase 2: ログへの記録

~/.claude/learning/insights.jsonl に以下の形式で追記してください：

```json
{
  "timestamp": "ISO8601形式",
  "session_summary": "このセッションで何をしたか（1〜2行）",
  "failures": [
    {
      "pattern": "何が起きたか（1行）",
      "lesson": "次回どうすべきか（1行）",
      "claude_md_rule": "CLAUDE.mdに追加すべきルール（あれば）"
    }
  ],
  "successes": [
    {
      "pattern": "何が効果的だったか（1行）",
      "skill_candidate": true,
      "skill_name": "スキル名候補（英語、ケバブケース）",
      "skill_description": "このスキルが何をするか（1行）"
    }
  ]
}
```

## Phase 3: 即時提案（軽微なもの）

記録した内容の中で、今すぐCLAUDE.mdに追加すべき明確なルールがあれば提案してください。

**提案形式：**
```
【CLAUDE.md追加提案】
追加場所: Step 5「共通ルール」の末尾
追加内容: - [本日の日付] ○○のときは△△すること

承認しますか？（はい/いいえ）
```

承認された場合のみ~/.claude/CLAUDE.mdの【学習済みルール】セクションに追記してください。

## Phase 4: Skill候補の提示

skill_candidate: true のものがあれば、Skillファイルの草案を提示してください：

```
【Skill候補】
名前: skill-name
説明: このSkillが何をするか

内容プレビュー:
（SKILL.mdの草案を表示）

~/.claude/skills/auto-evolved/skill-name/ に保存しますか？（はい/いいえ）
```

承認された場合のみ保存してください。
