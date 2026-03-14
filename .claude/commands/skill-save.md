---
name: skill-save
description: 今うまくいった作業パターンをSkillとして保存する
---

以下の手順でSkillを保存してください。

## Step 1: Skill内容の確認

「今うまくいった作業パターン」について教えてください：
- どんな作業をしましたか？
- 何が特に効果的でしたか？
- このパターンを再現するには何をすればいいですか？

（ユーザーの説明を待つか、会話の流れから自動的に判断してください）

## Step 2: Skill草案の生成

以下の形式でSkillファイルの草案を生成してください：

```markdown
---
name: [skill-name]
description: |
  [このSkillが何をするか、いつ使うべきか（2〜3行）]
---

# [Skill名]

## 目的
[このSkillで何を達成するか]

## 手順
[具体的なステップ]

## 注意点
[うまくいかなかったパターン・避けるべきこと]

## 使用例
[典型的な使い方のプロンプト例]
```

## Step 3: 保存先の確認

```
保存先: ~/.claude/skills/auto-evolved/[skill-name]/SKILL.md

このSkillを保存しますか？（はい/いいえ）
```

## Step 4: 保存と記録

「はい」の場合：
1. `~/.claude/skills/auto-evolved/[skill-name]/SKILL.md` を作成
2. `~/.claude/learning/insights.jsonl` に成功パターンとして記録

```json
{
  "timestamp": "ISO8601形式",
  "session_summary": "手動Skill保存",
  "failures": [],
  "successes": [
    {
      "pattern": "[パターンの説明]",
      "skill_candidate": false,
      "skill_name": "[skill-name]",
      "skill_description": "[説明]",
      "saved": true
    }
  ]
}
```

保存完了後：
```
✅ Skill保存完了: ~/.claude/skills/auto-evolved/[skill-name]/
   /[skill-name] で呼び出せます
```
