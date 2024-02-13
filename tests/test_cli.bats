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
    expected=$(cat <<EOF
Help output: Usage: cli.sh [-h] [-V] [-v] [-w <workflow>]
Script name: bin/cli.sh
Usage: cli.sh [-h] [-V] [-v] [-w <workflow>]
EOF
)

    echo "Expected."
    echo "$expected"

    echo "Output:"
    echo "$output"

    run bash bin/cli.sh -h
    [ "$status" -eq 0 ]
    [ "$output" = "$expected" ]
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
