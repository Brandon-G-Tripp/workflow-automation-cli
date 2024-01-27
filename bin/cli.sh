#!/bin/bash
# cli.sh
#
. ./lib/shflags/shflags
. ./lib/utils.sh

# Define options to parse
OPTIONS=(
    "--help, -h:Show usage information"
    "--version, -v:Print version"
    "--verbose, -V:Enable verbose logging"
    "--workflow=-w:The workflow to execute"
) 

# Parse command line args
FLAGS=$(shflags ${OPTIONS[@]} $@)


# Check for help flag 
if [ ${FLAGS[h]} ]; then
    echo -n "Usage: cli.sh <workflow_name> [options]" 
    exit 0 
fi

# ensure workflow name passed
validate_params "${FLAGS[w]}" "Workflow"

# check workflow name exists
if [ ! -f "workflows/$workflow_name.yaml" ]; then
    echo "Error: Invalid workflow name '$workflow_name'."
    exit 1
fi

# run workflow 
if [ $verbose ]; then 
    echo "Running $workflow_name workflow verbose"
fi

source "workflows/$workflow_name.yaml"


