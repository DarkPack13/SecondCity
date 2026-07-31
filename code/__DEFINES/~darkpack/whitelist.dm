#define WHITELIST_TRUSTED "trusted"
#define WHITELIST_TIMELIMITS "timelimits"

GLOBAL_LIST_INIT(default_player_whitelists, default_player_whitelists())

/proc/default_player_whitelists()
	var/list/defs = list(SPLAT_NONE)

	for(var/splat_id in get_selectable_splats())
		var/splat_type = GLOB.splat_list[splat_id]
		var/datum/splat/splat = GLOB.splat_prototypes[splat_type]

		if(!splat.check_whitelist_requirement())
			defs += splat_id

	return defs

