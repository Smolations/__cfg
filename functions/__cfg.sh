## /* @function
#   @usage __cfg [-d|-r]
#   @usage __cfg [-r] <key>
#   @usage __cfg <key> <value>
#
#   @output true
#
#   @description
#   This function is used similarly to the git config functionality. This one command
#   is responsible for listing, getting, and setting of config key/values.
#   description@
#
#   @options
#   -d      Output the current cfg directory, if it exists.
#   -r      Use the raw, unparsed config file to retrieve key/values.
#   options@
#
#   @examples
#   1) __cfg
#   2) __cfg -r
#   3) __cfg ssh-hosts
#   4) __cfg -r ssh-hosts
#   5) __cfg ftp.user csmola
#   examples@
#
#   @dependencies
#   functions/_cfg_exists.sh
#   functions/_cfg_get.sh
#   functions/_cfg_search.sh
#   functions/_cfg_set.sh
#   dependencies@
#
#   @file functions/__cfg.sh
## */
function __cfg {
    local numArgs key val raw_flag="-r"

    if ! _cfg_exists; then
        _er "no cfg found. try \`__cfg init\`."
        return 1
    fi

    case $# in
        2)
            # check to see if user wants the raw value for a key
            if [ "$1" == "$raw_flag" ]; then
                _cfg_get -o "$2"
            else
                _cfg_set "$1" "$2"
            fi
            ;;

        1)
            case "$1" in
                "-d")
                    _out "current cfg directory = ${__CFG_DIR}";;

                $raw_flag)
                    # output entire contents of $__CFG_RAW
                    cat "$__CFG_RAW";;

                "init")
                    _cfg_init;;

                *)
                    # retrieve value for key
                    _cfg_get "$1"
            esac
            ;;

        *)
            # output current, parsed config
            # color coated?
            cat "$__CFG_PARSED"
    esac
}
export -f __cfg
