
function __cfg_init {
    local cfg_dir cur_dir=$(pwd)

    # if [ -d "$cur_dir" ]; then
    if __cfg_exists; then
        __w "a cfg already exists for the current folder hierarchy."

        echo -n "${_B}-/> do you wish to reset it [y/N]? "
        read ans

        if ! grep 'yY' <<< "$ans"; then
            return 1
        fi

        rm -rf "${__CFG_DIR}/.cfg"
    fi

    export __CFG_DIR="$cur_dir"
    cfg_dir="${__CFG_DIR}/.cfg"

    mkdir -p "$cfg_dir"
    touch "${cfg_dir}/cfg.parsed"
    touch "${cfg_dir}/cfg.cfg"

    __out "initialized empty cfg."
}
