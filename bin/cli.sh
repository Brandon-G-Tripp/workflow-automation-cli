#!/bin/bash
# source /Users/brandontripp/projects-software/personal/dataano-programming-learning-projects/scripting-projects/workflow-automation-cli/lib/shflags/shflags
# source /Users/brandontripp/projects-software/personal/dataano-programming-learning-projects/scripting-projects/workflow-automation-cli/lib/utils.sh
source ./lib/utils.sh

# Define long option names
LONGOPTS="help,version,verbose,workflow:"

# before getopts
echo "Before getopt"

# Parse options
ARGS=$(getopt -o "hVv:w:" --long "$LONGOPTS" -n "$0" -- "$@")
eval set -- "$ARGS"

while true; do 
    case $1 in
        -h|--help)
            #print exact help output 
            echo -e "Help output: $output"

            # print script name substitution
            echo "Script name: $0"

            # hard code expected string
            echo -e "Usage: cli.sh [-h] [-V] [-v] [-w <workflow>]"
            exit 0
            ;;
        -V|--version)
            echo -e "workflow v0.1.0"
            exit 0 
            ;;
        -v|--verbose)
            verbose=true
            shift
            ;;
        -w|--workflow)
            workflow="$2"
            shift 2
            ;;
        --)
            shift 
            break
            ;;
        *)
            echo "Invalid option: $1" >&2
            exit 1
            ;;
    esac
done

# after getopts
echo "After getopt"

workflow=${workflow:-example}

if [ "$verbose" == true ]; then
    echo -e "Running ${workflow} workflow verbose"
    exit 0
fi

# ensure workflow name passed
validate_params "$workflow" "workflow"

# add completion
complete -o bashdefault -o default -F _cli_completion cli.sh
# check workflow name exists
if [ ! -f "workflows/${workflow}.yaml" ]; then
    echo -e "Error: Invalid workflow name '${workflow}'."
    exit 1
fi

source "workflows/${workflow}.yaml"


