/datum/storyteller_roll/gift/enemy_ways
	applicable_stats = list(STAT_PERCEPTION)
	difficulty = 7
	numerical = TRUE

/datum/action/cooldown/power/gift/enemy_ways
	name = "Enemy Ways"
	// desc = ""
	// Put up here so the codeblock can interact with them
	var/waiting_clients = 0
	var/hostiles = 0

/datum/action/cooldown/power/gift/enemy_ways/Activate(atom/target)
	. = ..()
	var/datum/splat/werewolf/wolp_splat = get_werewolf_splat(owner)

	var/range = round(((wolp_splat?.renown[RENOWN_WISDOM] ? wolp_splat.renown[RENOWN_WISDOM] : 1) YARDS) * 20)

	waiting_clients = 0
	hostiles = 0

	for(var/mob/living/guy in oview(range, owner))
		if(guy.client)
			waiting_clients++
			ASYNC
				var/choice = tgui_alert(
					guy,
					"Answer truthfully wether or not your character would consider [GET_GUESTBOOK_NAME(guy, owner)]([owner.real_name]) an enemy.",
					"Is [GET_GUESTBOOK_NAME(guy, owner)] an Enemy?",
					list("Yes", "No", "Unsure"),
					10 SECONDS
				)
				if(choice == "Yes")
					hostiles += 1
				guy.log_message("Answered [choice ? choice : "Nothing"] when asked if [owner] was hostile via Enemy's Ways.", LOG_GAME)
				waiting_clients--
		else
			if(!guy.faction_check_atom(owner) && !guy.has_ally(owner))
				hostiles += 1

	if(waiting_clients > 0)
		ASYNC
			#define TIME_FOR_SLEEPS 0.5 SECONDS
			var/time_waited = 0
			while(waiting_clients > 0)
				if(time_waited >= 10 SECONDS)
					break
				time_waited += TIME_FOR_SLEEPS
				sleep(TIME_FOR_SLEEPS)
			#undef TIME_FOR_SLEEPS
			to_chat(owner, span_notice("The Grandfather Thunder's Stormcrow returns you its information. There are [hostiles] within [range] tiles."))
	else
		to_chat(owner, span_notice("The Grandfather Thunder's Stormcrow returns you its information. There are [hostiles] within [range] tiles."))

	return TRUE
