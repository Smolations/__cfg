## /* @function
 #  @usage _cfg_rm <key> [<key> [...]]
 #
 #  @output false
 #
 #  @description
 #  Remove a key and any value associated with it from the current cfg.
 #  description@
 #
 #  @dependencies
 #  $__CFG_RAW
 #  $__CFG_TMP
 #  `grep`
 #  functions/_cfg_parse.sh
 #  functions/_cfg_search.sh
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - incorrect number of arguments
 #  2 - failed to replace $__CFG_RAW with $__CFG_TMP
 #  4 - _cfg_parse failed with new $__CFG_RAW
 #  returns@
 #
 #  @file functions/_cfg_rm.sh
 ## */

function _cfg_rm {
    local ret=0 key line

    if [ $# == 0 ]; then
        ret=1

    else
        while [ $# -gt 0 ]; do
            key="$1"

            if _cfg_search "$key"; then
                : > "$__CFG_TMP"

                # ..or `grep` chokes on keys using array syntax
                key=${key//[/\\[}
                key=${key//]/\\]}

                while read line; do
                    if ! grep -q "^${key}=" <<< "$line"; then
                        echo $line >> "$__CFG_TMP"
                    fi
                done < "$__CFG_RAW"

                if ! mv -f "$__CFG_TMP" "$__CFG_RAW"; then
                    ret=2
                fi
            fi

            shift
        done

        _cfg_parse || ret=4
    fi

    return $ret
}
export -f _cfg_rm
