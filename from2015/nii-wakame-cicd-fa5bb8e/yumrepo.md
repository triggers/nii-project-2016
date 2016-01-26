# YUM リポジトリの準備

# はじめに

yumリポジトリ作成手順を学ぶには、最小構成のyumリポジトリを作ってみる事が一番の近道です。本章では、実際に最小構成yumリポジトリを作りながらyumリポジトリ構築の基礎を学んで行きます。

# 前提条件

本書は「RPM 生成方法」の続編とも言うべき内容で、`example-0.1.0.rpm`が生成済みである事を前提に説明して行きます。

# 何故Yumなのか?

rpmファイルを効率良く管理するには、yumの力を借りる事です。それは何故でしょうか？主に3つの理由があります。

1. 依存関係の解決
2. rpmファイル配置場所の意識
3. バージョンの解決

それぞれの理由を少し掘り下げてみます。

## 理由1: 依存関係の解決

rpmspecファイルには依存関係を定義出来ますが、rpmコマンドで依存パッケージのインストールまでは面倒見てくれません。それに対し、yumコマンドは依存パッケージのインストールまで面倒見てくれます。

## 理由2: rpmファイル配置場所の意識

rpmコマンドでrpmファイルをインストールする場合、rpmファイルの場所を意識する必要があります。以下に例を示します。

```
$ sudo rpm -ivh /var/www/html/pub/example-0.1.0-1.el6.x86_64.rpm
$ sudo rpm -ivh http://ftp.example.com/pub/example-0.1.0-1.el6.x86_64.rpm
$ sudo rpm -ivh ftp://ftp.example.com/pub/example-0.1.0-1.el6.x86_64.rpm
```

yumコマンドの場合は、yumリポジトリを事前設定しておく事により、rpmファイルの場所を意識する事無くインストールが可能です。

```
$ sudo yum install -y example
```

パッケージ数が1つや2つ程度であれば大した問題にはなりませんが、数十から数百も扱う場合は、管理運用コストが高くなります。

## 理由3: バージョン情報

yumリポジトリ内に複数バージョンのパッケージが存在する場合も上手に扱ってくれます。仮に`example-0.1.0`と`example-0.2.0`が存在しているとします。バージョンを意識したインストールの場合は、`パッケージ名-バージョン`でインストール可能です。

```
$ sudo yum install -y example-0.1.0
$ sudo yum install -y example-0.2.0
```

また、`パッケージ名`のみ指定する事も可能です。

```
$ sudo yum install -y example
```

さて、この場合、どのバージョンがインストールされるでしょうか？答えは、`example-0.2.0`です。yumはリポジトリ内にどのバージョンが最新であるかを判断してインストールを行います。この仕組みは、新しいパッケージを配布したい時に有効な手段です。同じインストールコマンドを使い、常に最新バージョンをインストール可能です。インストール手順を定義する際にも役立ちます。

## ここまでのまとめ

3つの理由を踏まえると、もはやyumを利用しない理由が見当たりません。

# Yumリポジトリ公開に必要なもの

Yumリポジトリを公開するには、3つの要素が必要です。

1. 公開するrpmファイル
2. Yumリポジトリ
3. Yumリポジトリ用repoファイル

# 環境構築

## Yumリポジトリ環境の構築

Yumリポジトリを構築するには`createrepo`が必要です。また、YumリポジトリをHTTPで公開する為に、`httpd`をインストールします。yumはFTPもサポートしているのでFTPでも構いませんが、本書ではHTTPで公開する事を前提に進めます。

```
$ sudo yum install -y createrepo httpd
```

実行結果例：

> ```
> $ sudo yum install -y createrepo httpd
> Loaded plugins: fastestmirror
> Setting up Install Process
> Determining fastest mirrors
>  * base: ftp.riken.jp
>  * extras: ftp.riken.jp
>  * updates: ftp.riken.jp
> ...(省略)...
> Complete!
> ```

## パッケージ公開用のHTTPD

### httpdの起動

yumコマンドによるhttpdパッケージのインストールでは、サービス起動ませんので、httpdサービスを起動します。

```
$ sudo service httpd start
```

実行結果例：

> ```
> $ sudo service httpd start
> Starting httpd: httpd: apr_sockaddr_info_get() failed for vagrant-centos6
> httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1 for ServerName
>                                                            [  OK  ]
> ```

