# Jenkins インストール

# Jenkins環境構築

## repoファイルのインストール

jenkins用yumリポジトリを追加します。

```
$ sudo curl -fSkL \
 http://pkg.jenkins-ci.org/redhat/jenkins.repo \
 -o /etc/yum.repos.d/jenkins.repo
```

実行結果例：

> ```
> $ sudo curl -fSkL \
>  http://pkg.jenkins-ci.org/redhat/jenkins.repo \
>  -o /etc/yum.repos.d/jenkins.repo
>  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                  Dload  Upload   Total   Spent    Left  Speed
>   0    75    0    75    0     0     13      0 --:--:--  0:00:05 --:--:--   367
> ```

## 公開鍵のインポート

jenkinsのrpmは署名されているので、インストールするには公開鍵が必要です。公開鍵をインストールします。

```
$ sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
```

実行結果例：

> ```
> $ sudo rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
> ```

成功時は何も表示されません。

## java実行環境のインストール

```
$ sudo yum install -y java-1.7.0-openjdk
```

実行結果例：

> ```
> $ sudo yum install -y java-1.7.0-openjdk
> Loaded plugins: fastestmirror
> Setting up Install Process
> Loading mirror speeds from cached hostfile
>  * base: ftp.nara.wide.ad.jp
>  * extras: www.ftp.ne.jp
>  * updates: ftp.nara.wide.ad.jp
> ...(省略)...
> Installed:
>   java-1.7.0-openjdk.x86_64 1:1.7.0.79-2.5.5.1.el6_6
>
> Dependency Installed:
>   alsa-lib.x86_64 0:1.0.22-3.el6
>   atk.x86_64 0:1.30.0-1.el6
>   avahi-libs.x86_64 0:0.6.25-15.el6
>  cairo.x86_64 0:1.8.8-3.1.el6
>   cups-libs.x86_64 1:1.4.2-67.el6
>  flac.x86_64 0:1.2.1-7.el6_6
>   fontconfig.x86_64 0:2.8.0-5.el6
>   freetype.x86_64 0:2.3.11-15.el6_6.1
>   gdk-pixbuf2.x86_64 0:2.24.1-5.el6
>   giflib.x86_64 0:4.1.6-3.1.el6
>   gtk2.x86_64 0:2.24.23-6.el6
>   hicolor-icon-theme.noarch 0:0.11-1.1.el6
>   jasper-libs.x86_64 0:1.900.1-16.el6_6.3
>   jpackage-utils.noarch 0:1.7.5-3.12.el6
>   libICE.x86_64 0:1.0.6-1.el6
>   libSM.x86_64 0:1.2.1-2.el6
>   libX11.x86_64 0:1.6.0-2.2.el6
>   libX11-common.noarch 0:1.6.0-2.2.el6
>   libXau.x86_64 0:1.0.6-4.el6
>   libXcomposite.x86_64 0:0.4.3-4.el6
>   libXcursor.x86_64 0:1.1.14-2.1.el6
>   libXdamage.x86_64 0:1.1.3-4.el6
>   libXext.x86_64 0:1.3.2-2.1.el6
>   libXfixes.x86_64 0:5.0.1-2.1.el6
>   libXfont.x86_64 0:1.4.5-4.el6_6
>   libXft.x86_64 0:2.3.1-2.el6
>   libXi.x86_64 0:1.7.2-2.2.el6
>   libXinerama.x86_64 0:1.1.3-2.1.el6
>   libXrandr.x86_64 0:1.4.1-2.1.el6
>   libXrender.x86_64 0:0.9.8-2.1.el6
>   libXtst.x86_64 0:1.2.2-2.1.el6
>   libasyncns.x86_64 0:0.8-1.1.el6
>   libfontenc.x86_64 0:1.0.5-2.el6
>   libjpeg-turbo.x86_64 0:1.2.1-3.el6_5
>   libogg.x86_64 2:1.1.4-2.1.el6
>   libpng.x86_64 2:1.2.49-1.el6_2
>   libsndfile.x86_64 0:1.0.20-5.el6
>   libthai.x86_64 0:0.1.12-3.el6
>   libtiff.x86_64 0:3.9.4-10.el6_5
>   libvorbis.x86_64 1:1.2.3-4.el6_2.1
>   libxcb.x86_64 0:1.9.1-2.el6
>   pango.x86_64 0:1.28.1-10.el6
>   pixman.x86_64 0:0.32.4-4.el6
>   pulseaudio-libs.x86_64 0:0.9.21-17.el6
>   ttmkfdir.x86_64 0:3.0.9-32.1.el6
>   tzdata-java.noarch 0:2015d-1.el6
>   xorg-x11-font-utils.x86_64 1:7.2-11.el6
>   xorg-x11-fonts-Type1.noarch 0:7.2-9.1.el6
>
> Complete!
> ```

