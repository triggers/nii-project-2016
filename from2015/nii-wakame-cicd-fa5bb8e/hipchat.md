# HipChat セットアップ

# はじめに

HipChatはチャットサービスだけでなく通知連携サービスとしての顔も持っています。本書ではHipChatの初期登録から始め、他ツールとの連携を想定した登録作業を行っていきます。

# サインアップとチームの作成

※2015/03時点のキャプチャの為、現在の画面とは異なる場合があります

既にチーム作成が完了している場合は、本章を読み飛ばして頂いて構いませんが、連携するメンバーのうち、少なくとも1人管理権限が必要です。管理権限を持ったメンバーが居ない場合は、管理権限を持ったユーザーに管理権限付与を依頼して下さい。

## サインアップします

https://www.hipchat.com/sign_up を開きます。

## 「無料のチャットを」始めましょう

サインアップの手続き画面から「無料のチャットを始めましょう」をクリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774411/164c91dc-d163-11e4-8448-8ee443bd1d83.png)

## チームを作成します

新チーム作成をするので、「Create a new team」をクリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774422/28eb7718-d163-11e4-93bc-b96e95d81032.png)

## チーム名等、入力します

+ お名前(ローマ字表記で姓名)
+ メールアドレス(チーム管理者メールアドレスを兼ねます)
+ パスワード
+ チーム名(既に存在するチーム名の場合は使えません。早い者勝ちです！)

![](https://cloud.githubusercontent.com/assets/76867/6774428/47ebe67a-d163-11e4-98e3-a4a4fc832ceb.png)

## 必要項目入力後、作成へ進みます

必要項目入力後、「無料のチャットを始めましょう」をクリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774437/77d6d8a4-d163-11e4-9cba-731ed65329e4.png)

## メンバー招待

チーム作成が完了すると、メンバー招待画面へと進みます。

メンバーを追加したい場合は、名前とメールアドレスを入力します。誰も招待せずに一人で利用する事も可能です。入力完了後、または何も入力せずに、「Next」をクリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774443/9a5b35dc-d163-11e4-90ff-3a0c6471765d.png)

## メンバー設定が完了すると、自動的にチャットルームにログイン

登録完了すると、自動的にチャットルームにログインします。チーム作成は、これで完了です。

