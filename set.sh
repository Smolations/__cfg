local PROJ="$1" KEY="$2" VAL="$3"

    [ -z "$PROJ" ] && {
        echo "${_ER}__cfg_set: You must provide a project name!${_X}"
        return 1
    }
    [ -z "$KEY" ] || [ -z "$VAL" ] && {
        echo "${_ER}__cfg_set: You must provide a key AND value!${_X}"
        return 1
    }

    ! __cfg_exists "$PROJ" && {
        echo "${_ER}__cfg_set: Cfg file for ${_ARG}${PROJ}${_ER} does not exist!${_X}"
        return 2
    }
