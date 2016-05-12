test_passed=false

check_plugins_exists "rbenv" && test_passed=true
check_message $test_passed "$plugin_installed_status"
