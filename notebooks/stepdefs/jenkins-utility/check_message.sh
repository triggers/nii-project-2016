#!/bin/bash

### colors

original='\033[0m'
red='\033[00;31m'
green='\033[00;32m'

### global variables

CHECK_MARK="[${green}\xE2\x9C\x93${original}]"
CROSS_MARK="[${red}\xE2\x9C\x97${original}]"

function pretty_message () {
    local message_format="${1}" ; shift
    local task="${1}"

    case "$message_format" in
        # style=0
        "task_completed"*)      echo -e "${green}${default_pass_message}${original}" ;;
        *"task_incomplete")     echo -e "${red}${default_fail_message}${original}" ;;
       
        #style=1
        "check_mark"*)          echo -e "$CHECK_MARK ${task}" ;;
        *"cross_mark")          echo -e "$CROSS_MARK ${task}" ;;

        #style=2
        "check_pass"*)          echo "${task} [ ok ]" ;;
        *"check fail")          echo "${task} [ fail ]" ;;
    esac
}

function check_message() {
    local status=${1} task="${2:-${default_pass_message}}"
    local output_mode_pass="${output_modep_pass:-$output_mode}"
    local output_mode_fail="${output_mode_fail:-$output_mode}"
    local format=(
        # Pass style       # Fail style
        "task_completed :: task_incomplete"
        "check_mark     :: cross_mark"
        "check_pass     :: check_fail"
    )
    case ${status} in
        0 | true) pretty_message "${format[$output_mode_pass]%::*}" "${task}" ;;
        1 | false)pretty_message "${format[$output_mode_fail]#*::}" "${task}" ;;
    esac
}
