/datum/storyteller_roll/fomor_regeneration
	bumper_text = "regeneration"
	difficulty = 6
	applicable_stats = list(STAT_STAMINA)
	numerical = FALSE
	roll_output_type = ROLL_PRIVATE

/datum/action/cooldown/power/fomori_power/regeneration
	name = "Regeneration"
	desc = "Recover from your wounds much the same as the bestial Garou do."
	button_icon_state = "regeneration"
	rank = 1 // of 1

/datum/action/cooldown/power/fomori_power/regeneration/Grant(mob/granted_to)
	. = ..()
	ADD_TRAIT(owner, TRAIT_FOMOR_REGEN, "regeneration")

/datum/action/cooldown/power/fomori_power/regeneration/Activate(atom/target)
	. = ..()
	var/datum/storyteller_roll/roll_datum = new /datum/storyteller_roll/fomor_regeneration
	var/roll_result = roll_datum.st_roll(owner)

	if(roll_result)
		force_heal()

/datum/action/cooldown/power/fomori_power/regeneration/proc/force_heal()
	var/mob/living/carbon/carbon_owner = astype(owner, /mob/living/carbon)

	//normal bashing/lethal damage
	carbon_owner.heal_ordered_damage(30, list(BRUTE, TOX, OXY, STAMINA))

	if(length(carbon_owner.all_wounds))
		for (var/i in 1 to min(rank, length(carbon_owner.all_wounds)))
			var/datum/wound/wound = carbon_owner.all_wounds[i]
			wound.remove_wound()

	//brain damage and traumas healing
	var/obj/item/organ/brain/brain = carbon_owner.get_organ_slot(ORGAN_SLOT_BRAIN)
	if (brain)
		brain.apply_organ_damage(-30)

		for (var/i in 1 to min(rank, length(brain.get_traumas_type())))
			var/datum/brain_trauma/healing_trauma = pick(brain.get_traumas_type())
			brain.cure_trauma_type(healing_trauma, resilience = TRAUMA_RESILIENCE_WOUND)

	//miscellaneous organ damage healing
	var/obj/item/organ/eyes/eyes = carbon_owner.get_organ_slot(ORGAN_SLOT_EYES)
	if (eyes)
		eyes.apply_organ_damage(-30)

		carbon_owner.adjust_temp_blindness(-6)
		carbon_owner.adjust_eye_blur(-6)

	carbon_owner.visible_message(
		span_warning("[carbon_owner]'s wounds heal with unnatural speed!"),
		span_warning("Your wounds visibly heal with unnatural speed!"))

	SEND_SIGNAL(carbon_owner, COMSIG_MASQUERADE_VIOLATION)

	//update UI
	carbon_owner.update_damage_overlays()
	carbon_owner.update_health_hud()
