# Hubot HipChatへの参加

# Hubotプロジェクトのセットアップ

Hubot専用プロジェクトをセットアップします。rootユーザーではなく、専用アカウントを作るか既存アカウントに切り替えて対応して下さい。

## ユーザーを切り替える

作成したインスタンスには、`wakame-vdc`アカウントが作成されています。これを使うと、新規作成する事がありません。

`wakame-vdc`に切り替える：

```
# su - wakame-vdc
```

次に、切り替わった事を確認します。

```
$ whoami
```

実行結果例：

> ```
> $ whoami
> wakame-vdc
> ```

`wakame-vdc`ユーザーに切り替わりました。

## プロジェクトディレクトリの作成

ディレクトリ名は、お好みのディレクトリで構いません。下記では`mybot`として説明します。

```
$ mkdir mybot
$ cd mybot
```

## Hubotプロジェクトのセットアップ

プロジェクトのセットアップは、下記コマンドを実行すると完了します。なお、後述のHipChat連携を想定し、HipChatアダプタ指定でセットアップします。

```
$ yo hubot \
 --adapter=hipchat \
 --name=hubot \
 --owner=hubot \
 --description=hubot \
 <<< "Y"
```

実行結果例：

> ```
> $ yo hubot \
>  --adapter=hipchat \
>  --name=hubot \
>  --owner=hubot \
>  --description=hubot \
>  <<< "Y"
> ? ==========================================================================
> We're constantly looking for ways to make yo better!
> May we anonymously report usage statistics to improve the tool over time?
> More info: https://github.com/yeoman/insight & http://yeoman.io
> ========================================================================== Yes
>                      _____________________________
>                     /                             \
>    //\              |      Extracting input for    |
>   ////\    _____    |   self-replication process   |
>  //////\  /_____\   \                             /
>  ======= |[^_/\_]|   /----------------------------
>   |   | _|___@@__|__
>   +===+/  ///     \_\
>    | |_\ /// HUBOT/\\
>    |___/\//      /  \\
>          \      /   +---+
>           \____/    |   |
>            | //|    +===+
>             \//      |xx|
> 
>    create bin/hubot
>    create bin/hubot.cmd
>    create Procfile
>    create README.md
>    create external-scripts.json
>    create hubot-scripts.json
>    create .gitignore
>    create package.json
>    create scripts/example.coffee
>    create .editorconfig
>                      _____________________________
>  _____              /                             \
>  \    \             |   Self-replication process   |
>  |    |    _____    |          complete...         |
>  |__\\|   /_____\   \     Good luck with that.    /
>    |//+  |[^_/\_]|   /----------------------------
>   |   | _|___@@__|__
>   +===+/  ///     \_\
>    | |_\ /// HUBOT/\\
>    |___/\//      /  \\
>          \      /   +---+
>           \____/    |   |
>            | //|    +===+
>             \//      |xx|
> 
> ...(省略)...
> hubot-hipchat@2.7.5 node_modules/hubot-hipchat
> ├── rsvp@1.2.0
> ├── underscore@1.4.4
> └── node-xmpp@0.12.2 (browser-request@0.3.3, faye-websocket@0.9.4, ltx@0.9.0, request@2.55.0, brfs@0.0.8, node-xmpp-component@0.1.1, node-xmpp-server@0.3.5, node-xmpp-core@0.3.3, node-xmpp-client@0.1.9, browserify@3.19.1, node-expat@2.3.7)
> ```

セットアップ処理は10分程度で完了します。

## HubotプロジェクトをGitで管理

※必要な人のみ設定して下さい※

HubotプロジェクトはGitによるバージョン管理が可能です。今回セットアップした環境ではなく、別環境で同じプロジェクトをデプロイする事により、同じプロジェクト環境を簡単にセットアップ出来ます。クラウド基盤やデプロイツールと連携する事により、簡単に自分好みのHubotプロジェクトをセットアップ出来ます。

```
$ git init
$ git add .
$ git commit -m 'first commit' .
```

実行結果例：

> ```
> $ git init
> Initialized empty Git repository in /home/wakame-vdc/mybot/.git/
> $ git add .
> $ git commit -m 'first commit' .
> [master (root-commit) 2eef3bb] first commit
>  10 files changed, 387 insertions(+), 0 deletions(-)
>  create mode 100644 .editorconfig
>  create mode 100644 .gitignore
>  create mode 100644 Procfile
>  create mode 100644 README.md
>  create mode 100755 bin/hubot
>  create mode 100644 bin/hubot.cmd
>  create mode 100644 external-scripts.json
>  create mode 100644 hubot-scripts.json
>  create mode 100644 package.json
>  create mode 100644 scripts/example.coffee
> ```

後はGitHub等のGitホスティングサービスに`git push`するだけです。

参考例：

```
$ git remote add origin git@github.com:.../...
$ git push -u origin master
```

# HubotとHipChatの連携

## 環境変数の設定

`bin/hubot`がHubotを起動するラッパースクリプトとなっています。初期状態では、他ツールとの連携用設定は未設定です。HipChat連携を想定した設定を追加して行きます。

+ `HUBOT_HIPCHAT_JID`: XMPP/Jabberアカウント情報で取得します。
+ `HUBOT_HIPCHAT_PASSWORD`: 平文パスワード(管理は気を付けて下さい)

```
$ export HUBOT_HIPCHAT_JID="*****@chat.hipchat.com"
$ export HUBOT_HIPCHAT_PASSWORD="*****“
```

## Hubotの起動

`-a hipchat`でHipChatアダプタ指定でHubotを起動します。

```
$ ./bin/hubot -a hipchat
```

