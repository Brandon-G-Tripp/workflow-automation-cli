#!/bin/bash
# cli.sh
#
. ./lib/shflags/shflags

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

# get workflow name (first positional arg)
workflow_name=$1

# ensure workflow name passed
if [ -z "$workflow_name" ]; then
    echo "Error: Missing required workflow name argument."
    exit 1
fi

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


