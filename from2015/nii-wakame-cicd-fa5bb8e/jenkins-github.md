# Jenkins GitHubポーリング連動

# jenkinsプラグインのインストール

## 左メニューから「Jenkinsの管理」を開きます

![](https://cloud.githubusercontent.com/assets/76867/6633516/4340a22e-c98d-11e4-8977-efb43201b795.png)

## Gitプラグインのインストール

### 「プラグインの管理」を開きます

![](https://cloud.githubusercontent.com/assets/76867/6633526/5d6e64b0-c98d-11e4-9a97-2ab5c5e1c921.png)

### 「利用可能」タブを開きます

![](https://cloud.githubusercontent.com/assets/76867/6633662/6f6306b0-c98f-11e4-9b1d-025a328a0bc3.png)

### 右上の検索バーからプラグインを検索します

![](https://cloud.githubusercontent.com/assets/76867/6633540/995f5600-c98d-11e4-917f-bda37a10bbb0.png)

### "Git"を検索します

![](https://cloud.githubusercontent.com/assets/76867/6633684/dfe8a0ac-c98f-11e4-836d-842e2370d90c.png)

### チェックボックスにチェックを入れ、 「再起動せずにインストール」をクリックします

![](https://cloud.githubusercontent.com/assets/76867/6633701/18cbb170-c990-11e4-932f-615851c75f1b.png)

### インストール成功を確認します

![](https://cloud.githubusercontent.com/assets/76867/6633713/47d656dc-c990-11e4-8a6d-68c2e01ea85a.png)

## インストールしたプラグインの反映

### 「インストール完了後、ジョブが無ければJenkinsを再起動する」をチェック

![](https://cloud.githubusercontent.com/assets/76867/6633720/5bdce98e-c990-11e4-8c6c-cf40493c2e9a.png)

### Jenkinsのシャットダウンと起動を待つ

![](https://cloud.githubusercontent.com/assets/76867/6633723/728ff874-c990-11e4-9f3e-b1abf3ea3ada.png)

### メニューから「Update center」を開く

しばらく待っても画面遷移しない事が良くあるので、「Update center」を開き、状況を確認する。

![](https://cloud.githubusercontent.com/assets/76867/6633738/a0ccf0b6-c990-11e4-8e42-d3e3df66d5e1.png)

### 赤い帯が消えてる事を確認する

![](https://cloud.githubusercontent.com/assets/76867/6633743/b6164abc-c990-11e4-91a6-aaa1fc377c88.png)

### 左メニューから「プラグインの管理」

インストールしたプラグインがどうなったのかを確認します。

![](https://cloud.githubusercontent.com/assets/76867/6633748/c81bc778-c990-11e4-8977-3667e27ea40a.png)

### 「インストール済み」タブを開く

![](https://cloud.githubusercontent.com/assets/76867/6633753/e0f9ad6e-c990-11e4-8ae4-0bf01463baed.png)

### プラグインがインストールされてる事を確認

プラグインのインストールが成功していると、一覧に表示されます。

![](https://cloud.githubusercontent.com/assets/76867/6633763/05ae117c-c991-11e4-85be-61330463fbbc.png)

# Git Pluginの設定

JenkinsからGitを使うには、Gitの設定が必要です。

## 左メニューから「Jenkinsの管理」

![](https://cloud.githubusercontent.com/assets/76867/7246968/0b002954-e83f-11e4-9525-a36f4d969508.png)

## メニューから「システムの設定」

![](https://cloud.githubusercontent.com/assets/76867/7246980/26b0bf60-e83f-11e4-982c-226090d377ec.png)

## 下までスクロールしてGit Plugin設定項目を入力

2つの設定項目を入力します。

1. `Global Config user.name Value`: コミット時のユーザー名
2. `Global Config user.email Value`: コミット時のメールアドレス

![](https://cloud.githubusercontent.com/assets/76867/7247015/7aff271e-e83f-11e4-966a-c127cf627169.png)

## 入力完了後、「保存」

![](https://cloud.githubusercontent.com/assets/76867/7247028/9876eb24-e83f-11e4-96e9-422203af8cc4.png)

# ジョブの新規作成とソースコードのチェックアウト

## 左メニューから「新規ジョブ作成」

![](https://cloud.githubusercontent.com/assets/76867/6633904/66bf6234-c993-11e4-9768-cdefb9da310c.png)

## ジョブの名前と種類を設定

+ `ジョブ名`：厳しい制限はありませんが、半角英数字だけで生成した方が良い
+ `フリースタイルジョブのビルド`: 一般的なジョブはフリースタイルに分類されます

![](https://cloud.githubusercontent.com/assets/76867/6633921/8fe08e86-c993-11e4-963c-ae8aa61d9fb3.png)

## 入力完了後「OK」

![](https://cloud.githubusercontent.com/assets/76867/6633925/a577133c-c993-11e4-936a-861e063abc18.png)

## ソースコード管理からGitを選択

![](https://cloud.githubusercontent.com/assets/76867/6633936/bb183b4e-c993-11e4-9187-66c84de06c06.png)

## リポジトリURLを入力

![](https://cloud.githubusercontent.com/assets/76867/6633947/f220273c-c993-11e4-974d-e83a5662279f.png)

![](https://cloud.githubusercontent.com/assets/76867/6633948/2402e348-c994-11e4-8a84-bbabe8e018d2.png)

## 入力完了後「保存」

![](https://cloud.githubusercontent.com/assets/76867/6633954/3ea11b8e-c994-11e4-8434-3188ce5d79e8.png)

## 「ビルド実行」でジョブをビルドしてみる

登録したジョブをビルドしてみます。Gitリポジトリを監視設定しただけなので、チェックアウトだけ実行されます。

![](https://cloud.githubusercontent.com/assets/76867/6633960/59d855c0-c994-11e4-854a-c2fb8a73aee8.png)

## ビルドの進捗を確認

![](https://cloud.githubusercontent.com/assets/76867/6633967/756c13da-c994-11e4-858b-6dbf0292061c.png)

## ビルド完了を確認

![](https://cloud.githubusercontent.com/assets/76867/6633976/8ed4af30-c994-11e4-9f3c-b3f1251afffb.png)

## 左メニューから「コンソール出力」

![](https://cloud.githubusercontent.com/assets/76867/6633980/a9bb2b6c-c994-11e4-97ac-49b1628f5351.png)

# GitHubのプロジェクトをポーリング(定期監視)

※必要な人のみ設定して下さい※

ジョブ登録しただけでは、Jenkinsがリポジトリの変化に気付く手段がありません。そしてそのままでは、手動でビルドするしかありません。CIツールであるJenkinsには、ポーリング機能が備わっています。このポーリング機能を利用すると、定期的にリポジトリを監視するようになり、自動ビルドを実現出来ます。

## ダッシュボードからジョブを選択

![](https://cloud.githubusercontent.com/assets/76867/7387615/985b6a6a-ee99-11e4-9ebf-efa381057a8c.png)

## 左メニューから「設定」

![](https://cloud.githubusercontent.com/assets/76867/7387630/b25fe652-ee99-11e4-91c1-208f97a88d9d.png)

## 下までスクロールして「SCMをポーリング」をチェック

![](https://cloud.githubusercontent.com/assets/76867/7387647/df027bfc-ee99-11e4-958f-3972dbfbe46e.png)

## ポーリングの「スケジュール」入力が出現

![](https://cloud.githubusercontent.com/assets/76867/7387668/f26e7614-ee99-11e4-94bf-f5ec70a5acee.png)

## crontablフォーマットで記述。右側の「？」をクリック

![](https://cloud.githubusercontent.com/assets/76867/7387686/1903b0fa-ee9a-11e4-9d14-9b2d8b401c88.png)

## 記述に関する説明が出て来るので、説明を参考に入力

![](https://cloud.githubusercontent.com/assets/76867/7387703/3711ee90-ee9a-11e4-8983-33a96090cb99.png)

## スケジュールは１行で記述

![](https://cloud.githubusercontent.com/assets/76867/7387712/50a63ac8-ee9a-11e4-8e62-187048e6b795.png)

## 今回は5分毎にポーリング

`*/5 * * * *`を記述します。

![](https://cloud.githubusercontent.com/assets/76867/7387721/7028f76e-ee9a-11e4-83ec-3cb957b93a9c.png)

## 入力項目の下は、入力補助機能

記述内容に誤りがある場合、そして推奨記述内容を教えてくれます。推奨の場合は無視して構いません。

![](https://cloud.githubusercontent.com/assets/76867/7387730/833f4bdc-ee9a-11e4-9495-19daef42bbcc.png)

## 設定を保存

![](https://cloud.githubusercontent.com/assets/76867/7387752/b38fbfd8-ee9a-11e4-886c-b966819873b3.png)

## 左メニューから「Gitのポーリング」

![](https://cloud.githubusercontent.com/assets/76867/7388046/2c03c066-ee9d-11e4-829e-bf0d59d5f7cc.png)

## Gitのポーリングログを確認

定期的にポーリングした結果が保存されます。なお、リポジトリ内容に変更点が無い場合は、ビルドされません。

![](https://cloud.githubusercontent.com/assets/76867/7388061/4178919c-ee9d-11e4-9d6f-7ec285cbb72e.png)
