##
#   Colors
PRE=$'\033['
##
# semantic styles and colors
[ -n "${__NORM}" ]              || export __NORM=0
[ -n "${__BRIGHT}" ]            || export __BRIGHT=1
[ -n "${__DIM}" ]               || export __DIM=2
# foreground
[ -n "${__BLACK}" ]             || export __BLACK=30
[ -n "${__RED}" ]               || export __RED=31
[ -n "${__GREEN}" ]             || export __GREEN=32
[ -n "${__YELLOW}" ]            || export __YELLOW=33
[ -n "${__BLUE}" ]              || export __BLUE=34
[ -n "${__MAGENTA}" ]           || export __MAGENTA=35
[ -n "${__CYAN}" ]              || export __CYAN=36
[ -n "${__WHITE}" ]             || export __WHITE=37
# background
[ -n "${__BG_BLACK}" ]          || export __BG_BLACK=40
[ -n "${__BG_RED}" ]            || export __BG_RED=41
[ -n "${__BG_GREEN}" ]          || export __BG_GREEN=42
[ -n "${__BG_YELLOW}" ]         || export __BG_YELLOW=43
[ -n "${__BG_BLUE}" ]           || export __BG_BLUE=44
[ -n "${__BG_MAGENTA}" ]        || export __BG_MAGENTA=45
[ -n "${__BG_CYAN}" ]           || export __BG_CYAN=46
[ -n "${__BG_WHITE}" ]          || export __BG_WHITE=47
# styles
[ -n "${_BRIGHT}" ]             || export _BRIGHT="${PRE}${__BRIGHT}m"
[ -n "${_NORM}" ]               || export _NORM="${PRE}${__NORM}m"
[ -n "${_DIM}" ]                || export _DIM="${PRE}${__DIM}m"
# colors
[ -n "${_RED}" ]                || export _RED="${PRE}${__RED}m"
[ -n "${_GREEN}" ]              || export _GREEN="${PRE}${__GREEN}m"
[ -n "${_YELLOW}" ]             || export _YELLOW="${PRE}${__YELLOW}m"
[ -n "${_BLUE}" ]               || export _BLUE="${PRE}${__BLUE}m"
[ -n "${_MAGENTA}" ]            || export _MAGENTA="${PRE}${__MAGENTA}m"
[ -n "${_CYAN}" ]               || export _CYAN="${PRE}${__CYAN}m"
[ -n "${_WHITE}" ]              || export _WHITE="${PRE}${__WHITE}m"
[ -n "${_NORM}" ]               || export _NORM="${PRE}${__NORM}m"
#shortcuts
[ -n "${_X}" ]                  || export _X=${_NORM}
[ -n "${_B}" ]                  || export _B=${_BRIGHT}
[ -n "${_ER}" ]                 || export _ER=${_X}${_BRIGHT}${_RED}
[ -n "${_W}" ]                  || export _W=${_X}${_BRIGHT}${_YELLOW}
[ -n "${_O}" ]                  || export _O=${_X}${_BRIGHT}${_MAGENTA}
[ -n "${_S}" ]                  || export _S=${_X}${_BRIGHT}${_GREEN}
[ -n "${_ARG}" ]                || export _ARG=${_X}${_BRIGHT}${_CYAN}


##
#   Paths
##
export CFG_AWK_PATH="${__CFG_PATH}/awk"
export CFG_FN_PATH="${__CFG_PATH}/functions"
export CFG_SRC_PATH="${__CFG_PATH}/source"

##
#   Misc
##
export CFG_DIR_NAME=".cfg"
