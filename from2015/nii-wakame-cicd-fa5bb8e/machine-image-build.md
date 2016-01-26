# マシンイメージビルド

# はじめに

本書はこの後行うシステム全体起動スクリプト作成やIntegrationテストで使用するマシンイメージをビルドするために必要な設定を記述したものである。

# 参考資料

* [Tiny Web Example README](https://github.com/axsh/tiny_web_example/blob/master/README.md)
* 201_WebAPI_コマンドマニュアル
* 202_パラメタ付きビルド

# 前提条件

`201_WebAPI_コマンドマニュアル`を実施しコマンドラインからWakame-vdcのインスタンス及びロードバランサーの操作ができること。

`202_パラメタ付きビルド`を実施し上流プロジェクトから下流プロジェクトへパラメータを引き継がせることができること。

# 動作環境

CentOS-6.6で動作環境を行いました。それよりも古い環境の場合は動作確認してませんので、ご了承下さい。

# マシンイメージの起動

今回起動するマシンイメージはwmi-centos1d64を使用してください。

マシンイメージの起動方法については``201_WebAPI_コマンドマニュアル``を参照してください。

DBサーバ用とWEBサーバ用の2台を起動してください。

# DBサーバ構築

## Mysql Serverのインストール

```
# yum install -y mysql-server
```

実行結果例:

>```
># yum install -y mysql-server
>Loaded plugins: fastestmirror
>Setting up Install Process
>Loading mirror speeds from cached hostfile
> * base: www.ftp.ne.jp
>  * extras: www.ftp.ne.jp
>   * updates: www.ftp.ne.jp
>   Resolving Dependencies
>   --> Running transaction check
>   ---> Package mysql-server.x86_64 0:5.1.73-3.el6_5 will be installed
>   --> Processing Dependency: mysql = 5.1.73-3.el6_5 for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl-DBI for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl-DBD-MySQL for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(vars) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(strict) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(Sys::Hostname) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(POSIX) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(Getopt::Long) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(File::Temp) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(File::Path) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(File::Copy) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(File::Basename) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(Data::Dumper) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: perl(DBI) for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Processing Dependency: /usr/bin/perl for package: mysql-server-5.1.73-3.el6_5.x86_64
>   --> Running transaction check
>   ---> Package mysql.x86_64 0:5.1.73-3.el6_5 will be installed
>   ---> Package perl.x86_64 4:5.10.1-136.el6_6.1 will be installed
>   --> Processing Dependency: perl-libs = 4:5.10.1-136.el6_6.1 for package: 4:perl-5.10.1-136.el6_6.1.x86_64
>   --> Processing Dependency: perl-libs for package: 4:perl-5.10.1-136.el6_6.1.x86_64
>   --> Processing Dependency: perl(version) for package: 4:perl-5.10.1-136.el6_6.1.x86_64
>   --> Processing Dependency: perl(Pod::Simple) for package: 4:perl-5.10.1-136.el6_6.1.x86_64
>   --> Processing Dependency: perl(Module::Pluggable) for package: 4:perl-5.10.1-136.el6_6.1.x86_64
>   --> Processing Dependency: libperl.so()(64bit) for package: 4:perl-5.10.1-136.el6_6.1.x86_64
>   ---> Package perl-DBD-MySQL.x86_64 0:4.013-3.el6 will be installed
>   ---> Package perl-DBI.x86_64 0:1.609-4.el6 will be installed
>   --> Running transaction check
>   ---> Package perl-Module-Pluggable.x86_64 1:3.90-136.el6_6.1 will be installed
>   ---> Package perl-Pod-Simple.x86_64 1:3.13-136.el6_6.1 will be installed
>   --> Processing Dependency: perl(Pod::Escapes) >= 1.04 for package: 1:perl-Pod-Simple-3.13-136.el6_6.1.x86_64
>   ---> Package perl-libs.x86_64 4:5.10.1-136.el6_6.1 will be installed
>   ---> Package perl-version.x86_64 3:0.77-136.el6_6.1 will be installed
>   --> Running transaction check
>   ---> Package perl-Pod-Escapes.x86_64 1:1.04-136.el6_6.1 will be installed
>   --> Finished Dependency Resolution
>
>Dependencies Resolved
>__(省略)__
>
>Installed:
>  mysql-server.x86_64 0:5.1.73-3.el6_5
>
>Dependency Installed:
>  mysql.x86_64 0:5.1.73-3.el6_5                                   perl.x86_64 4:5.10.1-136.el6_6.1
>  perl-DBD-MySQL.x86_64 0:4.013-3.el6                             perl-DBI.x86_64 0:1.609-4.el6
>  perl-Module-Pluggable.x86_64 1:3.90-136.el6_6.1                 perl-Pod-Escapes.x86_64 1:1.04-136.el6_6.1
>  perl-Pod-Simple.x86_64 1:3.13-136.el6_6.1                       perl-libs.x86_64 4:5.10.1-136.el6_6.1
>  perl-version.x86_64 3:0.77-136.el6_6.1
>
>Complete!
>```

## Mysql Serverの起動

```
# service mysqld start
```

実行結果例:

>```
># service mysqld start
>Initializing MySQL database:  Installing MySQL system tables...
>OK
>Filling help tables...
>OK
>
>To start mysqld at boot time you have to copy
>support-files/mysql.server to the right place for your system
>
>PLEASE REMEMBER TO SET A PASSWORD FOR THE MySQL root USER !
>To do so, start the server, then issue the following commands:
>
>/usr/bin/mysqladmin -u root password 'new-password'
>/usr/bin/mysqladmin -u root -h eqh7ig1f password 'new-password'
>
>Alternatively you can run:
>/usr/bin/mysql_secure_installation
>
>which will also give you the option of removing the test
>databases and anonymous user created by default.  This is
>strongly recommended for production servers.
>
>See the manual for more instructions.
>
>You can start the MySQL daemon with:
>cd /usr ; /usr/bin/mysqld_safe &
>
>You can test the MySQL daemon with mysql-test-run.pl
>cd /usr/mysql-test ; perl mysql-test-run.pl
>
>Please report any problems with the /usr/bin/mysqlbug script!
>
>                                                           [  OK  ]
>Starting mysqld:
>```

## Mysql Serverの自動起動設定

現在の設定を確認する

```
# chkconfig --list mysqld
```

実行結果例:

>```
># chkconfig --list mysqld
>mysqld          0:off   1:off   2:off   3:off   4:off   5:off   6:off
>```

自動起動設定を追加

```
# chkconfig mysqld on
```

設定した内容の確認

```
# chkconfig --list mysqld
```

実行結果例:

>```
># chkconfig --list mysqld
>mysqld          0:off   1:off   2:on    3:on    4:on    5:on    6:off
>```

## Mysql Serverの権限設定

```
# mysql -uroot mysql <<EOS
GRANT ALL PRIVILEGES ON tiny_web_example.* TO root@'10.0.22.%';
FLUSH PRIVILEGES;
SELECT * FROM user WHERE User = 'root' \G
EOS
```

実行結果例:

>```
># mysql -uroot mysql <<EOS
>GRANT ALL PRIVILEGES ON tiny_web_example.* TO root@'10.0.22.%';
>FLUSH PRIVILEGES;
>SELECT * FROM user WHERE User = 'root' \G
>EOS
>
>__(省略)__
>
>*************************** 4. row ***************************
>Host: 10.0.22.%
>User: root
>Password:
>Select_priv: N
>Insert_priv: N
>Update_priv: N
>Delete_priv: N
>Create_priv: N
>Drop_priv: N
>Reload_priv: N
>Shutdown_priv: N
>Process_priv: N
>File_priv: N
>Grant_priv: N
>References_priv: N
>Index_priv: N
>Alter_priv: N
>Show_db_priv: N
>Super_priv: N
>Create_tmp_table_priv: N
>Lock_tables_priv: N
>Execute_priv: N
>Repl_slave_priv: N
>Repl_client_priv: N
>Create_view_priv: N
>Show_view_priv: N
>Create_routine_priv: N
>Alter_routine_priv: N
>Create_user_priv: N
>Event_priv: N
>Trigger_priv: N
>ssl_type:
>ssl_cipher:
>x509_issuer:
>x509_subject:
>max_questions: 0
>max_updates: 0
>max_connections: 0
>max_user_connections: 0
>```

## Databaseの作成

```
# mysqladmin -uroot create tiny_web_example --default-character-set=utf8
```

# WEBサーバ構築

WEBサーバの構築については[Tiny Web Example README](https://github.com/axsh/tiny_web_example/blob/master/README.md)を参照してください。

## 各設定ファイルについて

以下の設定ファイルに記述するDBサーバのIPアドレスは全体起動スクリプトでマシンイメージを起動するたびに毎回変わる可能性がありますのでどのように変更するのか考慮する必要があります。

`/etc/tiny-web-example/webapi.conf`

```
# cat /etc/tiny-web-example/webapi.conf
```

実行結果例:

>```
># cat /etc/tiny-web-example/webapi.conf
># Database connection string
>database_uri 'mysql2://localhost/tiny_web_example?user=root'
>```

`/etc/tiny-web-example/webapp.yml`

```
# cat /etc/tiny-web-example/webapp.yml
```

実行結果例:

>```
># cat /etc/tiny-web-example/webapp.yml
>database_uri: 'mysql2://localhost/tiny_web_example?user=root'
>```

# マシンイメージのバックアップ

マシンイメージのバックアップについては`201_WebAPI_コマンドマニュアル`を参照してください。

# Jenkinsを使用したイメージ作成の自動化

上流プロジェクトと下流プロジェクトへの連携については`202_パラメタ付きビルド`を参照してください。

「Predefined Parameters」を使用して下流プロジェクトへパラメータを引き継がせる場合、引き継がせることのできる対象はJenkinsが設定した環境変数とプロジェクトで設定したパラメータになります。

上流プロジェクトのシェルの実行で実行した実行結果などを下流プロジェクトへパラメータとして引き継がせたい場合は「Predefined Parameters」では引き継がせることができません。

ここでは上流プロジェクトのシェルの実行で実行した結果を一度外部ファイルに書き込んで下流プロジェクトで使用する方法を記述します。

## 上流プロジェクトの設定

まずは上流プロジェクト「parent」の設定を行います。

### シェルの実行

以下の例ではシェルの実行の結果「DB_IMAGE_ID」と「APP_IMAGE_ID」を取得したものとして「${WORKSPACE}/${BUILD_TAG}」というファイルに書き込んでいます。

![parent-shell-exec](https://cloud.githubusercontent.com/assets/380254/7880370/dacf466c-0633-11e5-97ab-2342d721e520.png)

```
#!/bin/bash
env | sort

DB_IMAGE_ID="wmi-btwx76n2"
APP_IMAGE_ID="wmi-nv50354s"

echo "DB_IMAGE_ID=${DB_IMAGE_ID}"   >  ${WORKSPACE}/${BUILD_TAG}
echo "APP_IMAGE_ID=${APP_IMAGE_ID}" >> ${WORKSPACE}/${BUILD_TAG}
```

### Predefined Parametersの設定

ここでは先ほど書き込んだファイルのパスを「source_file」という変数に入れて下流ジョブに引き継がせています。

![parent-predefined-parameter](https://cloud.githubusercontent.com/assets/380254/7880384/eb576b22-0633-11e5-967e-b7193a3da03f.png)

```
source_file=${WORKSPACE}/${BUILD_TAG}
```

## 下流ジョブの設定

ここでは上流プロジェクトから引き継がれた「source_file」をcatコマンドを使って中身を表示しています。

![child-shell-exec](https://cloud.githubusercontent.com/assets/380254/7880397/fcaac892-0633-11e5-8c5f-9cb9f90fd2bc.png)

```
#!/bin/bash
env | sort

cat $source_file
```

## ジョブの実行

ジョブを実行して下流ジョブ「child」のコンソール出力を見ると先ほど書き込んだファイルの内容が表示されています。

![child-console-log](https://cloud.githubusercontent.com/assets/380254/7880511/308f3052-0635-11e5-8007-32bfb5e5ad5b.png)

