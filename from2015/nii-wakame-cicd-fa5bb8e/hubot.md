# Hubot インストール

# はじめに

本書ではHubot環境の構築手順です。他ツールとの連携に関しては別紙で扱います。

# 動作環境

CentOS-6.6で動作環境を行いました。それよりも古い環境の場合は動作確認してませんので、ご了承下さい。

# Hubotのインストール

HubotはCoffeeScriptで書かれているので、CoffeeScript実行環境を構築します。CentOSのbaseリポジトリには存在しないので、EPELリポジトリを利用してインストールします。

## EPEL環境の構築

### epel-releaseのインストール

```
$ sudo rpm -Uvh \
 http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm
```

実行結果例：

> ```
> $ sudo rpm -Uvh  http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm
> Retrieving http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/6/i386/epel-release-6-8.noarch.rpm
> warning: /var/tmp/rpm-tmp.cxtrqJ: Header V3 RSA/SHA256 Signature, key ID 0608b895: NOKEY
> Preparing...                ########################################### [100%]
>    1:epel-release           ########################################### [100%]
> ```

### baseurlの調整

初期設定では、ミラーリストから最寄りのミラーサイトが選択されます。ミラーサイト選択の精度は良いは言えません。そこで、日本国内jaistを指定します。

```
$ sudo sed -i \
  -e 's,^#baseurl,baseurl,' \
  -e 's,^mirrorlist=,#mirrorlist=,' \
  -e 's,http://download.fedoraproject.org/pub/epel/,http://ftp.jaist.ac.jp/pub/Linux/Fedora/epel/,' \
  /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel-testing.repo
```

### リポジトリリストの確認

epelリポジトリが有効になった事を確認します。

```
$ sudo yum repolist
```

実行結果例：

> ```
> $ sudo yum repolist
> Loaded plugins: fastestmirror
> Loading mirror speeds from cached hostfile
>  * base: ftp.nara.wide.ad.jp
>  * extras: www.ftp.ne.jp
>  * updates: ftp.nara.wide.ad.jp
> repo id          repo name                                                status
> base             CentOS-6.6 - Base                                         6,518
> epel             Extra Packages for Enterprise Linux 6 - x86_64           11,371
> extras           CentOS-6.6 - Extras                                          37
> updates          CentOS-6.6 - Updates                                        965
> repolist: 18,891
> ```

`epel`が表示されていれば、`epel`リポジトリは有効です。

## nodejsのインストール

nodejsをインストールします。それと、Hubotが依存するパケージもインストールします。

```
$ sudo yum install -y nodejs npm redis libicu-devel
```

実行結果例：

> ```
> $ sudo yum install -y nodejs npm redis libicu-devel
Loaded plugins: fastestmirror
Setting up Install Process
Loading mirror speeds from cached hostfile
 * base: ftp.nara.wide.ad.jp
 * extras: www.ftp.ne.jp
 * updates: ftp.nara.wide.ad.jp
Resolving Dependencies
--> Running transaction check
---> Package libicu-devel.x86_64 0:4.2.1-9.1.el6_2 will be installed
> ...(省略)...
> Complete!
> ```

ネットワーク帯域に依存しますが、1～2分で完了します。

## npmによるインストール

### Hubotのインストール

hubot関連パッケージは、nodejsパッケージ専用ツール`npm`でインストールします。

```
$ sudo npm install -g coffee-script hubot
```

実行結果例：

> ```
> $ sudo npm install -g coffee-script hubot
> npm http GET https://registry.npmjs.org/coffee-script
> npm http GET https://registry.npmjs.org/hubot
> ...(省略)...
> hubot@2.12.0 /usr/lib/node_modules/hubot
> ├── optparse@1.0.4
> ├── log@1.4.0
> ├── cline@0.8.2
> ├── scoped-http-client@0.10.3
> ├── coffee-script@1.6.3
> ├── chalk@1.0.0 (escape-string-regexp@1.0.3, ansi-styles@2.0.1, supports-color@1.3.1, has-ansi@1.0.3, strip-ansi@2.0.1)
> ├── connect-multiparty@1.2.5 (qs@2.2.5, on-finished@2.1.1, multiparty@3.3.2, type-is@1.5.7)
└── express@3.18.1 (basic-auth@1.0.0, utils-merge@1.0.0, merge-descriptors@0.0.2, fresh@0.2.4, cookie@0.1.2, escape-html@1.0.1, range-parser@1.0.2, cookie-signature@1.0.5, vary@1.0.0, media-typer@0.3.0, methods@1.1.0, parseurl@1.3.0, content-disposition@0.5.0, depd@1.0.1, commander@1.3.2, debug@2.1.3, etag@1.5.1, proxy-addr@1.0.7, mkdirp@0.5.0, send@0.10.1, connect@2.27.1)
> ```

ネットワーク帯域に依存しますが、3～4分で完了します。

### プロジェクトセットアップツールのインストール

Hubotプロジェクトをセットアップする為のツールをインストールします。

```
$ sudo npm install -g yo generator-hubot
```

> ```
> $ sudo npm install -g yo generator-hubot
> npm http GET https://registry.npmjs.org/yo
> npm http GET https://registry.npmjs.org/generator-hubot
> ...(省略)...
> generator-hubot@0.3.0 /usr/lib/node_modules/generator-hubot
> ├── chalk@0.5.1 (escape-string-regexp@1.0.3, ansi-styles@1.1.0, supports-color@0.2.0, strip-ansi@0.3.0, has-ansi@0.1.0)
> ├── yosay@0.3.0 (ansi-regex@0.2.1, string-length@0.1.2, ansi-styles@1.1.0, pad-component@0.0.1, word-wrap@0.1.3, minimist@0.2.0, strip-ansi@0.2.2, chalk@0.4.0, taketalk@0.1.1)
> ├── npm-name@1.0.4 (log-symbols@1.0.2, registry-url@3.0.3, got@2.7.2)
> └── yeoman-generator@0.17.7 (dargs@2.1.0, rimraf@2.3.2, diff@1.3.2, class-extend@0.1.1, text-table@0.2.0, mime@1.3.4, underscore.string@2.4.0, async@0.9.0, debug@1.0.4, grouped-queue@0.3.0, nopt@3.0.1, isbinaryfile@2.0.3, cross-spawn@0.2.9, run-async@0.1.0, shelljs@0.3.0, mkdirp@0.5.0, iconv-lite@0.4.7, glob@4.5.3, github-username@1.1.1, file-utils@0.2.2, lodash@2.4.1, findup-sync@0.1.3, request@2.55.0, download@1.0.7, cheerio@0.17.0, gruntfile-editor@0.2.0, inquirer@0.7.3)
> ```

ネットワーク帯域に依存しますが、10分前後で完了します。
