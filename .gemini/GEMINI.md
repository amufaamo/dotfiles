# 汎用 Agent Configuration for Google Antigravity
# 最終更新: 自動管理
# 場所: ~/.gemini/GEMINI.md（グローバル）またはプロジェクトルートの GEMINI.md

---

## ⚠️ Antigravity固有の注意事項

Google AntigravityにはClaude CodeのAgent Team機能（エージェント同士の直接通信・自動タスク分配）がまだ実装されていない。
そのため、このGEMINI.mdは**Agent Teamのデメリットを補完する設計**になっている。

### Agent Teamがない場合の主なデメリットと補完方法

| デメリット | このファイルでの補完方法 |
|-----------|----------------------|
| 並列処理できない | Workspaceを分けて擬似並列。順番を明示的に指示 |
| エージェント間通信がない | `project.md` を共有情報源として全エージェントが参照 |
| コンテキストが蓄積しない | Knowledge Items + `project.md` で代替 |
| タスク自動分配がない | Workflowファイルで順番・担当を明示 |

---

## Step 1: タスク分析（作業開始前に必ず実行）

新しいタスクを受け取ったら、まず以下を確認すること：

### 1-A. 作業種別は何か？
- **実装系**: コード・インフラ・設定を作る
- **調査系**: 情報収集・文献調査・技術検証
- **執筆系**: 論文・レポート・ドキュメント・記事
- **分析系**: データ解析・ログ調査
- **レビュー系**: コード・文章・設計の評価

### 1-B. 分割できるか？
- 独立した関心事が3つ以上ある → 複数Workspaceに分割して順番に処理
- 順番依存がある → Workflowとして順番を定義
- 単純で小さい → 単一会話で処理

### 1-C. Knowledge Itemsの確認
**作業開始前に必ずKnowledge Itemsを確認すること。**
過去に同じ・似た作業をしていないか確認し、重複作業を避ける。

---

## Step 2: project.mdルール（Agent Team通信の代替）

Agent Teamのエージェント間通信がない代わりに、`project.md` を**単一の真実の情報源**として使う。

### 作業前の必須確認
プロジェクトルートに `project.md` がある場合、**必ず最初に読み込んでから作業を開始する**。
過去の文脈・決定事項・現在のタスクを把握した上で回答・作業を行う。

### 自律的な自動更新（Agent Team通信の代替）
Agent Teamでは「チームメイトAがAPIを変更したらチームメイトBに通知する」が自動で行われる。
Antigravityではこれを `project.md` への書き込みで代替する：

以下のタイミングで、指示がなくても `project.md` を更新する：
- タスクが完了したとき → 「4. 現在のタスク」を更新
- 重要な決定・変更があったとき → 「5. 活動履歴」に時系列で追記
- 他のWorkspaceに影響する変更をしたとき → 「3. ルール・制約」に注記

### project.mdの構造（変更・削除禁止）
```
1. 目的と背景 (Why)
2. ゴールと最終成果物 (What)
3. ルール・制約・前提条件 (How)
4. 現在のタスクとスケジュール (Action)
5. 活動履歴・決定事項 (Log)
```

---

## Step 3: ロール定義（Workspaceごとに割り当てる）

Agent Teamの「チームメイト」の代わりに、**Workspaceにロールを割り当てる**。

### 【実装系ロール】
**implementer**
- 担当: コード実装全般
- 作業前: `project.md` の「3. ルール・制約」を確認
- 作業後: `project.md` の「4. 現在のタスク」と「5. 活動履歴」を更新
- 重要: APIや型定義を変更したら必ず `project.md` に記録する

**tester**
- 担当: テスト作成・実行
- 作業前: implementerの完了を `project.md` で確認してから開始
- 作業後: テスト結果を `project.md` の「5. 活動履歴」に記録

**infra**
- 担当: インフラ・CI/CD・設定
- 環境変数・設定変更は必ず `project.md` の「3. ルール・制約」に追記