### 自動起動の有効化

パッケージインストール直後の初期設定では、システム起動時の自動起動が無効化されています。今回の用途においては、システム起動時に自動起動して欲しいので、自動起動を有効化します。

#### 自動起動有効化前の内容確認

設定変更前の自動起動設定を確認してみます。

```
$ chkconfig --list httpd
```

実行結果例：

> ```
> $ chkconfig --list httpd
> httpd           0:off   1:off   2:off   3:off   4:off   5:off   6:off
> ```

`3:off`となっており、自動起動が無効化されています。

#### 自動起動の有効化

自動起動を有効化します。

```
$ sudo chkconfig httpd on
```

実行結果例：

> ```
> $ sudo chkconfig httpd on
> ```

#### 自動起動有効化の確認

自動起動が有効化されてる事を確認します。

```
$ chkconfig --list httpd
```

実行結果例：

> ```
> $ chkconfig --list httpd
> httpd           0:off   1:off   2:on    3:on    4:on    5:on    6:off
> ```

`3:on`となっており、自動起動が有効化されました。これで次回のシステム起動から、httpdが自動起動します。

# 独自Yumリポジトリの構築

## 公開用ディレクトリの準備

Yumリポジトリ公開用ディレクトリを準備します。本書では`/pub/`を公開用ディレクトリとして使用します。

```
$ sudo mkdir -p /var/www/html/pub
```

実行結果例：

> ```
> $ sudo mkdir -p /var/www/html/pub
> ```

```
$ ls -l /var/www/html/pub/
```

実行結果例：

> ```
> $ ls -l /var/www/html/pub/
> total 0
> ```

## rpmファイルの確認

事前にyumリポジトリに登録するrpmファイルを確認しておきます。「RPM 生成方法」で生成した`example-0.1.0-1.el6.x86_64.rpm`があるはずです。

```
$ ls -l ${HOME}/rpmbuild/RPMS/x86_64/example-0.1.0-1.el6.x86_64.rpm
```

> ```
> $ ls -l ${HOME}/rpmbuild/RPMS/x86_64/example-0.1.0-1.el6.x86_64.rpm
> -rw-r--r-- 1 vagrant vagrant 1767 Apr 15 19:20 /home/vagrant/rpmbuild/RPMS/x86_64/example-0.1.0-1.el6.x86_64.rpm
> ```

## RPMSを/var/www/html/pub/に配置

```
$ cd ${HOME}/rpmbuild/RPMS/
```

rpmファイルを公開用ディレクトリに配置します。配置作業はrsyncで行います。

```
$ sudo rsync -avx . /var/www/html/pub/
```

実行結果例：

> ```
> $ sudo rsync -avx . /var/www/html/pub/
> sending incremental file list
> ./
> x86_64/
> x86_64/example-0.1.0-1.el6.x86_64.rpm
>
> sent 1925 bytes  received 38 bytes  3926.00 bytes/sec
> total size is 1767  speedup is 0.90
> ```

rpmファイルが配置された事を確認します。

```
$ ls -l /var/www/html/pub/x86_64/example-0.1.0-1.el6.x86_64.rpm
```

実行結果例：

> ```
> $ ls -l /var/www/html/pub/x86_64/example-0.1.0-1.el6.x86_64.rpm
> -rw-r--r-- 1 vagrant vagrant 1767 Apr 15 19:20 /var/www/html/pub/x86_64/example-0.1.0-1.el6.x86_64.rpm
> ```

## yumリポジトリの構築

yumリポジトリを構築するには`createrepo`コマンドを使います。

### ディレクトリの移動

`createrepo`コマンドを実行する前に、ディレクトリを移動しておく必要があります。

```
$ cd /var/www/html/pub
```

### `createrepo`コマンドの実行

`createrepo`コマンドを実行します。

```
$ sudo createrepo .
```

実行結果例：

> ```
> $ sudo createrepo .
> Spawning worker 0 with 1 pkgs
> Workers Finished
> Gathering worker results
>
> Saving Primary metadata
> Saving file lists metadata
> Saving other metadata
> Generating sqlite DBs
> Sqlite DBs complete
> ```

実行すると、`repodata`ディレクトリが生成されます。

