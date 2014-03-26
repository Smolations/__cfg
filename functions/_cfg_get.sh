# @param key
# @opt -o | --original
function _cfg_get {
    local file="${cfg_cfg_parsed}"
    local key="$1"
    [ -n "`egrep "\\-o |\\-\\-original " <<< "$@"`" ] && {
        # echo "use original"
        file="${cfg_cfg}"
        key="$2"
    }
    # echo "file: $file"

    local grepped=`egrep "^${key}=" "$file"`
    echo "${grepped#*=}"


    # [ -z "$2" ] &&
    # local grepped=`egrep "^$2"`
    # if __flgs_config_search "$2"; then
    #     awk -v key="$2" -f "${awkscripts_path}config-parse-key.awk" "$flgitscripts_config_parsed"
    #     return 0
    # else
    #     __gslog "__flgs_config: Key not found ($2)"
    #     return 1
    # fi
}
