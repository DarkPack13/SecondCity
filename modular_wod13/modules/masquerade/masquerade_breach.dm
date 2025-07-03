/**
 * Finds if an NPC is facing an atom
 *
 * Arguments:
 * * A - what's being checked for if the NPC is facing it
 */
/mob/living/carbon/human/npc/proc/backinvisible(atom/A)
	switch(dir)
		if(NORTH)
			if(A.y >= y)
				return TRUE
		if(SOUTH)
			if(A.y <= y)
				return TRUE
		if(EAST)
			if(A.x >= x)
				return TRUE
		if(WEST)
			if(A.x <= x)
				return TRUE
	return FALSE

/mob/living/proc/CheckEyewitness(mob/living/source, mob/attacker, range = 0, affects_source = FALSE)
	if (source.ignores_warrant)
		return

	// Visible range is multiplied by percentage of the attacker's visibility
	var/actual_range = max(1, round(range * (attacker.alpha / 255)))

	// Will be TRUE if an NPC witnesses this
	. = FALSE

	// NPCs within 1 tile aggro if facing the source
	for (var/mob/living/carbon/human/npc/NPC in oviewers(1, source))
		if (!NPC.can_npc_move())
			continue
		if(get_turf(src) == turn(NPC.dir, 180))
			continue
		NPC.Aggro(attacker, FALSE)
		. = TRUE

	// NPCs within effective range aggro if facing the source and the aggravator isn't in darkness
	for (var/mob/living/carbon/human/npc/NPC in viewers(actual_range, source))
		if (!NPC.can_npc_move())
			continue

		if (affects_source && (NPC == source))
			NPC.Aggro(attacker, TRUE)
			. = TRUE

		if (NPC.pulledby)
			continue

		var/turf/attacker_turf = get_turf(attacker)
		if ((attacker_turf.get_lumcount() <= 0.25) && (get_dist(NPC, attacker) > 1))
			continue
		if (!NPC.backinvisible(attacker))
			continue
		NPC.Aggro(attacker, FALSE)
		. = TRUE