```
$ ls -l repodata/
```

実行結果例：

> ```
> total 36
> drwxr-xr-x 2 root    root    4096 Apr 27 15:44 .
> drwxr-xr-x 4 vagrant vagrant 4096 Apr 27 15:44 ..
> -rw-r--r-- 1 root    root     232 Apr 27 15:44 21f3ad602df029deeb143d8c75df67e18c0ce2036e76e9e94d42479f6d7302a5-other.xml.gz
> -rw-r--r-- 1 root    root     268 Apr 27 15:44 2c14a8b954d727e5106e5646f99cf3ab65d1ceaff77173bc4038107fc3c791b1-filelists.xml.gz
> -rw-r--r-- 1 root    root     748 Apr 27 15:44 711c22507ef9815a06e9f9bf888f3468c9b98f1fa1f65aed1ff78ae27e0d6c62-filelists.sqlite.bz2
> -rw-r--r-- 1 root    root    1632 Apr 27 15:44 8754285698aa24ef37fb9d7e8b88d3f6ad4a8c267da420626b6e6d9ba4a8a2d0-primary.sqlite.bz2
> -rw-r--r-- 1 root    root     577 Apr 27 15:44 8ec3972ca9194bc3b1e759900dc3d6e69334bd5b98281fd7d93ed7f1c97a6289-primary.xml.gz
> -rw-r--r-- 1 root    root     650 Apr 27 15:44 d3c30d5e41a3e637ad5493488c5f1278f131e2d75cdc09ee480a969ed2ed9625-other.sqlite.bz2
> -rw-r--r-- 1 root    root    2972 Apr 27 15:44 repomd.xml
> ```

Yumリポジトリが作成されました。

# repoファイルの作成

repoファイルを作成します。repoファイルは`/etc/yum.repos.d/リポジトリ名.repo`として作成・配置されてる必要があります。本書では`example`リポジトリとして設定して行きます。

## repoファイルの配置

```
$ sudo vi /etc/yum.repos.d/example.repo
```

```
[example]
name=example
baseurl=http://127.0.0.1/pub/
enabled=1
gpgcheck=0
```

なお、`baseurl`の`127.0.0.1`は、環境に合わせて指定して下さい。

## リポジトリが有効かどうかを確認

リポジトリが利用可能かどうかを確認します。

```
$ sudo yum makecache --disablerepo='*' --enablerepo='example'
```

実行結果例：

> ```
> $ sudo yum makecache --disablerepo='*' --enablerepo='example'
> Loaded plugins: fastestmirror
> Loading mirror speeds from cached hostfile
> example                                                  | 2.9 kB     00:00
> example/filelists_db                                     |  748 B     00:00
> example/other_db                                         |  650 B     00:00
> Metadata Cache Created
> ```

`example`が有効である事が分かります。

## `example`パッケージ情報を取得

Yumリポジトリが利用可能になったので、`example`パッケージ情報を取得できるはずです。

```
$ yum info example
```

実行結果例：

> ```
> $ yum info example
> Loaded plugins: fastestmirror
> Determining fastest mirrors
>  * base: www.ftp.ne.jp
>  * extras: www.ftp.ne.jp
>  * updates: www.ftp.ne.jp
> Available Packages
> Name        : example
> Arch        : x86_64
> Version     : 0.1.0
> Release     : 1.el6
> Size        : 1.7 k
> Repo        : example
> Summary     : example
> License     : BSD
> Description :
> ```

## Yumリポジトリを使ってインストールしてみる

yumコマンドで`example`パッケージをインストールしてみます。

```
$ sudo yum install -y example
```

実行結果例：

> ```
> $ sudo yum install -y example
> Loaded plugins: fastestmirror
> Setting up Install Process
> Loading mirror speeds from cached hostfile
>  * base: ftp.iij.ad.jp
>  * extras: centos.usonyx.net
>  * updates: centos.usonyx.net
> Resolving Dependencies
> --> Running transaction check
> ---> Package example.x86_64 0:0.1.0-1.el6 will be installed
> --> Finished Dependency Resolution
>
> Dependencies Resolved
>
> ================================================================================
>  Package          Arch            Version                Repository        Size
> ================================================================================
> Installing:
>  example          x86_64          0.1.0-1.el6            example          1.7 k
>
> Transaction Summary
> ================================================================================
> Install       1 Package(s)
>
> Total download size: 1.7 k
> Installed size: 0
> Downloading Packages:
> example-0.1.0-1.el6.x86_64.rpm                           | 1.7 kB     00:00
> Running rpm_check_debug
> Running Transaction Test
> Transaction Test Succeeded
> Running Transaction
>   Installing : example-0.1.0-1.el6.x86_64                                   1/1
>   Verifying  : example-0.1.0-1.el6.x86_64                                   1/1
>
> Installed:
>   example.x86_64 0:0.1.0-1.el6
>
> Complete!
>
> ```

