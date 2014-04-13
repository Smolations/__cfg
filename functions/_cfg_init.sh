## /* @function
#   @usage _cfg_init
#
#   @output true (for errors and info)
#
#   @description
#   Initialize a new cfg for the current folder hierarchy. If one already exists,
#   either in the current directory or in some parent folder, the user will be
#   asked if they want to reset the cfg. If the user answers "yes," the existing
#   cfg will be removed and a new one will be created within the current directory.
#   description@
#
#   @dependencies
#   functions/_cfg_exists.sh
#   functions/_out.sh
#   functions/_set_cfg_vars.sh
#   functions/_w.sh
#   dependencies@
#
#   @file functions/_cfg_init.sh
## */

function _cfg_init {
    local cfg_dir cur_dir=$(pwd)

    if _cfg_exists; then
        _w "a cfg already exists for the current folder hierarchy."

        echo -n "${_B}-/> do you wish to reset it [y/N]? "
        read ans

        if ! egrep -q '[yY]' <<< "$ans"; then
            return 1
        fi

        rm -rf "${__CFG_DIR}/${CFG_DIR_NAME}"
        echo
    fi

    mkdir -p "$__CFG_DIR"
    touch "$__CFG_RAW"
    touch "$__CFG_PARSED"

    _out "initialized empty cfg at:  ${__CFG_DIR}"
}
export -f _cfg_init
