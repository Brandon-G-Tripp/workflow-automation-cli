#!/usr/bin/env bats

# test_cli.bats
@test "CLI version flag" {
    run src/cli.sh --version
    echo "output = ${output}"
    [ $status = 0 ]
    [ $(echo $output | wc -l) = 1 ]
} 

# Test help flag 
@test "CLI should print help with -h flag" {
    run bash src/cli.sh -h
    [ "$status" -eq 0 ]
    [ "$output" = "Usage: cli.sh <workflow_name> [options]" ]
} 

# Test verbose flag 
@test "CLI should print verbose output with -v flag" {
    run bash src/cli.sh -v example
    [ "$status" -eq 0 ]
    [ "$output" = "Running example workflow verbose" ]
} 

# Test missing required arg
@test "CLI should print error for missing workflow name" {
    run bash src/cli.sh 
    [ "$status" -eq 1 ]
    [ "$output" = "Error: Missing required workflow name argument." ]
} 

# Test invalid workflow name
@test "CLI should print error for invalid workflow name" {
    run bash src/cli.sh invalid
    [ "$status" -eq 1 ]
    [ "$output" = "Error: Invalid workflow name 'invalid'." ]
} 

# Test passing workflow name
@test "CLI should run passed workflow name" {
    run bash src/cli.sh example
    [ "$status" -eq 0 ]
    [ "$output" = "Running example workflow" ]
} 
