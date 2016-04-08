ssh -qi root@10.0.2.100 <<EOF 2> /dev/null
if [[ -f "$filename" ]] ; then
cat <<XML_FILE > "$filename"
<?xml version='1.0' encoding='UTF-8'?>
<jenkins.plugins.hipchat.HipChatNotifier_-DescriptorImpl plugin="hipchat@1.0.0">
  <server>api.hipchat.com</server>
  <token>token</token>
  <v2Enabled>false</v2Enabled>
  <room>room</room>
  <sendAs>Jenkins</sendAs>
</jenkins.plugins.hipchat.HipChatNotifier_-DescriptorImpl>
XML_FILE
fi
EOF

