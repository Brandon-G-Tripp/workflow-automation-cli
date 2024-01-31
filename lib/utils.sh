#!/bin/bash

. ./lib/shflags/shflags

print_help() {
    cat <<EOF
Usage: cli.sh [options] <workflow>

Options: 
    -h, --help  Print this help message
    -v, --version  Print version
    -V, --verbose  Enable verbose output 
    -w, --workflow  The workflow to execute


Workflows:
    example  Description of example workflow 
    backup  Description of backup workflow 
    
EOF
} 

validate_params() {
    local arg_name=$1
    local error_msg=$2
    if [ -z "$arg_name" ]; then 
        echo "Error: $error_msg is required" >&2
        print_help
        exit 1
    fi
} 

_cli_completion() {
    local comp=$1

    if ["$comp" = "workflow_name" ]; then
        COMPREPLY=($(compgen -W "example backup" -- "$cur"))
    fi
} 
