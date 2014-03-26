
function _cfg_set {
    local KEY="$1" VAL="$2"

    _cfg_exists  || return 1
    [ -z "$KEY" ] || [ -z "$VAL" ] && return 2

    # find key. will need to replace value.
    if _cfg_search "$KEY"; then
        # make sure awk processing errors are caught
        if ! awk -v key="$KEY" -v value="$VAL" -f "${cfg_awk_path}/cfg-set-value.awk" "$cfg_cfg" > "$cfg_tmp"; then
            echo ${E}"  Error setting value in awk!  "${X}
        fi

    # key doesn't exist. we will append it to the config.
    else
        cp -f "$cfg_cfg" "$cfg_tmp"
        echo "${KEY}=${VAL}" >> "$cfg_tmp"
    fi

    # copy temp config to permanent config
    if cp -f "$cfg_tmp" "$cfg_cfg"; then
        _cfg_parse
        rm -f "$cfg_tmp"
        return 0
    else
        echo ${E}"  Unable to copy temporary configuration to permanent config file.  "${X}
        return 4
    fi
}
