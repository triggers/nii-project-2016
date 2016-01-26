#!/bin/bash
#
#
set -e
set -o pipefail
set -x

if [[ -f /metadata/user-data ]]; then
  . /metadata/user-data
fi

cat <<EOS > /etc/default/hubot
export HUBOT_HIPCHAT_JID="${HUBOT_HIPCHAT_JID}"
export HUBOT_HIPCHAT_PASSWORD="${HUBOT_HIPCHAT_PASSWORD}"
export HUBOT_LOG_LEVEL="${HUBOT_LOG_LEVEL}"
export HUBOT_JENKINS_URL="${HUBOT_JENKINS_URL}"
EOS

initctl stop  hubot || :
sleep 1
initctl start hubot
