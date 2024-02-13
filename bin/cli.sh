#!/bin/bash
# source /Users/brandontripp/projects-software/personal/dataano-programming-learning-projects/scripting-projects/workflow-automation-cli/lib/shflags/shflags
# source /Users/brandontripp/projects-software/personal/dataano-programming-learning-projects/scripting-projects/workflow-automation-cli/lib/utils.sh
source ./lib/utils.sh

# Define long option names
# LONGOPTS="help,version,verbose,workflow:"
# eval set -- $(getopt --long "$LONGOPTS" -- "$@")

# echo " longopts: $LONGOPTS"

# # shortopts
# SHORTOPTS=$(getopt -o "hVvw:" -n "cli.sh" -- "$@")
# eval set -- $SHORTOPTS

# echo "shortopts: $SHORTOPTS"

OPTS=$(getopt -o "" --long help,version,verbose,workflow: -- "$@")
eval set -- "$OPTS"

#  Set default workflow
# workflow=${workflow:-example}

while true; do 
    case $1 in 
        --help) HELP=1; shift;;
        --version) VERSION=1; shift;;
        --workflow) WORKFLOW=$2; shift 2;;
        --) shift; break;;
    esac
done

while getopts ":hvw:" opt; do 
    case $opt in 
        h) HELP=1;;
        v) VERBOSE=1;;
        w) WORKFLOW=$OPTARG;;
    esac
done


shift $((OPTIND -1))

COMMAND=$1

if [[ -z "$WORKFLOW" ]]; then 
    WORKFLOW=$1
fi 


# while true;  
#     echo "first arg $1, second arg $2"
#     echo "all args $@"
#     case $1 in
#         -h|--help)
#             help=true
#             shift
#             ;;
#         -V|--version)
#             echo -e "workflow v0.1.0"
#             exit 0 
#             ;;
#         -v|--verbose)
#             verbose=true
#             ;;
#         -w|--workflow)
#             workflow="$2"
#             shift 2
#             ;;
#         --)
#             shift 
#             break
#             ;;
#         *)
#             echo "Invalid option: $1" >&2
#             exit 1
#             ;;
#     esac
# done

if [ "$HELP" != 1 ]; then 
    validate_params "$WORKFLOW" "Workflow"
fi

if [ "$HELP" == 1 ]; then 
    print_help 
    exit 0;
fi

if [ "$VERSION" == 1 ]; then 
    echo -e "workflow v0.1.0"
    exit 0;
fi 



# after getopts
echo "After getopt"
echo "Option: $1 Value: $2"


echo "Workflow name: $workflow"

if [ "$verbose" == true ]; then
    echo -e "Running ${WORKFLOW} workflow verbose"
    exit 0
fi

# add completion
complete -o bashdefault -o default -F _cli_completion cli.sh
# check workflow name exists
if [ ! -f "workflows/${WORKFLOW}.yaml" ]; then
    echo -e "Error: Invalid workflow name '${WORKFLOW}'."
    exit 1
fi

source "workflows/${WORKFLOW}.yaml"


