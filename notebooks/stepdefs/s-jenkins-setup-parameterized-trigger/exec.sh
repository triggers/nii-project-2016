test_passed=false

check_plugins_exists "parameterized-trigger" && test_passed=true
check_message $test_passed "$plugin_installed_status"
