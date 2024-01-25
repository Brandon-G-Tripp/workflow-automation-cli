# test_cli.bats
@test "CLI version flag" {
    run src/cli.sh --version
    echo "output = ${output}"
    [ $status = 0 ]
    [ $(echo $output | wc -l) = 1 ]
} 
