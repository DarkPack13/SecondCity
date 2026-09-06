/datum/splat/werewolf/fomori
	name = "Fomori"
	desc = "Mortals who have lost themselves to the Wyrm's corruption. \
		A slow death of the self — most do not even realize what has happened to them before the bane takes over completely. \
		Tools of Dancers, and wretched things to mercifully be slain by Gaians. \
		You are but another pawn in a scheme older and grander than you could've ever imagined."

	id = SPLAT_FOMORI

	splat_priority = SPLAT_PRIO_FOMORI

	power_type = /datum/action/cooldown/power/fomori_power

	ttrpg_sources = list(/datum/source_book/freak_legion = 1)

	uses_veil = TRUE
	COOLDOWN_DECLARE(passive_healing_cd)
	COOLDOWN_DECLARE(worms_cd)

/datum/splat/werewolf/fomori/splat_life(seconds_per_tick)
	if(HAS_TRAIT(owner, TRAIT_FOMORI_REGEN))
		if(COOLDOWN_FINISHED(src, passive_healing_cd))
			owner.heal_storyteller_health(1, heal_scars = TRUE, heal_blood = TRUE)
			COOLDOWN_START(src, passive_healing_cd, 1 TURNS)

	if(HAS_TRAIT(owner, TRAIT_FOMORI_SCARY_PRESENCE)) // thanks abby
		for(var/mob/living/carbon/human/guy in oviewers(owner, 4))
			guy.apply_status_effect(/datum/status_effect/scary_presence, owner)

	if(HAS_TRAIT(owner, TRAIT_FOMORI_WORMS))
		if(COOLDOWN_FINISHED(src, worms_cd) && prob(50)) // Roughly once per min
			owner.visible_message(span_warning("Something beneath [owner]'s skin writhes grotesquely."), \
				span_warning("The corrupted worms beneath your skin writhe as they devour you from the inside."))
			owner.apply_damage(1, BRUTE, forced = TRUE, spread_damage = TRUE, wound_clothing = FALSE)
			COOLDOWN_START(src, worms_cd, 6 TURNS)

/mob/living/carbon/human/splat/fomori
	auto_splats = list(/datum/splat/werewolf/fomori)

/datum/splat/werewolf/fomori/on_gain() // WIP: Will be pointbuy eventually. Don't merge with this code in-tact
	// PHYSICAL POWERS
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/weapon/body_barbs, 1) // done, needs melee rework
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/claws, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/horns, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/fangs, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/chameleon_coloration, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/darksight, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/exoskeleton, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/regeneration, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/hide_of_the_wyrm, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/infectious_touch, 1)

	// MENTAL POWERS
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/berserker, 1) // need pointbuy
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/corrupted_visions, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/deception, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/eyes_of_the_wyrm, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/mind_blast, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/mind_reave, 1) // need 2 client testing
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/numbing, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/eyes_of_the_wyrm, 1)

	// TAINTS
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/worms, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/walking_bomb, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/inner_volcano, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/bane_attractor, 1)
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/rotting, 1)

/datum/splat/werewolf/fomori/get_power(power_type)
	RETURN_TYPE(/datum/action/cooldown/power/fomori_power)

	for(var/datum/action/cooldown/power/fomori_power/found_action as anything in powers)
		if(!istype(found_action, power_type))
			continue

		return found_action

/datum/splat/werewolf/fomori/add_power(power_type, level)
	// Prevent duplicates
	if(get_power(power_type))
		return FALSE
	var/datum/action/cooldown/power/fomori_power/adding_action = new power_type()
	adding_action.Grant(owner)
	LAZYADD(powers, adding_action)
	return TRUE

/datum/splat/werewolf/fomori/remove_power(power_type)
	var/datum/action/cooldown/power/fomori_power/found_action = get_power(power_type)
	if(!found_action)
		return FALSE

	LAZYREMOVE(powers, found_action)
	qdel(found_action)
	return TRUE