![](https://cloud.githubusercontent.com/assets/76867/6774472/3692f5a2-d164-11e4-837e-9384305e6b07.png)

## ここまでのまとめ

サインアップとチーム作成までを行いました。後述作業の前提となりますので、必ず終えておいて下さい。

# 認証トークン(Auth Token)の発行・取得

JenkinsなどのツールとHipChatを連携するには、認証トークンが必要です。本節では、Jenkins連携を想定した認証トークンの発行・取得を行います。

一度`https://チーム名.hipchat.com/home`を開きます。

## Group adminを開きます

メニューから、「Group admin」を開きます。

![](https://cloud.githubusercontent.com/assets/76867/6774492/b3a24f8e-d164-11e4-8e54-443a9f974c29.png)

## Group admin から API を選択

サブメニューから、「API」を開きます。

![](https://cloud.githubusercontent.com/assets/76867/6774500/d01e84ca-d164-11e4-9d45-e3589f41ae03.png)

## パスワードを入力

API操作に関しては、一度パスワード入力を求められるので、パスワードを入力します。

![](https://cloud.githubusercontent.com/assets/76867/6774504/edc07c04-d164-11e4-8165-65a4a053cc11.png)

## パスワード入力後はSubmit

パスワードを入力したら、「Submit」をクリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774513/0814914e-d165-11e4-8dd8-8ad2b6598c44.png)

## APIに関する情報

APIに関する情報ページが表示されます。主な用途は、認証トークン管理です。

![](https://cloud.githubusercontent.com/assets/76867/6774518/220921e6-d165-11e4-955e-ea7c100de649.png)

## 認証トークン作成準備

認証トークンを作成します。ここでは通知サービスと連携する事を想定して作成します。通知サービスとの連携には、「Admin」権限が必要です。Typeは「Admin」を選択します。次にLabelですが、認証トークンの説明用途です。連携するサービス名を入力しておくと、後の運用で困る事はありません。「Jenkins Integration」と入力しておきます。

+ Type:  `Admin`
+ Lable:  `Jenkins Integraiton`

![](https://cloud.githubusercontent.com/assets/76867/6774530/59298c38-d165-11e4-809f-afcb9847dacb.png)

## 認証トークンを作成

必要項目入力後、「Create」をクリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774544/7a1ebb34-d165-11e4-96d1-33f55e55e205.png)

## 認証トークンを確認

認証トークンが作成されると、認証トークンが表示されます。表示されたトークンは、連携サービスに登録する文字列です。登録した認証トークンは、後から表示確認出来るので、メモ帳などに保存しておく必要性はありません。

![](https://cloud.githubusercontent.com/assets/76867/6774556/a30c03d0-d165-11e4-9d94-4cc6fe7a9e2a.png)

## ここまでのまとめ

Jenkinsとの連携を想定した認証トークン作成を行いました。1つの認証トークンを複数Jenkinsに設定する事も可能です。また、Jenkins毎に認証トークンを作成する事も可能です。どちらが便利かは、運用によって異なりますので、臨機応変な対応をして下さい。

# ユーザーの追加

これまでの手順では、管理者が唯一のユーザーです。メンバーと連携するには、ユーザーをチームに追加する必要があります。本節では、チームにユーザーを追加して行きます。

一度`https://チーム名.hipchat.com/home`を開きます。

なお、チーム管理権限を持ってない場合は、チーム管理者に依頼して下さい。

## Group adminを開きます

メニューから、「Group admin」を開きます。

![](https://cloud.githubusercontent.com/assets/76867/6774492/b3a24f8e-d164-11e4-8e54-443a9f974c29.png)

## Group admin > Users を開く

サブメニューから「Users」を開くと、ユーザー管理画面が開きます。次に「Add」をクリックしてユーザー登録画面へ進みます。

![](https://cloud.githubusercontent.com/assets/76867/6774662/693c6f6c-d167-11e4-80af-073170a2b694.png)

## ユーザーを情報入力します

 + お名前(ローマ字表記で姓名)
+ @mention名
+ メールアドレス
+ ロール(AdimnとUserを選択出来ます。違いは管理権限の有無です)

![](https://cloud.githubusercontent.com/assets/76867/6774666/87ad065a-d167-11e4-8017-eb9432e200a2.png)

## 必要項目入力後、作成へ進みます

必要項目入力後、「Add User」をクリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774708/208941cc-d168-11e4-86fe-f213fbed38a5.png)

## ユーザーへのメール送信

ユーザー登録が完了すると、登録したメールアドレスに招待メールが送られます。

![](https://cloud.githubusercontent.com/assets/76867/6774715/40d44db4-d168-11e4-9e0f-bb6619b40b0f.png)

## ユーザーはメールを確認

受け取ったメールには、ユーザー登録を完了させるためのリンクが書かれた書かれています。Gmailの場合は「Join us on HipChat」のボタンがあるので、クリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774733/7eb6bbd0-d168-11e4-94b9-9e0117cffcaf.png)

## ユーザー情報を入力

追加でユーザー情報を入力します。

 1. 職種(実際の職種でなくて構いません)
 2. パスワード
 
![](https://cloud.githubusercontent.com/assets/76867/6774763/eac8ec94-d168-11e4-91fc-67140578a1c2.png)

## Sign Up 完了へ

必要項目を入力したら、「Sign Up」をクリックします。

![](https://cloud.githubusercontent.com/assets/76867/6774775/0e9f13dc-d169-11e4-89bd-24f147020417.png)

## Sign Upが完了すると、自動的にチャットにログイン

登録完了すると、自動的にチャットルームにログインします。ユーザー追加は、これで完了です。

![](https://cloud.githubusercontent.com/assets/76867/6774783/36622742-d169-11e4-9f45-15d7afedb937.png)

## ここまでのまとめ

ユーザー追加により、二人以上によるチーム連携する準備が整いました。bot連携する際にはbot専用ユーザーを追加する事が前提です。bot連携する場合は、ユーザー追加する必要がありますので、是非ユーザー登録を習得しておいて下さい。

# XMPP/Jabber Account Information

HubotとHipChatを連携するには、XMPP/Jabberアカウント情報が必要です。本節では、Hubot連携を想定したXMPP/Jabberアカウント情報を取得します。

一度`https://チーム名.hipchat.com/account`を開きます。

なお、アカウント情報を取得したいアカウントでログインしている事が前提です。別のユーザーでログインしてる場合は、一度ログアウトしてから、ログインして下さい。

## 左メニューから「XMPP/Jabber info」を選択

左メニューから「XMPP/Jabber info」を選択します。

![](https://cloud.githubusercontent.com/assets/76867/6774825/1ef10b86-d16a-11e4-8956-45fc73d2b8ad.png)

## XMPP/Jabberアカウント情報の表示

「Jabber ID」が表示されます。このIDをHubotの設定で使います。

![](https://cloud.githubusercontent.com/assets/76867/6774844/7fcae530-d16a-11e4-9299-bdd5b3aebac3.png)

## ここまでのまとめ

Hubot連携によるChatOpsを実現する際の必要項目です。Hubotを設定する回数は少ないので、忘れた頃に読み返す内容です。本手順を読み直せば分かる、と言う事を覚えておいて下さい。
