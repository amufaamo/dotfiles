---
name: learned
description: このセッションで学んだことを記録し、GEMINI.mdとSkillの改善案を提案する（Claude Codeの/learnedに相当）
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
- Skill化できるか（はい/いいえ）

## Phase 2: ログへの記録

`~/.learning/insights.jsonl` に以下の形式で追記してください：

```json
{
  "timestamp": "ISO8601形式",
  "tool": "antigravity",
  "session_summary": "このセッションで何をしたか（1〜2行）",
  "failures": [
    {
      "pattern": "何が起きたか（1行）",
      "lesson": "次回どうすべきか（1行）",
      "gemini_md_rule": "GEMINI.mdに追加すべきルール（あれば）"
    }
  ],
  "successes": [
    {
      "pattern": "何が効果的だったか（1行）",
      "skill_candidate": true,
      "skill_name": "スキル名候補（英語・ケバブケース）",
      "skill_description": "このスキルが何をするか（1行）"
    }
  ]
}
```

## Phase 3: 即時提案（軽微なもの）

今すぐGEMINI.mdに追加すべき明確なルールがあれば提案してください：

```
【GEMINI.md追加提案】
追加場所: 【学習済みルール】セクション
追加内容: - [本日の日付] ○○のときは△△すること

承認しますか？（はい/いいえ）
```

承認された場合のみ `~/.gemini/GEMINI.md` の【学習済みルール】セクションに追記します。

## Phase 4: Skill候補の提示

`skill_candidate: true` のものがあれば、Skillファイルの草案を提示してください：

```
【Skill候補】
名前: skill-name
説明: このSkillが何をするか

--- SKILL.md プレビュー ---
（内容を表示）
--------------------------

~/.gemini/antigravity/skills/auto-evolved/skill-name/ に保存しますか？（はい/いいえ）
```

承認された場合のみ保存します。

## Phase 5: Knowledge Itemsへの保存提案

重要な発見・決定事項があれば、Knowledge Itemとして保存することを提案してください。
AntigravityのKnowledge Items機能を使って次のセッションに引き継ぎます。