## ここまでのまとめ

Yumリポジトリの構築を体験しました。まだ単一バージョンrpmファイルまでしか扱われていません。次に複数バージョンのrpmファイルが混在する場合を扱って行きます。

# 複数バージョンrpmファイルの運用管理

example-0.1.0を変更し、example-0.2.0を作成します。なお、rpmファイルの作り方に関しては本書の主題から逸れるので、簡単な説明に留めます。

## example-0.2.0の生成

ソースツリーを作成します。

```
$ cd ${HOME}/rpmbuild/SOURCES/
```

example-0.1.0を変更し、example-0.2.0を作成します。

```
$ rsync -avx example-0.1.0/ example-0.2.0
```

実行結果例：

> ```
> $ rsync -avx example-0.1.0/ example-0.2.0
> sending incremental file list
> created directory example-0.2.0
> ./
> bin/
> bin/example
>
> sent 128 bytes  received 38 bytes  332.00 bytes/sec
> total size is 0  speedup is 0.00
> ```

アーカイブファイルを作成します。

```
$ tar zcvf example-0.2.0.tar.gz example-0.2.0
```

実行結果例：

> ```
> $ tar zcvf example-0.2.0.tar.gz example-0.2.0
> example-0.2.0/
> example-0.2.0/bin/
> example-0.2.0/bin/example
> ```

rpmspecファイルを修正します。

```
$ cd ${HOME}/rpmbuild/SPECS/
```

作業前後の差分を確認する為に、rpmspecファイルのバックアップを作成します。

```
$ cp -pi example.spec example.spec.orig
```

バージョンを`0.1.0`から`0.2.0`へ進めます。

```
$ sed -i 's,0.1.0,0.2.0,' example.spec
```

作業前後の差分を確認します。

```
$ diff example.spec.orig example.spec
```

実行結果例：

> ```
> $ diff example.spec.orig example.spec
. 2c2
> < Version: 0.1.0
> ---
> > Version: 0.2.0
> ```

rpmをビルドします

```
$ rpmbuild -bb example.spec
```

実行結果例：

> ```
> $ rpmbuild -bb example.spec
> Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.R28MbM
> + umask 022
> + cd /home/vagrant/rpmbuild/BUILD
> + LANG=C
> + export LANG
> + unset DISPLAY
> + cd /home/vagrant/rpmbuild/BUILD
> + rm -rf example-0.2.0
> + /bin/tar -xf -
> + /usr/bin/gzip -dc /home/vagrant/rpmbuild/SOURCES/example-0.2.0.tar.gz
> + STATUS=0
> + '[' 0 -ne 0 ']'
> + cd example-0.2.0
> + /bin/chmod -Rf a+rX,u+w,g-w,o-w .
> + exit 0
> Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.kM1DG9
> + umask 022
> + cd /home/vagrant/rpmbuild/BUILD
> + cd example-0.2.0
> + LANG=C
> + export LANG
> + unset DISPLAY
> + exit 0
> Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.iqJMbx
> + umask 022
> + cd /home/vagrant/rpmbuild/BUILD
> + '[' /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64 '!=' / ']'
> + rm -rf /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64
> ++ dirname /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64
> + mkdir -p /home/vagrant/rpmbuild/BUILDROOT
> + mkdir /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64
> + cd example-0.2.0
> + LANG=C
> + export LANG
> + unset DISPLAY
> + rm -rf /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64
> + mkdir -p /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64
> + rsync -avx ./ /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64/
> sending incremental file list
> ./
> bin/
> bin/example
>
> sent 128 bytes  received 38 bytes  332.00 bytes/sec
> total size is 0  speedup is 0.00
> + /usr/lib/rpm/find-debuginfo.sh --strict-build-id /home/vagrant/rpmbuild/BUILD/example-0.2.0
> + /usr/lib/rpm/check-buildroot
> + /usr/lib/rpm/redhat/brp-compress
> + /usr/lib/rpm/redhat/brp-strip-static-archive /usr/bin/strip
> + /usr/lib/rpm/redhat/brp-strip-comment-note /usr/bin/strip /usr/bin/objdump
> + /usr/lib/rpm/brp-python-bytecompile
> + /usr/lib/rpm/redhat/brp-python-hardlink
> + /usr/lib/rpm/redhat/brp-java-repack-jars
> Processing files: example-0.2.0-1.el6.x86_64
> Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(FileDigests) <= 4.6.0-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
> Processing files: example-debuginfo-0.2.0-1.el6.x86_64
> Checking for unpackaged file(s): /usr/lib/rpm/check-files /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64
> warning: Could not canonicalize hostname: vagrant-centos6
> Wrote: /home/vagrant/rpmbuild/RPMS/x86_64/example-0.2.0-1.el6.x86_64.rpm
> Wrote: /home/vagrant/rpmbuild/RPMS/x86_64/example-debuginfo-0.2.0-1.el6.x86_64.rpm
> Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.CnU3m2
> + umask 022
> + cd /home/vagrant/rpmbuild/BUILD
> + cd example-0.2.0
> + rm -rf /home/vagrant/rpmbuild/BUILDROOT/example-0.2.0-1.el6.x86_64
> + exit 0
> ```

