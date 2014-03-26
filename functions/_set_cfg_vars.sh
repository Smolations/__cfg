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
