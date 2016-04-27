test_passed=false

check_plugins_exists "rbenv" && test_passed=true

if $test_passed ; then
    echo "Plugin Installed: Passed"
else
    echo "Plugin Installed: Failed"
fi
