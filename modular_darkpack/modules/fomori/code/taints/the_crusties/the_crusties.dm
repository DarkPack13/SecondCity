/datum/action/cooldown/power/fomori_power/crusties // Freak Legion pg. 42
	name = "The Crusties"
	desc = "Expel the crusties that writhe in your flesh, tearing you apart from the inside."
	button_icon_state = "crusties"
	rank = 1
	cooldown_time = 5 SCENES // 15 minutes

	ttrpg_sources = list(/datum/source_book/freak_legion = 42)


/datum/action/cooldown/power/fomori_power/crusties/Grant(mob/granted_to)
	. = ..()
	granted_to.AddElement(/datum/element/relay_attackers)
//	RegisterSignal(granted_to, COMSIG_ATOM_WAS_ATTACKED, PROC_REF(on_attacked))

/datum/action/cooldown/power/fomori_power/crusties/Remove(mob/removed_from)
	. = ..()
	removed_from.RemoveElement(/datum/element/relay_attackers)
//	UnregisterSignal(removed_from, COMSIG_ATOM_WAS_ATTACKED)
/*
/datum/action/cooldown/power/fomori_power/crusties/proc/on_attacked(atom/attacker, attack_flags, direction)
	switch(attack_flags)
		if(ATTACKER_STAMINA_ATTACK)
			create_crust(list(list(WEST, NORTHWEST, SOUTHWEST, NORTH), list(EAST, NORTHEAST, SOUTHEAST, SOUTH), list()))
		if(ATTACKER_SHOVING)
			create_crust(list(direction))
		if(ATTACKER_DAMAGING_ATTACK)
			create_crust(list(list(WEST, NORTHWEST, SOUTHWEST, NORTH), list(EAST, NORTHEAST, SOUTHEAST, SOUTH), list()))
		if(ATTACK_RANGED)
			create_crust(list(direction))
*/
