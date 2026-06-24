/datum/storyteller_roll/numbing
	bumper_text = "numbing"
	applicable_stats = list(STAT_STAMINA, STAT_MEDICINE)

/datum/action/cooldown/power/fomori_power/numbing
	name = "Numbing"
	desc = "Spend a willpower point to temporarily feel no pain."
	button_icon_state = "numbing"
	rank = 1 // of 1
	willpower_cost = 1
	cooldown_time = 1 SCENES
	var/beforehealth
	var/afterhealth

/datum/action/cooldown/power/fomori_power/numbing/Activate()
	. = ..()
	var/mob/living/caster = owner
	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/numbing
	var/roll_result = roll_datum.st_roll(owner)

	if(roll_result == ROLL_SUCCESS)
		if(!caster.has_quirk(/datum/quirk/numb))
			caster.add_quirk(/datum/quirk/numb)
			addtimer(CALLBACK(src, PROC_REF(end_numbness)), 1 SCENES)

			beforehealth = caster.health
			caster.heal_storyteller_health(3)
			afterhealth = caster.health
		var/obj/item/organ/tongue/our_tongue = owner.get_organ_slot(ORGAN_SLOT_TONGUE)
		if(our_tongue)
			our_tongue.on_begin_failure()

	StartCooldown()
	return TRUE

/datum/action/cooldown/power/fomori_power/numbing/proc/end_numbness()
	var/mob/living/caster = owner

	caster.remove_quirk(/datum/quirk/numb)
	caster.take_overall_damage(brute = abs(afterhealth-beforehealth))

	var/obj/item/organ/tongue/our_tongue = owner.get_organ_slot(ORGAN_SLOT_TONGUE)
	if(our_tongue)
		our_tongue.on_failure_recovery()
