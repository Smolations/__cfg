
function _cfg_init {
    local cfg_dir cur_dir=$(pwd)

    # if [ -d "$cur_dir" ]; then
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

    _set_cfg_vars "${cur_dir}"

    mkdir -p "$__CFG_DIR"
    touch "$__CFG_RAW"
    touch "$__CFG_PARSED"

    _out "initialized empty cfg at the current path."
}
