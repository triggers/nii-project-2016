ssh -qi /home/centos/mykeypair root@10.0.2.100 <<EOF 2> /dev/null
if [[ ! -f "$filename" ]] ; then
cat <<XML_FILE > "$filename"
<?xml version='1.0' encoding='UTF-8'?>
<hudson.plugins.git.GitSCM_-DescriptorImpl plugin="git@2.4.2">
  <generation>1</generation>
  <globalConfigName>gitUser</globalConfigName>
  <globalConfigEmail>your@email.jp</globalConfigEmail>
  <createAccountBasedOnEmail>false</createAccountBasedOnEmail>
</hudson.plugins.git.GitSCM_-DescriptorImpl>
XML_FILE
fi
EOF
