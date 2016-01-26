# RPM 生成方法

# はじめに

rpm作成手順を学ぶためには、最小構成のrpmを作ってみる事が一番の近道です。本章では、実際に最小構成rpmを作りながらrpm作成の基礎を学んで行きます。

今回、演習用のサンプルプログラムでは、rpmファイルを作成するためのspecファイル([tiny_web_example/rpmbuild/SPECS/tiny-web-example.spec](https://github.com/axsh/tiny_web_example/blob/master/rpmbuild/SPECS/tiny-web-example.spec))はあらかじめ準備されています。以下のセクションでは、そのspecファイルをスクラッチから作る方法を紹介しています。そのため、今回の演習用に、rpmファイルを生成するだけであれば、「rpmbuild環境の構築」完了後に「rpmの作成」まで読み飛ばし、サンプルプログラムのspecファイルを使ってrpmファイルを生成してみてください。


# 環境構築

## rpmbuild環境の構築

rpmをビルドする為に必要なパッケージをインストールします。

```
$ sudo yum install -y git rpm-build rpmlint
```

実行結果例：

> ```
> $ sudo yum install -y git rpm-build rpmlint
> Loaded plugins: fastestmirror
> Setting up Install Process
> Determining fastest mirrors
>  * base: ftp.riken.jp
>  * extras: ftp.riken.jp
>  * updates: ftp.riken.jp
> ...(省略)...
> Complete!
> ```

## rpmbuildディレクトリの作成

rpmbuildコマンドが使用するディレクトリを作成します。

```
$ mkdir -p \
 ${HOME}/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
```

# `example-0.1.0.rpm`作成作業

## rpm作成へ向けた情報整理

「何のrpmを作るのか？」は「exampleのrpmを作る」と言う所までは決めていました。しかし、基になるパッケージや、そのバージョンが決まっていません。これらの未決定情報を整理して行きます。

### パッケージ情報の整理

rpmを作るには、事前に幾つかの情報を整理しておく必要があります。

1. パッケージ名
2. パッケージのバージョン

今回は、以下のようにします。

1. パッケージ名：`example`
2. バージョン：`0.1.0`

すると、期待するファイル名は`example-0.1.0.rpm`と言う事になります。

### 必須ファイルの準備

rpmを作るには、2つのファイルが必要です。

1. rpmspecファイル
2. ソースコードのアーカイブファイル

本書では、コンパイル不要なもソースコードを使用します。コンパイルが必要なソースコードをビルドするには、ビルド手順を記述する必要があります。これは、どちらかと言うと応用編です。最小構成rpm作りを目的としている本書では、触れません。

2つのファイルを作成して行きます。

## 2つの必須ファイルの作成

###  1: rpmspecファイル

rpmspecには2つのルールがあります。

1. rpmspecファイルの配置場所は、`${HOME}/rpmbuild/SPECS`
2. rpmspecファイル名は、`パッケージ名.spec`

これを踏まえてrpmspecファイルを作成して行きます。

#### rpmspecファイルの作成

##### ディレクトリの移動

```
$ cd ${HOME}/rpmbuild/SPECS
```

##### `example.spec`の作成

冒頭で触れた通り、本手順では`example.rpm`を作ります。rpmspecファイルは、`example.spec`と言う事になります。ここで事前に整理した情報を使います。

+ パッケージ名：`example`
+ バージョン：`0.1.0`

上記情報をrpmspecのタグで読み替えます。

+ `Name`: `example`
+ `Version`: `0.1.0`

`example.spec`を作成します。

```
$ vi example.spec
```

```
Name:    example
Version: 0.1.0
Release: 1%{?dist}
Summary: example
License: BSD
Source:  %{name}-%{version}.tar.gz

%description

%prep
%setup -q

%build

%install
rm   -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT
rsync -avx ./ $RPM_BUILD_ROOT/

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
/
%doc

%changelog
```

幾つかの項目を補足します。

`%install`

+ アーカイブツリー全てを仮想ルートツリーへ配置します

`%files`

+ `/`配下全てをパッケージング対象に入れます

##### `rpmlint`で内容を確認

作成したrpmspecファイルに必須項目が含まれているかどうかを`rpmlint`コマンドで確認します。

```
$ rpmlint example.spec
```

実行結果例：

> ```
> $ rpmlint example.spec
> example.spec: W: no-buildroot-tag
> example.spec: W: invalid-url Source0: example-0.1.0.tar.gz
> 0 packages and 1 specfiles checked; 0 errors, 2 warnings.
> ```

もしもrpmspecファイルに問題がある場合は、`rpmlint`コマンドが警告してくれます。

###  2: ソースコードのアーカイブファイル

ソースコードアーカイブには2つのルールがあります。

1. ソースコードアーカイブの配置場所は、`${HOME}/rpmbuild/SOURCES`
2. ソースコードアーカイブのファイル名は、`パッケージ名-バージョン.tar.gz`

これを踏まえてソースコードアーカイブを作成して行きます。

#### ソースコードの用意

##### ディレクトリの移動

```
$ cd ${HOME}/rpmbuild/SOURCES/
```

##### `example-0.1.0`の作成

アーカイブファイル名には規則性があり、`パッケージ名-バージョン`をアーカイブした`パッケージ名-バージョン.tar.gz`と言うファイルが必要です。まずはディレクトリを作成して行きます。

```
$ mkdir example-0.1.0
```

##### `/bin/example`の配置

次にパッケージングするファイルを配置します。既存RPMと重複しないファイルであれば良いので、今回は`/bin/example`とします。

```
$ mkdir example-0.1.0/bin
$ touch example-0.1.0/bin/example
```

ディレクトリ配下のファイル確認します。

```
$ find example-0.1.0 -type f
```

実行結果例：

> ```
> $ find example-0.1.0 -type f
> example-0.1.0/bin/example
> ```

これはrpm化された時に期待するファイルリストです。

#### アーカイブファイルの作成

tarコマンドでアーカイブを作成します。

```
$ tar zcvf example-0.1.0.tar.gz example-0.1.0
```

実行結果例：

> ```
> $ tar zcvf example-0.1.0.tar.gz example-0.1.0
> example-0.1.0/
> example-0.1.0/bin/
> example-0.1.0/bin/example
> ```

`example-0.1.0.tar.gz`が生成されました。

## rpmの作成

rpmspecファイルとソースコードのアーカイブファイルの準備が出来ました。いよいよ、rpmを作成して行きます。

### ディレクトリの移動

```
$ cd ${HOME}/rpmbuild/SPECS
```

### `rpmbuild`の実行

`rpmbuild`コマンドを実行します。

```
$ rpmbuild -bb example.spec
```

実行結果例：

> ```
> $ rpmbuild -bb example.spec
> Executing(%prep): /bin/sh -e /var/tmp/rpm-tmp.thSbon
> + umask 022
> + cd /home/vagrant/rpmbuild/BUILD
> + cd /home/vagrant/rpmbuild/BUILD
> + rm -rf example-0.1.0
> + /bin/tar -xf -
> + /usr/bin/gzip -dc /home/vagrant/rpmbuild/SOURCES/example-0.1.0.tar.gz
> + STATUS=0
> + '[' 0 -ne 0 ']'
> + cd example-0.1.0
> + /bin/chmod -Rf a+rX,u+w,g-w,o-w .
> + exit 0
> Executing(%build): /bin/sh -e /var/tmp/rpm-tmp.eYFskt
> + umask 022
> + cd /home/vagrant/rpmbuild/BUILD
> + cd example-0.1.0
> + exit 0
> Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.cwEehz
> + umask 022
> + cd /home/vagrant/rpmbuild/BUILD
> + cd example-0.1.0
> + rm -rf /home/vagrant/rpmbuild/BUILDROOT/example-0.1.0-1.el6.x86_64
> + mkdir -p /home/vagrant/rpmbuild/BUILDROOT/example-0.1.0-1.el6.x86_64
> + rsync -avx ./ /home/vagrant/rpmbuild/BUILDROOT/example-0.1.0-1.el6.x86_64/
> sending incremental file list
> ./
> bin/
> bin/example
>
> sent 128 bytes  received 38 bytes  332.00 bytes/sec
> total size is 0  speedup is 0.00
> + /usr/lib/rpm/brp-compress
> + /usr/lib/rpm/brp-strip
> + /usr/lib/rpm/brp-strip-static-archive
> + /usr/lib/rpm/brp-strip-comment-note
> Processing files: example-0.1.0-1.el6.x86_64
> Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1 rpmlib(PayloadFilesHavePrefix) <= 4.0-1
> Checking for unpackaged file(s): /usr/lib/rpm/check-files /home/vagrant/rpmbuild/BUILDROOT/example-0.1.0-1.el6.x86_64
> warning: Could not canonicalize hostname: vagrant-centos6
> Wrote: /home/vagrant/rpmbuild/RPMS/x86_64/example-0.1.0-1.el6.x86_64.rpm
> Executing(%clean): /bin/sh -e /var/tmp/rpm-tmp.6TMilN
> + umask 022
> + cd /home/vagrant/rpmbuild/BUILD
> + cd example-0.1.0
> + rm -rf /home/vagrant/rpmbuild/BUILDROOT/example-0.1.0-1.el6.x86_64
> + exit 0
> ```

上記例では、`/home/vagrant/rpmbuild/RPMS/x86_64/example-0.1.0-1.el6.x86_64.rpm`が生成されました。

### 出来上がったrpmをインストールしてみる

出来上がったrpmをインストールして確認してみます。

```
$ sudo rpm -ivh /home/vagrant/rpmbuild/RPMS/x86_64/example-0.1.0-1.el6.x86_64.rpm
```

実行結果例：

> ```
> $ sudo rpm -ivh /home/vagrant/rpmbuild/RPMS/x86_64/example-0.1.0-1.el6.x86_64.rpm
> Preparing...                ########################################### [100%]
>    1:example                ########################################### [100%]
> ```

### rpm情報の確認

インストールしたrpmの情報を確認します。

```
$ rpm -qi example
```

実行結果例：

> ```
> $ rpm -qi example
> Name        : example                      Relocations: (not relocatable)
> Version     : 0.1.0                             Vendor: (none)
> Release     : 1.el6                         Build Date: Wed 15 Apr 2015 07:20:32 PM JST
> Install Date: Wed 15 Apr 2015 07:21:59 PM JST      Build Host: vagrant-centos6
> Group       : Unspecified                   Source RPM: example-0.1.0-1.el6.src.rpm
> Size        : 0                                License: BSD
> Signature   : (none)
> Summary     : example
> Description :
>
> ```

### ファイルリストの確認

ファイルリストを確認します。

```
$ rpm -ql example
```

実行結果例：

> ```
> /
> /bin
> /bin/example
> ```

実際にファイルが存在しているかどうかを確認します。

```
$ ls -l /bin/example
```

実行結果例：

> ```
> $ ls -l /bin/example
> -rw-r--r-- 1 root root 0 Apr 15 19:18 /bin/example
> ```

`/bin/example`にインストールされてる事を確認出来ました。

### 削除出来る事の確認

次に正しくrpmが削除出来る事を確認します。

```
$ sudo rpm -e example
```

実行結果例：

> ```
> $ sudo rpm -e example
> ```

正常に削除した場合は何も出力されません。

```
$ rpm -qi example
```

実行結果例：

> ```
> $ rpm -qi example
> package example is not installed
> ```

インストールされてない事を確認。

```
$ ls -l /bin/example
```

実行結果例：

> ```
> $ ls -l /bin/example
> ls: cannot access /bin/example: No such file or directory
> ```

`/bin/example`が存在しない事を確認。

# まとめ

最小構成rpmを作ってrpm作成手順を学びました。一般的なアーカイブは、ビルド手順を定義する必要が大半です。インストールパスも様々です。そうしたパッケージ特有の手順に合わせて、rpmspecファイルの`%build`セクションと`%install`セクションを記述する必要がありますが、RPMを作る為の手順は、最小構成RPMと同じです。是非、最小構成RPM作成を発展させた独自パッケージ作成に挑戦してみて下さい。
