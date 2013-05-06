## /*
#	@usage __cfg_exists
#
#	@output false
#
#	@description
#	Shortcut for testing that the cfg file exists and is non-empty.
#	description@
#
#	@notes
#	- Meant for use in conditionals.
#	notes@
#
#	@examples
#	# get the value associated with "mykey" in the config file
#	__cfg_exists && myvar=`__cfg get mykey`
#	examples@
#
#	@file functions/__cfg_exists.sh
## */
function __cfg_exists {
	[ -a "${cfg_cfg}" ]
}
