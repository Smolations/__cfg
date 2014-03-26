
function _cfg_parse {
    local key val

    : > "$__CFG_TMP"
    : > "$__CFG_PARSED"

    # begin looping through each line of the cfg file
    while read line; do
        # match a cfg key=value pair
        if egrep -q '^[a-zA-Z0-9][.a-zA-Z0-9]+=.*$' <<< "$line"; then
            key="${line%%=*}"
            val="${line#*=}"
            echo
            echo "${A}${key}${X}=${S}${val}${X}"

            # save the key pattern (\@\{key\.pattern\}) to a file. this is a running list.
            echo "\\@\\{${key//\./\\.}\\}" >> "$__CFG_TMP"

            # echo
            # echo "${S}val${X}: $val"
            # look for any of the keys being referenced in the value of the current line
            theMatch=$(egrep --only-matching --file="$__CFG_TMP" <<< "$val")
            echo "${_B}theMatch:${_X} $theMatch"

            if [ -z "$theMatch" ]; then
                # if no match, just output the line to the parsed file.
                echo "'${key}=${val}' ${_YELLOW}>>${_X} '$__CFG_PARSED'"
                echo "${key}=${val}" >> "$__CFG_PARSED"

            else
                # now find out which key it is, and replace the key reference with that key's parsed value.
                bareMatch=$(egrep --only-matching '\{[a-zA-Z0-9][.a-zA-Z0-9]+\}' <<< "$theMatch")
                bareMatch="${bareMatch//[\{\}]/}"

                echo "${_B}bareMatch:${_X} ${bareMatch}"
                echo "_cfg_get --original '${bareMatch}' = `_cfg_get --original "${bareMatch}"`"
                myget=$(_cfg_get "${bareMatch}")
                echo "'${key}=${val//$theMatch/$myget}' ${_YELLOW}>>${_X} '$__CFG_PARSED'"
                echo "${key}=${val//$theMatch/$myget}" >> "$__CFG_PARSED"
            fi
        else
            echo "${line}" >> "$__CFG_PARSED"
        fi
    done < "${__CFG_RAW}"

    #rm -f "$cfg_tmp"
    # echo
    # echo "${S}Parsed file${X}:"
    # cat "$cfg_cfg_parsed"
}


