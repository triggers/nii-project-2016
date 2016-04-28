#!/bin/bash

output="$(ssh -qi ../mykeypair root@${INSTANCE_IP} 'rpm -qa' 2> /dev/null)"

installed_git=false
installed_rpmbuild=false
installed_rpmlint=false

grep ^"git" <<< "$output" && installed_git=true
grep ^"rpm-build" <<< "$output" && installed_rpmbuild=true
grep ^"rpmlint" <<< "$output" && installed_rpmlint=true

check_message $installed_git "Found Git"
check_message $installed_rpmbuild "Found rpm-build"
check_message $installed_rpmlint "Found rpmlint"
