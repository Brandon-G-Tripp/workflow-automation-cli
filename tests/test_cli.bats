#!/usr/bin/env bats

# test_cli.bats
@test "CLI version flag" {
    run bin/cli.sh --version
    echo "output = ${output}"
    [ $status = 0 ]
    [ $(echo $output | wc -l) = 1 ]
} 

# Test help flag 
@test "CLI should print help with -h flag" {
    run bash bin/cli.sh -h
    [ "$status" -eq 0 ]
    [ "$output" = "Usage: $0 [-h] [-V] [-v] [-w <workflow>]" ]
} 



# Test invalid workflow name
@test "CLI should print error for invalid workflow name" {
    run bash bin/cli.sh invalid
    [ "$status" -eq 1 ]
    [ "$output" = "Error: Invalid workflow name 'invalid'." ]
} 

# Test passing workflow name
@test "CLI should run passed workflow name" {
    run bash bin/cli.sh example
    [ "$status" -eq 0 ]
    [ "$output" = "Running example workflow" ]
} 
