#!/usr/bin/env bats

# Test verbose flag 
@test "CLI should print verbose output with -v flag" {
    run bash bin/cli.sh -v example
    [ "$status" -eq 0 ]
    [ "$output" = "Running example workflow verbose" ]
} 

# Test missing required arg
@test "CLI should print error for missing workflow name" {
    run bash bin/cli.sh 
    [ "$status" -eq 1 ]
    [ $(echo $output | grep "Error: Missing Workflow") ]
} 
