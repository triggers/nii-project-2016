# パラメタ付きビルド

# プロジェクトにビルドパラメータを指定

例えばコマンドラインからコマンドに引数指定出来るように、プロジェクトビルド時に引数指定が可能です。Jenkinsでは「ビルドパラメータ」として実装されています。ビルド時にパラメタ指定すると、プロジェクト内からパラメタを参照する事が可能になります。例えばシェルスジョブからパラメタ参照が可能です。本書では、パラメタ設定方法とパラメタ指定ビルドをしてみます。

## プロジェクトを作成します

既存プロジェクトを使った設定も可能です。ここではプロジェクトを新規作成して説明して行きます。

![jenkins](https://cloud.githubusercontent.com/assets/76867/7859583/6357f9dc-057d-11e5-8797-28db51b12779.png)

## 「ビルドのパラメータ化」をチェックします

プロジェクト設定画面の上部にある「ビルドのパラメータ化」をチェックします。

![parameterise config jenkins](https://cloud.githubusercontent.com/assets/76867/7859620/8fc940a2-057d-11e5-9079-821f83871eb8.png)

## 次に「パラメータの追加」を開きます

チェック後、「パラメータの追加」セレクトボックスが出現するので、セレクトボックスを開きます。

![parameterise config jenkins](https://cloud.githubusercontent.com/assets/76867/7859637/affd63b2-057d-11e5-86c8-36a9154d898e.png)

## 「文字列」を指定します

パラメータの種類を選択します。ここでは一番よく使われる「文字列」を選択して説明します。

![parameterise config jenkins](https://cloud.githubusercontent.com/assets/76867/7859646/cfbd6580-057d-11e5-9491-6f7d2f9313c3.png)

## パラメータの設定フォームが出現します

パラメータの種類を選択すると、パラメータの設定フォームが出現します。

![parameterise config jenkins](https://cloud.githubusercontent.com/assets/76867/7859657/ee61ad8e-057d-11e5-9827-e3dd389345fc.png)

## 「名前」が入力必須項目です

「名前」には`PARAM1`を指定します。「デフォルト値」と「説明」は省略可能です。

![parameterise config jenkins](https://cloud.githubusercontent.com/assets/76867/7859673/129b8f76-057e-11e5-9aad-60941a240b5a.png)

## パラメータを参照します

設定したパラメータは、シェルスクリプト内から参照可能です。先程、パラメータ名に指定した「PARAM1」を参照出来る事を確認する為、echoコマンドで標準出力させます。

```
echo PARAM1=$PARAM1
```
![parameterise config jenkins](https://cloud.githubusercontent.com/assets/76867/7859729/7cb9c224-057e-11e5-9a8c-50376eab1e0c.png)

## 関連図

![parameterise config jenkins](https://cloud.githubusercontent.com/assets/76867/7859713/52b99800-057e-11e5-84fe-b1d79961c4bc.png)

## 「保存」すると、プロジェクト画面に「パラメータ付きビルド」

パラメータ無しプロジェクトの場合は「ビルドの実行」でした。パラメータ設定ありプロジェクトの場合は、「パラメータ付ビルド」となっています。

![parameterise jenkins](https://cloud.githubusercontent.com/assets/76867/7859751/9e6ec1a8-057e-11e5-8fbd-b89480940ade.png)

## 「パラメータ付きビルド」すると、ビルド時にパラメータ入力を求めて来ます

パラメータなしプロジェクトの場合は、直ぐに実行開始したビルドですが、パラメータ付きプロジェクトの場合はパラメータ入力値を問い合せて来ます。

![jenkins](https://cloud.githubusercontent.com/assets/76867/7859778/b8461a40-057e-11e5-95e8-f34bf8f3fcd9.png)

## パラメータを指定し、ビルドしてみます

パラメータを指定したら、ビルドを開始します。

![jenkins](https://cloud.githubusercontent.com/assets/76867/7859802/d6f62412-057e-11e5-865d-76abf491f85b.png)

## ビルド後のコンソール出力を確認してみます

ビルド時に指定したパラメータの内容が出力されました。

![parameterise 1 console jenkins](https://cloud.githubusercontent.com/assets/76867/7859823/017ce338-057f-11e5-99cb-db0fecc17da5.png)

## ここまでのまとめ

この例ではシェルジョブから参照しましたが、他のジョブとの連携も可能です。パラメータ付きビルドを上手く利用すると、ビルドの柔軟性が増すので是非活用してみて下さい。

# 下流プロジェクトにビルドパラメータを渡す

パラメータ付きプロジェクトとの連携においても、パラメータ指定が可能です。Jenkinsのコア機能では実現できませんが、プラグインをインストールすると実現出来ます。プラグインのインストール方法と、ビルドパラメータの引き渡し方法を設定してみます。

## 「Parameterized Trigger Plugin」のインストール

プラグインの管理から「Parameterized Trigger Plugin」を選択しインストールし、Jenkinsを再起動して下さい。

![jenkins](https://cloud.githubusercontent.com/assets/76867/7858352/8e45ba90-0572-11e5-9c35-0977f7e547b3.png)

## 下流プロジェクトの作成

パラメータ付きプロジェクトを作成します。作成方法に関しては、先述の「プロジェクトにビルドパラメータを指定」手順に従って下さい。先述手順で作成したプロジェクトをそのまま使っても構いません。新規でプロジェクトを作成する場合は、パラメータ名には同じく「PARAM1」で設定して下さい。上流プロジェクトとの連携する際に、パラメータ名が重要な設定項目となります。

## 上流プロジェクトの作成

上流プロジェクトを作成します。上流プロジェクトは、パラメータ無しで良いです。「ビルド後の処理の追加」から「Trigger parameterized build on other projects」を選択します。

![parent config jenkins](https://cloud.githubusercontent.com/assets/76867/7858993/ea68a044-0577-11e5-8454-a5785c9ee5ab.png)

## 「ビルド後の処理」設定フォームが出現します

![parent config jenkins](https://cloud.githubusercontent.com/assets/76867/7859021/1d5cefbe-0578-11e5-946e-ae8240ed8350.png)

## 「Project to build」に下流プロジェクトを設定します

「Project to build」にビルド対象のプロジェクトを設定します。

![parent config jenkins](https://cloud.githubusercontent.com/assets/76867/7859053/5f68f948-0578-11e5-80e2-d1e5c92799cd.png)

## 「Add Parameters」を開き「Predefined parameters」を選択します

「Add Parameters」を設定すると、下流プロジェクトにパラメータを指定出来ます。指定可能なパラメータにはいくつかあります。今回は下流プロジェクトのパラメータ名「PARAM1」を設定する事が目的なので、「Predefined parameters」を選択します。

![parent config jenkins](https://cloud.githubusercontent.com/assets/76867/7859090/addcbe7a-0578-11e5-9968-9cecabc2b892.png)

## 「Predefined parameters」設定フォームが出現します

「Predefined parameters」設定フォームが出現するので、パラメータを定義して行きます。`パラメータ名=値`でパラメータを定義可能です。

```
PARAM1="build by parent"
```

![parent config jenkins](https://cloud.githubusercontent.com/assets/76867/7859163/4f438258-0579-11e5-97a7-0678de99045a.png)

## 「保存」し、ビルド。ビルド結果を確認

保存したらビルドします。ビルドが完了したら、コンソール出力を確認します。プロジェクト連携が成功している事が分かります。

![parent 1 console jenkins](https://cloud.githubusercontent.com/assets/76867/7859219/d3bfa26e-0579-11e5-9a4d-734a61fac837.png)

## 次に下流プロジェクトのビルド結果を確認します

コンソール出力から2つの項目に注目します。1つは上流プロジェクトとビルド番号、2つ目はビルド結果に`PARAM1="build by parent"`が出力されている事です。上流プロジェクトで設定した「Predefined parameters」により、下流プロジェクトはビルドパラメータとして受け取り、ビルドした事が分かります。

![parameterise 2 console jenkins](https://cloud.githubusercontent.com/assets/76867/7859425/dff1faa8-057b-11e5-855a-e75d09fc0041.png)

## ここまでのまとめ

ビルドパラメータ付きプロジェクト連携によるビルドを行いました。2プロジェクト間の連携までですが、3つ以上のプロジェクトを連携させる事により、より複雑で柔軟なビルドパイプライン構築が可能です。ビルド対象に合わせた臨機応変な対応と共に是非挑戦してみて下さい。