## RPMSを/var/www/html/pub/に配置

example-0.2.0を`/var/www/html/pub/`に配置して行きます。

```
$ cd ${HOME}/rpmbuild/RPMS/
```

```
$ sudo rsync -avx . /var/www/html/pub/
```

実行結果例：

> ```
> $ sudo rsync -avx . /var/www/html/pub/
> sending incremental file list
> ./
> x86_64/
> x86_64/example-0.2.0-1.el6.x86_64.rpm
> x86_64/example-debuginfo-0.2.0-1.el6.x86_64.rpm
>
> sent 3929 bytes  received 57 bytes  7972.00 bytes/sec
> total size is 5427  speedup is 1.36
> ```

配置先にrpmファイルがある事を確認します。

```
$ ls -l /var/www/html/pub/x86_64/example-0.2.0-1.el6.x86_64.rpm
```

実行結果例：

> ```
> $ ls -l /var/www/html/pub/x86_64/example-0.2.0-1.el6.x86_64.rpm
> -rw-r--r-- 1 vagrant vagrant 2064 Apr 27 20:12 /var/www/html/pub/x86_64/example-0.2.0-1.el6.x86_64.rpm
> ```

## Yumリポジトリの再構築

example-0.2.0を含めたYumリポジトリを構築して行きます。

```
$ cd /var/www/html/pub
```

```
$ sudo createrepo .
```

実行結果例：

> ```
> $ sudo createrepo .
> Spawning worker 0 with 3 pkgs
> Workers Finished
> Gathering worker results
>
> Saving Primary metadata
> Saving file lists metadata
> Saving other metadata
> Generating sqlite DBs
> Sqlite DBs complete
> ```

新Yumリポジトリに新exampleパッケージが存在するかどうかを確認します。

```
$ yum clean metadata
$ yum info example
```

実行結果例：

> ```
> $ yum clean metadata
> ...(省略)...
> $ yum info example
> Loaded plugins: fastestmirror
> Loading mirror speeds from cached hostfile
>  * base: www.ftp.ne.jp
>  * extras: www.ftp.ne.jp
>  * updates: www.ftp.ne.jp
> Installed Packages
> Name        : example
> Arch        : x86_64
> Version     : 0.1.0
> Release     : 1.el6
> Size        : 0.0
> Repo        : installed
> From repo   : example
> Summary     : example
> License     : BSD
> Description :
>
> Available Packages
> Name        : example
> Arch        : x86_64
> Version     : 0.2.0
> Release     : 1.el6
> Size        : 2.0 k
> Repo        : example
> Summary     : example
> License     : BSD
> Description :
>
> ```

`0.2.0`が最新版である事が分かります。パッケージをアップデートしてみます。

