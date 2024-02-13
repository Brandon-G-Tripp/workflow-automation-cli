# Run tests from project root
```bash
$ bats-core/bin/bats
```


## Dependencies 

- Shflags


### References 

* Shflags - https://github.com/kward/shflags/wiki/Documentation12x



####= Possible other options instead of shflags which is causing issues

if options="$(getopt -o abcdefghijklmnopqrstuvwxyz0123456789 -a \
    -l force,ram,help,version,debug -- "$@")"; then
    eval set -- "$options"
    while true; do
        case "${1,,}" in
            -f|--force)         # Disable "support_disk_compatibility"
                force=yes
                ;;
            -r|--ram)           # Disable "support_memory_compatibility"
                ram=yes
                ;;
            -h|--help)          # Show usage options
                usage
                ;;
            -v|--version)       # Show script version
                scriptversion
                ;;
            -d|--debug)         # Show and log debug info
                debug=yes
                ;;
            --)
                shift
                break
                ;;
            *)                  # Show usage options
                echo "Invalid option '$1'"
                usage "$1"
                ;;
        esac
        shift
    done
else
    usage
fi
