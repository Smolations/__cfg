## /* @function
#   @usage __flgs_config < -l|--list >
#   @usage __flgs_config < --reset[=quiet] >
#   @usage __flgs_config get <key>
#   @usage __flgs_config set <key> <value>
#
#   @output true
#
#   @description
#   This function is used similarly to the git config functionality. The key=value pairs
#   are stored in flgs.config. Values can be retrieved and set using the get and set
#   commands respectively.
#   description@
#
#   @options
#   -l, --list             List all of the current key=value pairs.
#   --reset[=quiet]        Reset config file to default settings. If the "quiet"
#                          value is set, all non-error output is suppressed. This
#                          includes the confirmation prompt.
#   options@
#
#   @notes
#   - Using the -l or --list options will ignore any other parameters.
#   - When resetting, a backup of the config file is made and placed in
#   the temp/ directory.
#   notes@
#
#   @examples
#   1) __flgs_config get ssh-hosts
#   2) __flgs_config set ftp.user csmola
#   examples@
#
#   @dependencies
#   awkscripts/config-parse-key.awk
#   awkscripts/config-set-value.awk
#   functions/1000.__flgs_config_exists.sh
#   functions/1100.__flgs_config_search.sh
#   gitscripts/functions/0200.gslog.sh
#   dependencies@
#
#   @file functions/1200.__flgs_config.sh
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
