/datum/splat/werewolf/fomori
	name = "Fomori"
	desc = "Mortals who have lost themselves to the Wyrm's corruption. \
		A slow death of the self — most do not even realize what has happened to them before the bane takes over completely. \
		Tools of Dancers, and wretched things to mercifully be slain by Gaians. \
		You are but another pawn in a scheme older and grander than you could've ever imagined."

	id = SPLAT_FOMORI

	splat_priority = SPLAT_PRIO_FOMORI

	power_type = /datum/action/cooldown/power/fomori_power

	uses_veil = TRUE
	COOLDOWN_DECLARE(passive_healing_cd)

/datum/splat/werewolf/fomori/splat_life(seconds_per_tick)
	if(HAS_TRAIT(owner, TRAIT_FOMOR_REGEN))
		if(COOLDOWN_FINISHED(src, passive_healing_cd))
			owner.heal_storyteller_health(1, heal_scars = TRUE, heal_blood = TRUE)
			COOLDOWN_START(src, passive_healing_cd, 1 TURNS)

/mob/living/carbon/human/splat/fomori
	auto_splats = list(/datum/splat/werewolf/fomori)

/datum/splat/werewolf/fomori/on_gain() // WIP: Will be pointbuy eventually. Don't merge with this code in-tact
	// PHYSICAL POWERS
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/weapon/body_barbs, 1) // done
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/weapon/claws, 1) // done
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/horns, 1) // unfinished
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/fangs, 1) // done
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/chameleon_coloration, 1) // done
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/darksight, 1) // done
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/exoskeleton, 1) // done
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/regeneration, 1) // done
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/hide_of_the_wyrm, 1) // done
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/infectious_touch, 1) // done
	// MENTAL POWERS
//	owner.give_st_power(/datum/action/cooldown/power/fomori_power/berserker, 1)
	owner.give_st_power(/datum/action/cooldown/power/fomori_power/corrupted_visions, 1)

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
