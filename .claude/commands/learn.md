---
name: learn
description: セッションの振り返り・記録・進化提案を1コマンドで行う
---

以下を順番に実行してください。

## Phase 1: 今日のセッションを振り返る

このセッションを振り返り、以下を特定してください：

**うまくいかなかったこと**
- 何が起きたか（1行）
- なぜうまくいかなかったか
- 次回どうすれば防げるか

**うまくいったこと**
- 何が効果的だったか（1行）
- Skill化できそうか（はい/いいえ）

## Phase 2: ログに記録する

~/.claude/learning/insights.jsonl に追記してください：

{
  "timestamp": "ISO8601形式",
  "tool": "claude-code",
  "session_summary": "このセッションで何をしたか（1〜2行）",
  "failures": [{"pattern": "何が起きたか", "lesson": "次回どうすべきか", "claude_md_rule": null}],
  "successes": [{"pattern": "何が効果的だったか", "skill_candidate": false, "skill_name": null}]
}

## Phase 3: 蓄積ログを分析する

~/.claude/learning/insights.jsonl 全体を読み込み確認：
- 2回以上繰り返している失敗パターンを抽出
- 2回以上繰り返している成功パターンを抽出
- skill_candidate: true でまだSkillになっていないものを抽出

## Phase 4: 改善提案を生成する

ルールの種類に応じて保存先を判断する：

| 種別 | 保存先 |
|------|--------|
| 特定技術スタック限定のルール（「Rを使うときだけ」等） | Memoryファイル |
| 全プロジェクト共通の振る舞いルール | CLAUDE.md |
| 手順・ワークフロー（繰り返し実行するもの） | Skills |

### 今日の気づき（単発）
明確なルールが見つかった場合のみ提案：

**特定技術限定ルールの場合：**
【提案①-A】Memoryファイルへ保存
保存先: `~/.claude/projects/…/memory/<技術名>.md`（既存ファイルがあればそこに追記）
追加内容: ルール本文 + **Why:** + **How to apply:**
承認しますか？（はい/いいえ）

**全プロジェクト共通ルールの場合：**
【提案①-B】CLAUDE.mdに追記
追加場所: 該当するStepセクション
追加内容: ルール本文
承認しますか？（はい/いいえ）

### 蓄積の気づき（2回以上）
繰り返しパターンがある場合のみ提案：
【提案②】繰り返し失敗 → Memory強化またはCLAUDE.mdルール強化
【提案③】繰り返し成功 → Skill化

繰り返しパターンがまだない場合は「まだ蓄積中です（現在X件）」と表示してスキップ。

## Phase 5: 承認された提案を適用する

承認されたものだけ実行：
1. Memoryファイルへ保存（特定技術ルール）: `~/.claude/projects/…/memory/<技術名>.md` に書き込み、`MEMORY.md` のインデックスを更新
2. CLAUDE.md に追記（全プロジェクト共通ルール）
3. `~/.claude/skills/auto-evolved/` にSkillを保存（手順・ワークフロー）
4. `~/.claude/learning/applied.jsonl` に記録

## Phase 6: 完了サマリー

━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ /learn 完了
  記録した気づき: X件
  適用した変更: Y件
  蓄積中のパターン: Z件
━━━━━━━━━━━━━━━━━━━━━━━━━━━

---

## Phase 7: GitHubに自動同期

Phase 5で変更が適用された場合（CLAUDE.mdが更新またはSkillが保存された）、
以下のコマンドを実行してGitHubに自動でpushしてください：
```bash
bash ~/ai-rules/sync.sh
```

pushが成功したら：
```
✅ GitHubに同期しました
   他のPCでは `git pull` で最新の状態を取得できます
```

pushが失敗した場合はエラーを表示してスキップします（メインの処理には影響しません）。