### 【調査系ロール】
**researcher**
- 担当: 情報収集・文献調査
- 発見内容は `project.md` の「5. 活動履歴」に記録
- Knowledge Itemsに保存して次のWorkspaceが参照できるようにする

**investigator**（競合仮説検証）
- 独立した仮説を持って検証する
- 結論と根拠を `project.md` に記録

### 【執筆系ロール】
**writer**
- 担当セクションを `project.md` で宣言してから開始（他のWorkspaceとの重複防止）
- 完了したら `project.md` の「4. 現在のタスク」を更新

**editor**
- writerの完了を `project.md` で確認してから動く
- 全体の論旨・一貫性・文体を統一

**fact-checker**
- 記述の正確性・引用の確認
- researcherのKnowledge Itemsを参照する

### 【品質系ロール】
**reviewer**
- 全成果物の品質チェック
- コード: セキュリティ・型安全性・規約
- 文章: 論理構造・引用・一貫性

---

## Step 4: タスク種別ごとの推奨Workspace構成

Agent Teamの代わりに、Workspaceを順番に使う：

| プロジェクト種別 | Workspace構成 | 処理順序 |
|----------------|-------------|---------|
| 新機能開発 | implementer → tester → reviewer | 直列リレー |
| バグ調査 | investigator×3（別Workspace）→ 統合 | 並列→収束 |
| 論文執筆 | researcher → writer×N → editor | 直列リレー |
| コードレビュー | reviewer×3（観点別・別Workspace）| 並列→統合 |
| 単純タスク | 単一Workspace | — |

### 並列処理の擬似実現方法
Agent Managerで複数のWorkspaceを同時に開き、それぞれ別のロールを割り当てる。
各Workspaceは `project.md` を共有情報源として参照することで間接的に連携する。

---

## Step 5: 共通ルール（全Workspace必読）

### 作業開始時の手順
1. Knowledge Itemsを確認（過去の文脈を把握）
2. `project.md` を読み込む（現在の状況を把握）
3. 担当範囲を `project.md` に宣言してから開始

### 作業完了時の手順
1. `project.md` の「4. 現在のタスク」を更新
2. 「5. 活動履歴」に完了内容を時系列で追記
3. 他のWorkspaceに影響する変更は明記する

### 完了報告の書き方
「何を・どこで・どう確認したか」を必ず含める：
- 実装: 「○○を実装。テストXX件通過を確認」
- 執筆: 「第3章XX字を執筆。引用YY件を追加」
- 調査: 「テーマXXを調査。主要文献ZZ件を要約」

### Knowledge Itemsの活用
- 重要な発見・決定はKnowledge Itemsに保存する
- 次のセッション・Workspaceが参照できるようにする
- これがAgent Teamのコンテキスト共有を代替する

---

## Step 6: Antigravity固有の機能を最大活用する

Agent Teamはないが、Antigravity独自の強みがある：

### Artifacts（透明性の確保）
- 計画・図表・スクリーンショットを積極的に生成する
- Agent Teamのメッセージログの代わりとして機能する
- 各Workspaceの成果をArtifactとして残す

### ブラウザエージェント（Gemini 2.5 Computer Use）
- UIの視覚的検証に積極的に使う
- テスト・デバッグをブラウザ経由で自律実行する

### SKILL.md（専門能力の定義）
- `.agents/skills/` に再利用可能なスキルを蓄積する
- Claude CodeのSkillと同じ思想で運用する

### Workflows（タスク分配の代替）
- `.agents/workflows/` に繰り返すタスクの手順を定義する
- Agent Teamの「タスクリスト」に相当する機能として使う

---

## Step 7: 自己進化ルール

このGEMINI.md自体を進化させるために：

- うまくいかなかったパターン → このファイルの【学習済みルール】に追記候補として記録
- うまくいったパターン → `.agents/skills/` にSKILL.mdとして保存候補
- **直接自動書き換えは禁止。必ず提案→人間の承認→適用の順番で行う**

---

## 【学習済みルール】
<!-- 自動追記セクション -->
<!-- 形式: - [YYYY-MM-DD] ルール内容 -->