## jenkins coreのインストール

```
$ sudo yum install -y jenkins
```

実行結果例：

> ```
> $ sudo yum install -y jenkins
> Loaded plugins: fastestmirror
> Setting up Install Process
> Loading mirror speeds from cached hostfile
>  * base: ftp.nara.wide.ad.jp
>  * extras: www.ftp.ne.jp
>  * updates: ftp.nara.wide.ad.jp
> Resolving Dependencies
> --> Running transaction check
> ---> Package jenkins.noarch 0:1.612-1.1 will be installed
> --> Finished Dependency Resolution
>
> Dependencies Resolved
>
> ================================================================================
>  Package           Arch             Version             Repository         Size
> ================================================================================
> Installing:
>  jenkins           noarch           1.612-1.1           jenkins            60 M
>
> Transaction Summary
> ================================================================================
> Install       1 Package(s)
>
> Total download size: 60 M
> Installed size: 66 M
> Downloading Packages:
> jenkins-1.612-1.1.noarch.rpm                             |  60 MB     00:11
> Running rpm_check_debug
> Running Transaction Test
> Transaction Test Succeeded
> Running Transaction
>   Installing : jenkins-1.612-1.1.noarch                                     1/1
>   Verifying  : jenkins-1.612-1.1.noarch                                     1/1
>
> Installed:
>   jenkins.noarch 0:1.612-1.1
>
> Complete!
> ```

## 関連するビルドツールのインストール

パッケージビルド等で必要なパッケージをインストールしておきます。

```
$ sudo yum install -y \
    git \
    iputils nc \
    qemu-kvm qemu-img \
    parted kpartx \
    rpm-build automake createrepo \
    openssl-devel zlib-devel readline-devel \
    gcc
```

実行結果例：

> ```
> $ sudo yum install  -y \
>     git \
>     iputils nc \
>     qemu-kvm qemu-img \
>     parted kpartx \
>     rpm-build automake createrepo \
>     openssl-devel zlib-devel readline-devel \
>     gcc
> Loaded plugins: fastestmirror
> Setting up Install Process
> Loading mirror speeds from cached hostfile
>  * base: ftp.nara.wide.ad.jp
>  * extras: www.ftp.ne.jp
>  * updates: ftp.nara.wide.ad.jp
>  ...(省略)...
>  Complete!
> ```

## sudo設定

### sudo権限の付与

jenkinsアカウントがsudoを使える様に権限を付与します。`visudo`コマンドを実行します。`visudo`コマンドを実行すると`vi`が起動するので、`jenkins ALL=(ALL) NOPASSWD: ALL`を最終行に追加します。

```
$ sudo visudo
```

実行結果例：

> ```
> $ sudo visudo
> ```

設定が反映されているかどうかを確認します。

```
$ sudo grep jenkins /etc/sudoers
```

実行結果例：

> ```
> $ sudo grep jenkins /etc/sudoers
> jenkins ALL=(ALL) NOPASSWD: ALL
> ```

この様に表示されている事を確認して下さい。

### tty設定の変更

sudoの初期設定ではttyを必要としています。Jenkinsからsudoを使うには、無効化する必要があるので無効化します。

```
$ sudo sed -i "s/^\(^Defaults\s*requiretty\).*/# \1/" /etc/sudoers
```

実行結果例：

> ```
> $ sudo sed -i "s/^\(^Defaults\s*requiretty\).*/# \1/" /etc/sudoers
> ```

## jenkinsの起動

インストールが完了したので、最後にJenkinsを起動します。

```
$ sudo service jenkins start
```

実行結果例：

> ```
> $ sudo service jenkins start
> Starting Jenkins                                           [  OK  ]
> ```
