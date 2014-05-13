## /* @function
 #  @usage __cfg init
 #  @usage __cfg [-d|-r]
 #  @usage __cfg [-r] <key>
 #  @usage __cfg - <key>
 #  @usage __cfg <key> <value>
 #
 #  @output true
 #
 #  @description
 #  This function is used similarly to the git config functionality. This one command
 #  is responsible for listing, getting, and setting of config key/values. When a
 #  new cfg is initialized, the current directory and all subdirectories will be
 #  considered to be under the purview of that cfg.
 #
 #  One difference between git's config and this one is that __cfg allows the user
 #  to remove a key (and any associated value) completely. See @examples for
 #  @usage details.
 #  description@
 #
 #  @options
 #  -d      Output the current cfg directory, if it exists.
 #  -r      Use the raw, unparsed config file to retrieve key/values.
 #  options@
 #
 #  @examples
 #  # lists all key=value pairs
 #  $ __cfg
 #
 #  # initialize new config in current directory
 #  $ __cfg init
 #
 #  # return value associated with ssh-hosts key
 #  $ __cfg ssh-hosts
 #
 #  # set:  ftp.user=csmola
 #  $ __cfg ftp.user csmola
 #
 #  # use a token to reference an existing value
 #  $ __cfg ftp.at "@{ftp.user}@myftpsite.com"
 #
 #  # remove a key (and any associated value)
 #  $ __cfg - ftp.user
 #
 #  # use raw cfg so tokens can be seen
 #  $ __cfg -r
 #  $ __cfg -r ssh-hosts
 #  examples@
 #
 #  @dependencies
 #  functions/_cfg_exists.sh
 #  functions/_cfg_get.sh
 #  functions/_cfg_init.sh
 #  functions/_cfg_rm.sh
 #  functions/_cfg_search.sh
 #  functions/_cfg_set.sh
 #  functions/_out.sh
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - could not find cfg
 #  returns@
 #
 #  @file functions/__cfg.sh
 ## */

function __cfg {
    local numArgs key val raw_flag="-r" exists=

    # since _cfg_exists sets the global cfg vars, we want to run it early. since
    # this conditional exits if a cfg doesn't exist, we have to isolate the use
    # case of "init" so that cfgs can actually be created.
    if [ "$1" != "init" ] && ! _cfg_exists; then
        _er "no cfg found. try \`__cfg init\` to create one here."
        return 1
    fi

    case $# in
        2)
            # check to see if user wants the raw value for a key
            case $1 in
                $raw_flag)
                    _cfg_get $raw_flag "$2";;

                -)
                    _cfg_rm "$2";;

                *)
                    _cfg_set "$1" "$2";;
            esac
            ;;

        1)
            case "$1" in
                "-d")
                    _out "\$__CFG_DIR = ${__CFG_DIR}";;

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
