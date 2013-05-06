## /* @function
#	@usage __cfg_search <key>
#
#	@output false
#
#	@description
#	Searches the flgs.config file for the existence of the given key. It does not matter
#	whether or not the key has an associated value.
#	description@
#
#	@notes
#	- Intended for use with conditionals as return values are specified.
#	notes@
#
#	@examples
#	# some operations may include uploading/downloading via (s)ftp
#	if __flgs_config_search ftp.user; then
#	    user=$(flgs_config get ftp.user)
#	    # interact with ftp...
#	fi
#	examples@
#
#	@dependencies
#	functions/1000.flgs_config_exists.sh
#	gitscripts/functions/0200.gslog.sh
#	dependencies@
#
#	@file functions/__cfg_search.sh
## */
function __cfg_search {
	__cfg_exists || return 2
	[ -z "$1" ] && return 4

	egrep -q "^${1}=" "${cfg_cfg}"
}
