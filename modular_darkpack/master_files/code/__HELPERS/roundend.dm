/datum/controller/subsystem/ticker/survivor_report(popcount)
	var/list/parts = list()

	if(GLOB.round_id)
		var/statspage = CONFIG_GET(string/roundstatsurl)
		var/info = statspage ? "<a href='byond://?action=openLink&link=[url_encode(statspage)][GLOB.round_id]'>[GLOB.round_id]</a>" : GLOB.round_id
		parts += "[FOURSPACES]Round ID: <b>[info]</b>"
	parts += "[FOURSPACES]World Map: [SSmapping.current_map?.return_map_name()]"
	parts += "[FOURSPACES]Round Duration: <B>[DisplayTimeText(world.time - SSticker.round_start_time)]</B>"

	var/total_players = GLOB.joined_player_list.len
	if(total_players)
		parts += "[FOURSPACES]Total Population: <B>[total_players]</B>"
		parts += "[FOURSPACES]Survival Rate: <B>[popcount[POPCOUNT_SURVIVORS]] ([PERCENT(popcount[POPCOUNT_SURVIVORS]/total_players)]%)</B>"
		if(SSblackbox.first_death)
			var/list/ded = SSblackbox.first_death
			if(ded.len)
				parts += "[FOURSPACES]First Death: <b>[ded["name"]], [ded["role"]], at [ded["area"]]. Damage taken: [ded["damage"]].[ded["last_words"] ? " Their last words were: \"[ded["last_words"]]\"" : ""]</b>"
			//ignore this comment, it fixes the broken sytax parsing caused by the " above
			else
				parts += "[FOURSPACES]<i>Nobody died this shift!</i>"

	parts += "[FOURSPACES]Round: [SSdynamic.current_tier.name]"
	for(var/datum/dynamic_ruleset/rule as anything in SSdynamic.executed_rulesets - SSdynamic.unreported_rulesets)
		parts += "[FOURSPACES][FOURSPACES]- <b>[rule.name]</b> ([rule.config_tag])"

	return parts.Join("<br>")

/datum/controller/subsystem/ticker/market_report()
	return
