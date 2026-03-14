---
name: evolve
description: 蓄積した学習ログを分析してGEMINI.mdとSkillを進化させる・週1回推奨（Claude Codeの/evolveに相当）
---

以下の手順を実行してください。人間の承認なしにファイルを変更してはいけません。

## Phase 1: ログ分析

`~/.learning/insights.jsonl` を読み込み、以下を分析してください：

### 集計
- 総セッション数（antigravityとclaudeの両方）
- 記録された失敗パターン数・成功パターン数
- Skill候補数

### パターン抽出
- **繰り返し失敗（2回以上）**: 同じ・似た失敗パターンを特定
- **繰り返し成功（2回以上）**: 再現性の高い成功パターンを特定
- **未保存のSkill候補**: まだSkillになっていないもの

### 既存との比較
- `~/.gemini/GEMINI.md` を読み込み、すでに記載済みのルールを除外
- `~/.gemini/antigravity/skills/auto-evolved/` の既存Skillと重複するものを除外

## Phase 2: 改善提案の生成（まだ実行しない）

---

### 【提案A】GEMINI.mdへの追記・修正

```
変更箇所: [セクション名]
現在の内容: [現在の記述]
提案する内容: [変更後の記述]
理由: [なぜこの変更が必要か]
根拠となったセッション数: X回
```

---

### 【提案B】新しいSkillの保存

Antigravityの `.gemini/antigravity/skills/` 形式で：

```
Skill名: skill-name
保存先: ~/.gemini/antigravity/skills/auto-evolved/skill-name/SKILL.md
説明: このSkillが何をするか

--- SKILL.md 内容 ---
---
name: skill-name
description: |
  （説明文）
---

（Skillの本文）
---------------------
根拠となったセッション数: X回
```

---

### 【提案C】古いルールの削除・整理

学習済みルールが10件を超えた場合：

```
削除候補: [ルール内容]
理由: [なぜ削除すべきか]
```

---

## Phase 3: 承認フロー

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
提案サマリー:
  A. GEMINI.md変更: X件
  B. 新規Skill保存: Y件
  C. ルール削除: Z件

各提案を確認してください。
「A承認」「B却下」のように個別指定、または「全承認」で一括承認できます。
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Phase 4: 承認された提案の適用

承認された提案のみ実行：

1. GEMINI.mdの【学習済みルール】セクションに追記
2. Skillファイルの作成（`~/.gemini/antigravity/skills/auto-evolved/` 配下）
3. 適用ログの記録

`~/.learning/applied.jsonl` に記録：
```json
{
  "timestamp": "ISO8601形式",
  "tool": "antigravity",
  "applied_changes": ["変更内容1"],
  "skipped_changes": ["却下された提案"]
}
```

## Phase 5: 完了レポート

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ 進化完了レポート（Antigravity）
  適用した変更: X件
  追加されたSkill: Y件
  スキップした提案: Z件

次回の/evolve推奨日: [1週間後の日付]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
