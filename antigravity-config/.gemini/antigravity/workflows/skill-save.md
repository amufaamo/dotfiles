---
name: skill-save
description: 今うまくいった作業パターンをSkillとして保存する（Claude Codeの/skill-saveに相当）
---

以下の手順でSkillを保存してください。

## Step 1: Skill内容の確認

「今うまくいった作業パターン」について：
- どんな作業をしましたか？
- 何が特に効果的でしたか？
- このパターンを再現するには何をすればいいですか？

## Step 2: Skill草案の生成

Antigravity Skill形式で生成します：

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
[典型的な使い方の例]
```

## Step 3: 保存先の確認

```
保存先: ~/.gemini/antigravity/skills/auto-evolved/[skill-name]/SKILL.md

このSkillを保存しますか？（はい/いいえ）
```

## Step 4: 保存と記録

「はい」の場合：
1. `~/.gemini/antigravity/skills/auto-evolved/[skill-name]/SKILL.md` を作成
2. `~/.learning/insights.jsonl` に成功パターンとして記録

保存完了後：
```
✅ Skill保存完了
   ~/.gemini/antigravity/skills/auto-evolved/[skill-name]/
   次回から /[skill-name] で呼び出せます
```