```
$ sudo yum update -y example
```

実行結果例：

> ```
> $ sudo yum update -y example
> Loaded plugins: fastestmirror
> Setting up Update Process
> Loading mirror speeds from cached hostfile
>  * base: ftp.iij.ad.jp
>  * extras: centos.usonyx.net
>  * updates: centos.usonyx.net
> base                                                     | 3.7 kB     00:00
> epel                                                     | 4.4 kB     00:00
> example                                                  | 2.9 kB     00:00
> example/primary_db                                       | 2.1 kB     00:00
> extras                                                   | 3.4 kB     00:00
> updates                                                  | 3.4 kB     00:00
> Resolving Dependencies
> --> Running transaction check
> ---> Package example.x86_64 0:0.1.0-1.el6 will be updated
> ---> Package example.x86_64 0:0.2.0-1.el6 will be an update
> --> Finished Dependency Resolution
>
> Dependencies Resolved
>
> ================================================================================
>  Package          Arch            Version                Repository        Size
> ================================================================================
> Updating:
>  example          x86_64          0.2.0-1.el6            example          2.0 k
>
> Transaction Summary
> ================================================================================
> Upgrade       1 Package(s)
>
> Total download size: 2.0 k
> Downloading Packages:
> example-0.2.0-1.el6.x86_64.rpm                           | 2.0 kB     00:00
> Running rpm_check_debug
> Running Transaction Test
> Transaction Test Succeeded
> Running Transaction
>   Updating   : example-0.2.0-1.el6.x86_64                                   1/2
>   Cleanup    : example-0.1.0-1.el6.x86_64                                   2/2
>   Verifying  : example-0.2.0-1.el6.x86_64                                   1/2
>   Verifying  : example-0.1.0-1.el6.x86_64                                   2/2
>
> Updated:
>   example.x86_64 0:0.2.0-1.el6
>
> Complete!
> ```

パッケージがアップデートされました。インストールされたパッケージの情報を確認してみます。

```
$ rpm -qi example
```

実行結果例：

> ```
> $ rpm -qi example
> Name        : example                      Relocations: (not relocatable)
> Version     : 0.2.0                             Vendor: (none)
> Release     : 1.el6                         Build Date: Mon 27 Apr 2015 08:12:16 PM JST
> Install Date: Mon 27 Apr 2015 08:23:15 PM JST      Build Host: vagrant-centos6
> Group       : Unspecified                   Source RPM: example-0.2.0-1.el6.src.rpm
> Size        : 0                                License: BSD
> Signature   : (none)
> Summary     : example
> Description :
> ```

example-0.2.0がインストールされた事を確認出来ました。

## ここまでのまとめ

複数バージョンのrpmが混在する場合のYumリポジトリ構築を学びました。これ以降は、パッケージ内容を変更する度に、同じ手順で更新して行くだけです。手順を上手に整理すると、一連の作業を自動化可能です。

# 複数台構成を意識した手順整理

これまでに最小構成Yumリポジトリを作ってYumリポジトリ構築と更新を学びました。1台構成でしたが、通常は複数台構成です。複数台構成を意識した手順で整理します。

役割：

1. rpmビルドサーバ/Yumリポジトリ
2. アプリケーションサーバ(パッケージインストール実施環境)

それでは役割毎に手順を整理してみます。

## rpmビルドサーバ/Yumリポジトリ

### 1: rpmのビルド

```
$ cd ${HOME}/rpmbuild/SPECS/
$ rpmbuild -bb example.spec
```

### 2: RPMSの配置

```
$ cd ${HOME}/rpmbuild/RPMS/
$ sudo rsync -avx . /var/www/html/pub/
```

### 3: Yumリポジトリの構築

```
$ cd /var/www/html/pub
$ sudo createrepo .
```

## アプリケーションサーバ

### 1: repoファイルの配置

```
$ sudo vi /etc/yum.repos.d/example.repo
```

baseurlに指定するIPアドレスを、ビルドサーバのIPアドレスにします。

### 2: パッケージのインストール/更新

初期インストールの場合：

```
$ sudo yum install -y package
```

更新インストールの場合：

```
$ sudo yum clean metadata
$ sudo yum update -y package
```

# まとめ

最小構成Yumリポジトリを作ってYumリポジトリ作成手順を学びました。
