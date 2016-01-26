# Jenkins 任意のスクリプト実行ジョブ

# はじめてのジョブ作成

Jenkinsインストール後の最初の作業は、ジョブ作成です。まずはジョブ作成を行います。

## Jenkinsのトップページを開きます

ブラウザから`http://10.0.22.100:8080/`を開いて下さい。これはJenkins用インスタンスが、1台目のインスタンスとして起動している事を想定しています。もしも2台目以降のインスタンスとして起動している場合は、IPアドレスを読み替えて対応して下さい。

![jenkins](https://cloud.githubusercontent.com/assets/76867/7634122/c3c389a2-fa93-11e4-8bcf-13ae4c137967.png)

## 左メニューから「新規ジョブ作成」

![jenkins](https://cloud.githubusercontent.com/assets/76867/7634165/01267e6c-fa94-11e4-9e81-45b626117732.png)

## ジョブの名前と種類を設定

+ `ジョブ名`：厳しい制限はありませんが、半角英数字だけで生成した方が良です(※半角スペースを含めないようにして下さい)
+ `フリースタイルジョブのビルド`: 一般的なジョブはフリースタイルに分類されます

![jenkins](https://cloud.githubusercontent.com/assets/76867/7634191/2bdd1ce2-fa94-11e4-98c8-e121d4d0e834.png)

## 入力完了後、「保存」

![jenkins](https://cloud.githubusercontent.com/assets/76867/7634204/49d627d4-fa94-11e4-9577-b1085cde615c.png)

## プロジェクト設定画面が開きます

![sample config jenkins](https://cloud.githubusercontent.com/assets/76867/7635180/6a8feec8-fa9a-11e4-97e5-43c30d5725a0.png)

## 画面下部の「保存」

![sample config jenkins](https://cloud.githubusercontent.com/assets/76867/7635219/aca03836-fa9a-11e4-8dbc-7f27330f8a35.png)

## プロジェクト画面が表示されます

![sample jenkins](https://cloud.githubusercontent.com/assets/76867/7634261/a5a6062e-fa94-11e4-830e-0fb9c181b461.png)

プロジェクトの登録は以上です。中身のないプロジェクトを登録したので、これ以降の作業でジョブの内容を充実させて行きます。

# ジョブに「シェルの実行」を追加

ジョブに任意のコマンドを定義して行きます。プロジェクトによってビルドさせたいコマンドは変わって来ます。この「シェルの実行」を使う事により、任意のコマンドを実行させられるようになります。

## ダッシュボードからジョブを選択

![jenkins](https://cloud.githubusercontent.com/assets/76867/7635283/0bb5b698-fa9b-11e4-8bb7-08ab7da3f565.png)

## 左メニューから「設定」

![sample jenkins](https://cloud.githubusercontent.com/assets/76867/7635330/4d045816-fa9b-11e4-91ca-8834cde13406.png)

## 設定画面から「ビルド手順の追加」

![sample config jenkins](https://cloud.githubusercontent.com/assets/76867/7635372/868066d4-fa9b-11e4-84c3-306dece94773.png)

## セレクトボックスから「シェルの実行」を選択

![sample config jenkins](https://cloud.githubusercontent.com/assets/76867/7635391/a97d783e-fa9b-11e4-8afa-87b803ad0f5d.png)

## 「シェルの実行」テキストフォームが出現

![sample config jenkins](https://cloud.githubusercontent.com/assets/76867/7635424/d1b7843e-fa9b-11e4-89c5-2ba542d5cfb9.png)

## テキストフォームに、実行させたいコマンドを定義し、保存

![sample config jenkins](https://cloud.githubusercontent.com/assets/76867/7635436/f1ef6488-fa9b-11e4-950a-0fbd21882e20.png)

## プロジェクト画面が表示されます

![sample jenkins](https://cloud.githubusercontent.com/assets/76867/7635462/226a30e8-fa9c-11e4-87b2-c59283291059.png)

## 左メニューから「ビルド実行」

![sample jenkins](https://cloud.githubusercontent.com/assets/76867/7635483/3ea59784-fa9c-11e4-83d4-136edebfc27f.png)

## ビルド完了を確認

![sample jenkins](https://cloud.githubusercontent.com/assets/76867/7635516/66e29d64-fa9c-11e4-924d-4144401945d4.png)

## 左メニューから「コンソール出力」

![sample 1 jenkins](https://cloud.githubusercontent.com/assets/76867/7635537/884809e4-fa9c-11e4-9298-ed3a90451483.png)

## ビルドログの内容を確認

![sample 1 console jenkins](https://cloud.githubusercontent.com/assets/76867/7635636/1526bbda-fa9d-11e4-9e22-ddc3f81a2b76.png)

プロジェクトの登録は以上です。中身のないプロジェクトを登録したので、これ以降の作業でジョブの内容を充実させて行きます。

# ジョブ連携

Jenkinsにはジョブ連携機能があります。ジョブAが成功/失敗したら、ジョブBを実行する機能があります。例えばジョブAにはパッケージビルドを、ジョブBではパッケージインストールを定義します。パッケージビルドとパッケージインストールは関係があり、更に処理順序を気にする必要があります。こうした順序定義する場合に、ジョブ連携が活躍します。

## 左メニューから「新規ジョブ作成」

![jenkins](https://cloud.githubusercontent.com/assets/76867/7764695/2aba8b86-0090-11e5-9dd5-88ec0c116758.png)

## ジョブの名前と種類を設定

+ `ジョブ名`：厳しい制限はありませんが、半角英数字だけで生成した方が良です(※半角スペースを含めないようにして下さい)
+ `フリースタイルジョブのビルド`: 一般的なジョブはフリースタイルに分類されます

![jenkins](https://cloud.githubusercontent.com/assets/76867/7764710/56ca01f2-0090-11e5-83bd-c0359eefba34.png)

## 入力完了後、「保存」

![jenkins](https://cloud.githubusercontent.com/assets/76867/7764723/7b10d89c-0090-11e5-9d68-61ae89bacf66.png)

## プロジェクト設定画面が開きます

![sample2 config jenkins](https://cloud.githubusercontent.com/assets/76867/7764733/9b31d270-0090-11e5-9d04-42dd8a58f685.png)

## 「ビルド後の処理の追加」をクリックします

![sample2 config jenkins](https://cloud.githubusercontent.com/assets/76867/7764747/cd4b408e-0090-11e5-86f0-a4a7e0e626c5.png)

## 「他のプロジェクトのビルド」をクリックします

![sample2 config jenkins](https://cloud.githubusercontent.com/assets/76867/7764778/2309b9ce-0091-11e5-9657-9c299abfab8a.png)

## 「他のプロジェクトのビルド」の設定画面が開きます

![sample2 config jenkins](https://cloud.githubusercontent.com/assets/76867/7764791/5108c284-0091-11e5-932d-c692e681ce9e.png)

## 対象プロジェクトとビルド条件を定義します

+ 対象プロジェクト：呼び出したいプロジェクトを定義します
+ ビルド条件：ビルド条件を選びます。ここでは「安定している場合のみ起動」を選択します

![sample2 config jenkins](https://cloud.githubusercontent.com/assets/76867/7764805/8ae082f8-0091-11e5-8b7f-79959b90b424.png)

## 画面下部の「保存」

![sample2 config jenkins](https://cloud.githubusercontent.com/assets/76867/7764835/e43ee5ce-0091-11e5-8bc1-b3135b8b685c.png)

## プロジェクト画面が表示されます

![sample2 jenkins](https://cloud.githubusercontent.com/assets/76867/7764844/fdc2b6ec-0091-11e5-897b-b120508a77f6.png)

## 左メニューから「ビルド実行」

![sample2 jenkins](https://cloud.githubusercontent.com/assets/76867/7764867/4732952c-0092-11e5-8418-c2315955b47c.png)

## ビルド完了を確認

![sample2 jenkins](https://cloud.githubusercontent.com/assets/76867/7764908/9e37cbee-0092-11e5-9b28-59c8b0ccd9db.png)

## 左メニューから「コンソール出力」

![sample2 1 jenkins](https://cloud.githubusercontent.com/assets/76867/7764923/d854e4ec-0092-11e5-851d-7a852e25bc88.png)

## ビルドログの内容を確認

`Triggering a new build of sample`となっている事に注目します。これは「他のプロジェクトのビルド」で設定した内容が反映されている事を意味しています。

![sample2 1 console jenkins](https://cloud.githubusercontent.com/assets/76867/7764941/02577e12-0093-11e5-8b21-45ca29e9ede4.png)

## 連携ジョブを確認します

![sample2 1 console jenkins](https://cloud.githubusercontent.com/assets/76867/7764982/52e9ca06-0093-11e5-9a9d-fb49f021a5eb.png)

## ビルド履歴を確認します

![sample jenkins](https://cloud.githubusercontent.com/assets/76867/7764993/837f5ac8-0093-11e5-8f9f-50d7038bd7e1.png)

## 最新の履歴を確認します

`上流プロジェクトsample2の#1が実行`となっている事に注目します。sampleを指定したビルドの場合、この様なメッセージは表示されません。ジョブ連携によるビルド実行が行われた場合に表示されます。

![sample 4 jenkins](https://cloud.githubusercontent.com/assets/76867/7765018/de24f938-0093-11e5-8d48-21b2a35ee0e5.png)

ジョブ連携は以上です。今回は成功時の連携だけでしたが、失敗時の連携も可能です。失敗時は失敗原因調査ジョブなどを登録して連携するなどの応用編も可能です。ジョブの特性によって必要な連携が異なるので、臨機応変に対応して下さい。
