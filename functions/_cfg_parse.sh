#!/bin/bash

function _cfg_parse {
    local key val

    cat /dev/null > "$cfg_tmp";
    cat /dev/null > "$cfg_cfg_parsed";

    # begin looping through each line of the cfg file
    while read line; do
        # match a cfg key=value pair
        if egrep -q '^[a-zA-Z0-9][.a-zA-Z0-9]+=.*$' <<< "$line"; then
            key="${line%%=*}"
            val="${line#*=}"
            echo
            echo "${A}${key}${X}=${S}${val}${X}";

            # save the key pattern (\@\{key\.pattern\}) to a file. this is a running list.
            echo "\\@\\{${key//\./\\.}\\}" >> "$cfg_tmp"

            # echo
            # echo "${S}val${X}: $val"
            # look for any of the keys being referenced in the value of the current line
            theMatch=`egrep --only-matching --file="$cfg_tmp" <<< "$val"`
            echo "${_B}theMatch:${_X} $theMatch"
            if [ -z "$theMatch" ]; then
                # if no match, just output the line to the parsed file.
                echo "'${key}=${val}' ${_YELLOW}>>${_X} '$cfg_cfg_parsed'"
                echo "${key}=${val}" >> "$cfg_cfg_parsed"

            else
                # now find out which key it is, and replace the key reference with that key's parsed value.
                bareMatch=`egrep --only-matching '\{[a-zA-Z0-9][.a-zA-Z0-9]+\}' <<< "$theMatch"`
                bareMatch="${bareMatch//[\{\}]/}"
                echo "${_B}bareMatch:${_X} ${bareMatch}"
                echo "__cfg_get --original '${bareMatch}' = `__cfg_get --original "${bareMatch}"`"
                echo "'${key}=${val//$theMatch/`__cfg_get "${bareMatch}"`}' ${_YELLOW}>>${_X} '$cfg_cfg_parsed'"
                echo "${key}=${val//$theMatch/`__cfg_get "${bareMatch}"`}" >> "$cfg_cfg_parsed"
            fi
        else
            echo "${line}" >> "$cfg_cfg_parsed"
        fi
    done <"${cfg_cfg}"
    #rm -f "$cfg_tmp"
    # echo
    # echo "${S}Parsed file${X}:"
    # cat "$cfg_cfg_parsed"
}