実行結果例：

> ```
> $ ./bin/hubot -a hipchat
> [Mon Apr 13 2015 15:29:34 GMT+0900 (JST)] INFO Connecting HipChat adapter...
> [Mon Apr 13 2015 15:29:43 GMT+0900 (JST)] INFO Connected to hipchat.com as @hubot
> [Mon Apr 13 2015 15:29:43 GMT+0900 (JST)] ERROR hubot-heroku-alive included, but missing HUBOT_HEROKU_KEEPALIVE_URL. `heroku config:set HUBOT_HEROKU_KEEPALIVE_URL=$(heroku apps:info -s  | grep web_url | cut -d= -f2)`
> [Mon Apr 13 2015 15:29:43 GMT+0900 (JST)] INFO Using default redis on localhost:6379
> [Mon Apr 13 2015 15:29:44 GMT+0900 (JST)] INFO Joining *****@conf.hipchat.com
> ```

HubotがChatルームにログインしてる事を確認して下さい。

## Hubotの停止

Hubotはフォアグラウンドで起動しているので、Ctrl-c(コントロールを押しながらc)で停止します

# HubotとJenkinsの連携

## `hubot-scripts.json`の修正

Jenkinsと連携するには、Jenkins用hubot-scriptを読み込む必要があります。

```
$ vi hubot-scripts.json
```

```
["jenkins.coffee"]
```

## 差分を確認

```
$ git diff hubot-scripts.json
```

実行結果例：

> ```
> $ git diff hubot-scripts.json
> diff --git a/hubot-scripts.json b/hubot-scripts.json
> index 0637a08..890933e 100644
> --- a/hubot-scripts.json
> +++ b/hubot-scripts.json
> @@ -1 +1 @@
> -[]
> \ No newline at end of file
> +["jenkins.coffee"]
> ```

## 変更内容をコミット

`hubot-scripts.json`はGitでバージョン管理しているので、変更内容をコミットしておきます。

```
$ git commit -m 'add jenkins.coffee.' hubot-scripts.json
```

実行結果例：

> ```
> $ git commit -m 'add jenkins.coffee.' hubot-scripts.json
> [master 09b71a4] add jenkins.coffee.
>  1 files changed, 1 insertions(+), 1 deletions(-)
> ```

## 環境変数の設定

HipChat連携設定と同様に環境変数を設定します。

+ `HUBOT_JENKINS_URL`: Hubotが接続するJenkinsのURL

```
$ export HUBOT_JENKINS_URL=http://127.0.0.1:8080/
```

## Hubotの起動

`-a hipchat`でHipChatアダプタ指定でHubotを起動します。

```
$ ./bin/hubot -a hipchat
```

実行結果例：

> ```
> $ ./bin/hubot -a hipchat
> [Mon Apr 13 2015 15:42:24 GMT+0900 (JST)] INFO Connecting HipChat adapter...
> [Mon Apr 13 2015 15:42:33 GMT+0900 (JST)] INFO Connected to hipchat.com as @hubot
> [Mon Apr 13 2015 15:42:33 GMT+0900 (JST)] ERROR hubot-heroku-alive included, but missing HUBOT_HEROKU_KEEPALIVE_URL. `heroku config:set HUBOT_HEROKU_KEEPALIVE_URL=$(heroku apps:info -s  | grep web_url | cut -d= -f2)`
> [Mon Apr 13 2015 15:42:33 GMT+0900 (JST)] INFO Using default redis on localhost:6379
> [Mon Apr 13 2015 15:42:34 GMT+0900 (JST)] INFO Joining 312093_wakame@conf.hipchat.com
> ```

JenkinsのリモートAPIを呼び出す準備が整いました。

# HubotとHipChatとJenkinsの結合

HubotとHipChat、そしてHubotとJenkins、2つの連携を行ってきました。最後に3つを結合します。期待する動作は、HipChatからHubotを経由してJenkinsのジョブをビルドする事です。

1. HipChatからHubotに命令
2. 命令を受け取ったHubotは、JenkinsのリモートAPIを呼び出す
3. HubotはJenkinsリモートAPI呼び出し結果を、HipChatに報告

## HipChatにログイン

ログインし、Hubotがオンラインになっている事を確認しておきます。右メニューにチャット参加者が表示されている事が分かります。

![](https://cloud.githubusercontent.com/assets/76867/7111253/42956926-e1f8-11e4-8311-4feaa3d39def.png)

## ジョブリストの表示

Jenkinsに登録されているジョブリストを表示してみます。`@mention`でHubotを指定します。以下の例では、Hubotを`@hubot`で指定しています。設定に依存するので、お手元の環境に合わせて読み替えて下さい。

ジョブリスト表示は、`jenkins list`です。

```
@hubot jenkins list
```

実行結果例：

![](https://cloud.githubusercontent.com/assets/76867/7111265/7404a12a-e1f8-11e4-9f24-daa26874869a.png)

上記例では、5つのジョブが登録されている事を示しています。

## ジョブのビルド

特定のジョブをビルドしてみます。

ジョブのビルドは、`jenkins build <job>`です。ジョブ名`sample`をビルドしてみます。

```
@hubot jenkins build sample
```

実行結果例：

![](https://cloud.githubusercontent.com/assets/76867/7111276/9f86fed8-e1f8-11e4-9dd0-f82e995b2a62.png)

## ジョブの概要表示

```
@hubot jenkins describe <job>
```

実行結果例：

![](https://cloud.githubusercontent.com/assets/76867/7111281/c6e9d0cc-e1f8-11e4-89be-446832ff5f54.png)
