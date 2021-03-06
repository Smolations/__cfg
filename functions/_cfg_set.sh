## /* @function
 #  @usage _cfg_set <key> <value>
 #
 #  @output true (on error)
 #
 #  @description
 #  Set a value for a given key. If the key exists, it will be overwritten. You may
 #  key tokens in order to reference earlier keys in later values. Simply provide
 #  @{key} within a value, and the value for that key will automatically be
 #  substituted in the parsed cfg file. The best part about this is that editing
 #  a key which is referenced in some other value will automatically update that
 #  other value when the key id modified.
 #  description@
 #
 #  @notes
 #  - keys must not contain an equals sign, but can contain almost any other
 #  character.
 #  notes@
 #
 #  @examples
 #  $ _cfg_set age 30
 #  $ _cfg_set out "I am @{age} years old."
 #  examples@
 #
 #  @dependencies
 #  `grep`
 #  `awk`
 #  awk/cfg-set-value.awk
 #  functions/_cfg_parse.sh
 #  functions/_cfg_search.sh
 #  functions/_er.sh
 #  functions/_kill_tmp.sh
 #  dependencies@
 #
 #  @returns
 #  0 - successful execution
 #  1 - incorrect number of arguments passed to function
 #  2 - <key> contains a '=' character
 #  4 - the cfg awk process failed when setting the value
 #  8 - could not overwrite the cfg file with the work file data
 #  returns@
 #
 #  @file functions/_cfg_set.sh
 ## */

function _cfg_set {
    local numArgs="$#" KEY="$1" VAL

    shift
    VAL="$@"

    # key/value cannot be empty
    if [ $numArgs -lt 2 ]; then
        _er "_cfg_set requires two arguments. Given: $@"
        return 1
    fi

    # key cannot contain an equals sign
    if grep -q '=' <<< "$KEY"; then
        _er "_cfg_set: KEY must not contain an equals sign (=)."
        return 2
    fi

    # find key. will need to replace value.
    if _cfg_search "$KEY"; then
        # make sure awk processing errors are caught
        if ! awk -v key="$KEY" -v value="$VAL" -f "${CFG_AWK_PATH}/cfg-set-value.awk" "$__CFG_RAW" > "$__CFG_TMP"; then
            _er "_cfg_set: error setting value in awk."
            return 4
        fi

    # key doesn't exist. we will append it to the config.
    else
        cp -f "$__CFG_RAW" "$__CFG_TMP"
        echo "${KEY}=${VAL}" >> "$__CFG_TMP"
    fi

    # copy temp config to permanent config
    if cp -f "$__CFG_TMP" "$__CFG_RAW"; then
        # since this uses the tmp file, it also deletes it.
        # luckily, we're done with it after the copy.
        _cfg_parse

    else
        _er "unable to copy temporary configuration to permanent config file."
        _kill_tmp
        return 8
    fi

    return 0
}
export -f _cfg_set
