print_help() {
    cat <<- EOF
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
