## /* @function
 #  @usage _set_cfg_vars <directory>
 #
 #  @output false
 #
 #  @vars
 #  __CFG_DIR
 #  __CFG_RAW
 #  __CFG_PARSED
 #  __CFG_TMP
 #  vars@
 #
 #  @description
 #  Sets the global cfg vars associated with the given directory.
 #  description@
 #
 #  @dependencies
 #  functions/_er.sh
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - invalid directory passed as argument
 #  returns@
 #
 #  @file functions/_set_cfg_vars.sh
 ## */

function _set_cfg_vars {
    if [ ! -d "$1" ]; then
        _er "_set_cfg_vars was passed an invalid directory. (${1})"
        return 1
    fi

    export __CFG_DIR="${1%/}/${CFG_DIR_NAME}"
    export __CFG_RAW="${__CFG_DIR}/cfg.cfg"
    export __CFG_PARSED="${__CFG_DIR}/cfg.parsed"
    export __CFG_TMP="${__CFG_DIR}/tmp"
}
export -f _set_cfg_vars
