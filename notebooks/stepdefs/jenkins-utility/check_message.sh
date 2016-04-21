#!/bin/bash

### colors

original='\033[0m'
red='\033[00;31m'
green='\033[00;32m'


function pretty_message () {
    local format_mode="${1}" ; shift
    local task="${1}"

    case "$format_mode" in
        # output_mode=0
        "complete")
            echo -e "${green}${default_pass_message}${original}" ;;
        "incomplete")
            echo -e "${red}${default_fail_message}${original}" ;;
        # output_mode=1
        "check_mark")
            echo -e "$CHECK_MARK ${task}" ;;
        "cross_mark")
            echo -e "$CROSS_MARK ${task}" ;;
        # output_mode=2
        "check_pass")
            echo "${task} [ ${green}OK${original} ]" ;;
        "check fail")
            echo "${task} [ ${green}FAILED${original} ]" ;;
    esac
}

function check_message() {
    local return_code=${1} task="${2:-$default_pass_message}"
    local output_mode_pass="${output_modep_pass:-$output_mode}"
    local output_mode_fail="${output_mode_fail:-$output_mode}"
    # pass::fail
    local format=(
        "complete::incomplete"
        "check_mark::cross_mark"
        "check_pass::check_fail"
    )
    case ${return_code} in
        0 | true)
            pretty_message "${format[$output_mode_pass]%::*}" "${task}" ;;
        1 | false)
            pretty_message "${format[$output_mode_fail]#*::}" "${task}" ;;
    esac
}
