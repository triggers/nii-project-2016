# Jenkins HipChatへのレポート

# jenkinsプラグインのインストール

## 左メニューから「Jenkinsの管理」を開きます

![](https://cloud.githubusercontent.com/assets/76867/6633516/4340a22e-c98d-11e4-8977-efb43201b795.png)

## HipChat Pluginのインストール

### 「プラグインの管理」を開きます

![](https://cloud.githubusercontent.com/assets/76867/6633526/5d6e64b0-c98d-11e4-9a97-2ab5c5e1c921.png)

### 「利用可能」タブを開きます

![](https://cloud.githubusercontent.com/assets/76867/6633532/7a7e119a-c98d-11e4-90c7-3075b34755b5.png)

### 右上の検索バーからプラグインを検索します

![](https://cloud.githubusercontent.com/assets/76867/6633540/995f5600-c98d-11e4-917f-bda37a10bbb0.png)

### "hipchat"を検索します

![](https://cloud.githubusercontent.com/assets/76867/6633544/b540fdd8-c98d-11e4-86f7-b1e66a9a97bf.png)

### チェックボックスにチェックを入れます

![](https://cloud.githubusercontent.com/assets/76867/6633635/d6f0fa5e-c98e-11e4-8342-cd15b68da969.png)

### 「再起動せずにインストール」をクリックします

![](https://cloud.githubusercontent.com/assets/76867/6633645/fd558386-c98e-11e4-8c55-d1d378085636.png)

### インストール成功を確認します

![](https://cloud.githubusercontent.com/assets/76867/6633652/2b635334-c98f-11e4-99ec-8ede6ef93ed8.png)

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

# HipChatへの通知設定

## 左メニューから「Jenkinsの管理」

![](https://cloud.githubusercontent.com/assets/76867/6633848/5f70d68a-c992-11e4-87b9-9d56abd3b441.png)

## 「システムの設定」

![](https://cloud.githubusercontent.com/assets/76867/6633855/73f52584-c992-11e4-8dc4-c1a2dab3de96.png)

## 下までスクロールしてHipChat設定項目を入力

2つの設定項目を入力します。

1. `API Token`:  HipChat管理権限のみ閲覧可能な認証トークン
2. `Room`: 通知先の部屋(部屋の名前かRoomID)

![](https://cloud.githubusercontent.com/assets/76867/6633871/d0dfb73c-c992-11e4-820a-a99c3d29c3cc.png)

## 入力完了後、「保存」

![](https://cloud.githubusercontent.com/assets/76867/6633877/f832a0c4-c992-11e4-841e-7b8a90a9a3e9.png)

![](https://cloud.githubusercontent.com/assets/76867/6633880/15180efe-c993-11e4-9305-bcee5990cec6.png)

# HipChatに発言させてみる

HipChatプラグインの機能性質上、"Hello world"を発言させる様な簡易機能は存在しません。JenkinsからHipChatに発言させるには、ビルドが関連します。

## ジョブを新規作成します

![jenkins](https://cloud.githubusercontent.com/assets/76867/7626597/09b7d528-fa47-11e4-8b60-51410d22ebc5.png)

## 左メニューから「新規ジョブ作成」

![jenkins](https://cloud.githubusercontent.com/assets/76867/7626603/19921ea4-fa47-11e4-9feb-3693587e2cae.png)

## ジョブ名とプロジェクトの種類を選択

![jenkins](https://cloud.githubusercontent.com/assets/76867/7626622/474a13e2-fa47-11e4-9f05-5edbbd3c64f8.png)

## ジョブ名入力と選択完了後、「OK」

![jenkins](https://cloud.githubusercontent.com/assets/76867/7626632/5bd5c4f0-fa47-11e4-9f02-63b9ceea061e.png)

## プロジェクトの設定画面が表示されます

![test notification config jenkins](https://cloud.githubusercontent.com/assets/76867/7626641/6d1846c0-fa47-11e4-9a99-75253b0088cf.png)

## 下へスクロールし、「ビルド後の処理の追加」をクリックします

![test notification config jenkins](https://cloud.githubusercontent.com/assets/76867/7626656/9d25a380-fa47-11e4-9ff6-60cd12ffde75.png)

## 「HipChat Notifications」を選択

![test notification config jenkins](https://cloud.githubusercontent.com/assets/76867/7626666/b308855a-fa47-11e4-9a2f-3c20e2cc7f1b.png)

## 「HipChat Notifications」の設定項目が表示されます

![test notification config jenkins](https://cloud.githubusercontent.com/assets/76867/7626675/d698e3f2-fa47-11e4-91fb-3421b75def54.png)

## 「Start Notifications」をチェックします

![test notification config jenkins](https://cloud.githubusercontent.com/assets/76867/7626681/f341251e-fa47-11e4-9abb-f94e62356eab.png)

## 「保存」をクリック

![test notification config jenkins](https://cloud.githubusercontent.com/assets/76867/7626688/087e3480-fa48-11e4-879b-5a2a3954f22b.png)

## プロジェクト画面が表示されます

![test notification jenkins](https://cloud.githubusercontent.com/assets/76867/7626694/1dd6c554-fa48-11e4-8e5a-d2ebabfc1c9b.png)

## 左メニューから「ビルド実行」をクリックします

![test notification jenkins](https://cloud.githubusercontent.com/assets/76867/7626699/36f858ae-fa48-11e4-8f28-2724f50de605.png)

## ビルドが完了した事を確認しました

![test notification jenkins](https://cloud.githubusercontent.com/assets/76867/7626713/556882b4-fa48-11e4-8b99-601586865fb2.png)

## HipChatに通知されました

![hipchat](https://cloud.githubusercontent.com/assets/76867/7626732/7d3b173e-fa48-11e4-9b2d-9cf4734e8f74.png)
