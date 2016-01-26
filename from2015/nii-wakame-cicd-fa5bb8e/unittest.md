# Jenkins 単体テスト実行ジョブ

# jenkinsプラグインのインストール

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627558/8ac2e192-fa53-11e4-9e73-58de4e351313.png)

## 左メニューから「Jenkinsの管理」を開きます

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627563/9ac25f5a-fa53-11e4-9089-ca1768e9cda3.png)

## rbenv pluginのインストール

### 「プラグインの管理」を開きます

![jenkins jenkins](https://cloud.githubusercontent.com/assets/76867/7627571/b0df4f3c-fa53-11e4-96b8-fd83c978b4dc.png)

### 「利用可能」タブを開きます

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627591/e3b8eae4-fa53-11e4-9715-c7b9a54fead2.png)

### 右上の検索バーからプラグインを検索します

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627597/fb4d87c8-fa53-11e4-8364-91fae2e577db.png)

### "rbenv"を検索します

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627601/11e2e924-fa54-11e4-9185-0a038b597626.png)

### チェックボックスにチェックを入れます

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627609/25331f6c-fa54-11e4-98ad-f7d96e28ab8a.png)

### 「再起動せずにインストール」をクリックします

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627624/3b5ff83c-fa54-11e4-8772-f5cc905c6b7f.png)

### インストール成功を確認します

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627632/5d20da5e-fa54-11e4-9148-443e1aca7a8a.png)

## インストールしたプラグインの反映

### 「インストール完了後、ジョブが無ければJenkinsを再起動する」をチェック

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627642/6d948476-fa54-11e4-850f-daf3caeffc15.png)

### Jenkinsのシャットダウンと起動を待つ

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627649/7f97cafc-fa54-11e4-8756-67b636ef4936.png)

### メニューから「Update center」を開く

しばらく待っても画面遷移しない事が良くあるので、「Update center」を開き、状況を確認する。

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627665/9580aa28-fa54-11e4-9c8a-c660d6b5417d.png)

### 赤い帯が消えてる事を確認する

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627671/ab687f8c-fa54-11e4-92c0-e03a62ee4ee6.png)

### 左メニューから「プラグインの管理」

インストールしたプラグインがどうなったのかを確認します。

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627678/bb894dba-fa54-11e4-99bf-6c5213d14048.png)

### 「インストール済み」タブを開く

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627686/cd3d65f0-fa54-11e4-8c14-a26e13cacca2.png)

### プラグインがインストールされてる事を確認

プラグインのインストールが成功していると、一覧に表示されます。

![jenkins](https://cloud.githubusercontent.com/assets/76867/7627703/f459479e-fa54-11e4-9584-1d507aa4d8ef.png)

# rbenvを使ってみる

## ジョブを新規作成します

![jenkins](https://cloud.githubusercontent.com/assets/76867/7628716/9b3d675a-fa61-11e4-8f68-947e70353a5e.png)

## 左メニューから「新規ジョブ作成」

![jenkins](https://cloud.githubusercontent.com/assets/76867/7628725/af3c7d90-fa61-11e4-83d5-ac98e10e9d82.png)

## ジョブ名とプロジェクトの種類を選択

![jenkins](https://cloud.githubusercontent.com/assets/76867/7628732/c8ce46d0-fa61-11e4-8e12-871e1aaec3f8.png)

## ジョブ名入力と選択完了後、「OK」

![jenkins](https://cloud.githubusercontent.com/assets/76867/7628738/d9adf66c-fa61-11e4-88bd-1be34374b9e1.png)

## プロジェクトの設定画面が表示されます

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7628757/0a7a4ebc-fa62-11e4-9cbf-738381ac1654.png)

## 下へスクロールし、「rbenv build wrapper」をチェックします

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7628773/23ecee9a-fa62-11e4-9732-88eafcccd787.png)

## 「The Ruby version」と「Preinstall gem list」を入力します

テスト対象となるRubyバージョンと、使用するGEMパッケージを定義します。

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7628794/592418a4-fa62-11e4-82c4-c7519a7e1009.png)

## 「ビルド手順の追加」を開きます

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7628805/815db97e-fa62-11e4-99ce-6328d8556eb7.png)

## 「シェルの実行」を選択します

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7628815/96711784-fa62-11e4-9fd4-b6cb82bc8921.png)

## 「シェルスクリプト」を入力します

インストールしたパッケージが利用可能かどうかを確認してみます。

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7628829/afae865a-fa62-11e4-9df0-4b5fa1fe0f11.png)

## 「保存」をクリック

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7628830/c18efefe-fa62-11e4-8fec-c4687bb837a9.png)

## プロジェクト画面が表示されます

![test rbenv jenkins](https://cloud.githubusercontent.com/assets/76867/7628836/cfe58504-fa62-11e4-964b-0afd45121578.png)

## 左メニューから「ビルド実行」をクリックします

![test rbenv jenkins](https://cloud.githubusercontent.com/assets/76867/7628848/e208e1b8-fa62-11e4-8fa1-04ac20ea960b.png)

## ビルドが開始した事を確認します

![test rbenv jenkins](https://cloud.githubusercontent.com/assets/76867/7628867/fdc9509a-fa62-11e4-8638-2e013a9d344f.png)

## ビルドの状態を確認してみます

rbenvを使ってrubyバイナリをビルドしているので、ビルドが完了するまでに時間がかかります。

![test rbenv jenkins](https://cloud.githubusercontent.com/assets/76867/7628886/1cf36cbc-fa63-11e4-9e82-a3e2944ada4c.png)
![test rbenv 1 jenkins](https://cloud.githubusercontent.com/assets/76867/7628897/2cfc4e30-fa63-11e4-9437-d10dbad7655e.png)
![test rbenv 1 jenkins](https://cloud.githubusercontent.com/assets/76867/7628908/3c47ae52-fa63-11e4-87e5-eecd58b9b46f.png)

![test rbenv 1 console jenkins](https://cloud.githubusercontent.com/assets/76867/7628913/4d93625a-fa63-11e4-9b5c-d411db431a17.png)

rubyをインストールしてる事が分かります。

![test rbenv 1 console jenkins](https://cloud.githubusercontent.com/assets/76867/7629003/1995be8e-fa64-11e4-9db9-fc73604be32e.png)

無事に完了し、bundlerとrakeが利用可能状態である事が分かります。

## 実際にテストを定義して行きます

![test rbenv 1 console jenkins](https://cloud.githubusercontent.com/assets/76867/7629014/3789bf26-fa64-11e4-8afb-652ac29381d5.png)
![test rbenv jenkins](https://cloud.githubusercontent.com/assets/76867/7629031/558a0670-fa64-11e4-9bb2-fd49428f168b.png)

## 「シェルスクリプト」を入力します

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7629059/8a8fe024-fa64-11e4-9141-4e4d5d3ed94f.png)

ここでは暫定のテストコマンドが定義されていたので、テストに応じたコマンドを定義して下さい。
なお、テスト内容やテスト方法によって内容が異なります。

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7629068/adc895b8-fa64-11e4-8966-37435d3f9ecc.png)

## 「保存」をクリック

![test rbenv config jenkins](https://cloud.githubusercontent.com/assets/76867/7629083/c5bdbdba-fa64-11e4-9022-36dae9a54aec.png)

この後の作業は、ビルド実行して結果を確認する今までの手順と同じです。
