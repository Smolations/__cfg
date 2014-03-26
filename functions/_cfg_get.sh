# @param key
# @opt -o | --original
function _cfg_get {
    local grepped file="${__CFG_PARSED}"

    if egrep -q "\\-o |\\-\\-original " <<< "$@"; then
    # [ -n "`egrep "\\-o |\\-\\-original " <<< "$@"`" ] && {
        # echo "use original"
        file="${__CFG_RAW}"
        shift
    fi
    # echo "file: $file"

    grepped=$(egrep "^${1}=" "$file")
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
