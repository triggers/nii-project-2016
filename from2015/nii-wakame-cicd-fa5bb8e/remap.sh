#!/bin/bash
#
# requires:
#  bash
#
set -e
set -o pipefail
set -u

maps=(
  101_HipChat_セットアップ:hipchat
  102_Jenkins_インストール:jenkins-setup
  103_Jenkins_任意のスクリプト実行ジョブ:jenkins-shelljob
  104_Jenkins_GitHubポーリング連動:jenkins-github
  105_Jenkins_HipChatへのレポート:jenkins-hipchat
  106_Jenkins_単体テスト実行ジョブ:unittest
  107_RPM_生成方法:rpmspec-rpmbuild
  108_YUM_リポジトリの準備:yumrepo
  201_プルリクエストによるマージ:using-pull-requests
  202_パラメタ付きビルド:jenkins-parameterized-build
  204_マシンイメージの作り方:machine-image-build
  203_WebAPI_コマンドマニュアル:mussel
  205_Hubot_インストール:hubot
  206_Hubot_HipChatへの参加:hubot-integration
)

for map in ${maps[@]}; do
  src="${map##*:}.pdf"
  dst="${map%%:*}.pdf"

  [[ -f "${src}" ]] || continue
  echo "[INFO] ${src} -> ${dst}"
  mv "${src}" "${dst}"
done
