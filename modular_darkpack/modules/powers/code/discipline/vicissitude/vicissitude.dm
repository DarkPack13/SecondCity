#define HORRID_FORM_SOURCE "Horrid Form"
// Level 1: Shapeshift Self
// Level 2: Shapeshift Other
// Level 3: Damage others and self.
// Level 4: Shapeshift into a Horrid Form
// Level 5: Slimegirl tzimisce

/datum/discipline/vicissitude
	name = "Vicissitude"
	desc = "It is widely known as Tzimisce art of flesh and bone shaping. Violates Masquerade."
	icon_state = "vicissitude"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/vicissitude

/datum/discipline/vicissitude/post_gain()
	. = ..()
	owner.add_faction(VAMPIRE_CLAN_TZIMISCE)

////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude
	name = "Vicissitude power name"
	desc = "Vicissitude power description"

	var/datum/action/cooldown/mob_cooldown/shapeshift/shapeshift_ability

/datum/discipline_power/vicissitude/post_gain()
	if(!shapeshift_ability)
		shapeshift_ability = new(owner)
	shapeshift_ability.Grant(owner)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/malleable_visage
	name = "Malleable Visage"
	desc = "Shapeshift yourself."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = NONE
	cooldown_length = 1 TURNS
	vitae_cost = 1
	toggled = FALSE

/datum/discipline_power/vicissitude/malleable_visage/activate(atom/target)
	. = ..()
	shapeshift_ability.Activate(owner)
	return TRUE

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/fleshcrafting
	name = "Fleshcrafting"
	desc = "Shapeshift yourself or others."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_SELF | TARGET_HUMAN
	vitae_cost = 1
	range = 1
	toggled = FALSE
	cooldown_length = 1 TURNS

/datum/discipline_power/vicissitude/fleshcrafting/activate(atom/movable/target)
	. = ..()
	shapeshift_ability.Activate(target)
	return TRUE

/datum/discipline_power/vicissitude/fleshcrafting/post_gain()
	. = ..()
	var/obj/item/organ/cyberimp/arm/toolkit/surgery/vicissitude/surgery_implant = new()
	surgery_implant.Insert(owner)
	RegisterSignal(owner, COMSIG_LIVING_OPERATING_ON, PROC_REF(add_surgery))

/datum/discipline_power/vicissitude/fleshcrafting/Destroy(force)
	UnregisterSignal(owner, COMSIG_LIVING_OPERATING_ON)
	return ..()

/datum/discipline_power/vicissitude/fleshcrafting/proc/add_surgery(datum/source, atom/movable/operating_on, list/possible_operations)
	SIGNAL_HANDLER

	var/static/list/tzimisce_operations
	if(!length(tzimisce_operations))
		tzimisce_operations = list()
		tzimisce_operations += /datum/surgery_operation/basic/tend_wounds/combo/upgraded/master
		tzimisce_operations += /datum/surgery_operation/limb/add_plastic
		tzimisce_operations += typesof(/datum/surgery_operation/limb/bioware)
		tzimisce_operations += typesof(/datum/surgery_operation/organ/brainwash)
		tzimisce_operations += typesof(/datum/surgery_operation/organ/lobotomy)
		tzimisce_operations += typesof(/datum/surgery_operation/organ/pacify)
		tzimisce_operations += /datum/surgery_operation/organ/eye_color_surgery

	possible_operations |= tzimisce_operations

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/bonecrafting
	name = "Bonecrafting"
	desc = "Forcefully injure a body."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = TARGET_MOB
	vitae_cost = 1
	range = 1
	toggled = FALSE
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE
	activate_sound = 'modular_darkpack/modules/powers/sounds/vicissitude.ogg'
	cooldown_length = 1 TURNS

/datum/discipline_power/vicissitude/bonecrafting/activate(mob/living/target)
	. = ..()

	var/roll = SSroll.storyteller_roll((owner.st_get_stat(STAT_STRENGTH) + owner.st_get_stat(STAT_MEDICINE)), 7, owner, target, TRUE)

	if(target.stat >= HARD_CRIT)
		if(target.stat != DEAD)
			target.death()
		var/obj/item/bodypart/arm/right/r_arm = target.get_bodypart(BODY_ZONE_R_ARM)
		var/obj/item/bodypart/arm/left/l_arm = target.get_bodypart(BODY_ZONE_L_ARM)
		var/obj/item/bodypart/leg/right/r_leg = target.get_bodypart(BODY_ZONE_R_LEG)
		var/obj/item/bodypart/leg/left/l_leg = target.get_bodypart(BODY_ZONE_L_LEG)
		r_arm?.drop_limb()
		l_arm?.drop_limb()
		r_leg?.drop_limb()
		l_leg?.drop_limb()
		new /obj/item/stack/human_flesh/twenty(target.loc)
		new /obj/item/guts(target.loc)
		new /obj/item/spine(target.loc)
		qdel(target)
	else
		target.emote("scream")
		target.apply_damage(roll * 30, BRUTE, BODY_ZONE_CHEST)
		if(roll >= 5)
			target.visible_message(span_danger("[target]'s rib cage curves inwards grotesquely!"), span_danger("Your feel your ribcages curve inwards and pierce your heart!"))
			target.adjust_blood_pool(-(round(target.bloodpool * 0.5))) // A vampire who scores five or more successes on the roll (...) cause the affected vampire to lose half his blood points.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/horrid_form
	name = "Horrid Form"
	desc = "Force yourself to become something truly monstrous."

	level = 4
	violates_masquerade = TRUE
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND | DISC_CHECK_IMMOBILE
	target_type = NONE
	vitae_cost = 2
	toggled = TRUE
	aggravating = TRUE
	cooldown_length = 1 TURNS
	activate_sound = 'modular_darkpack/modules/powers/sounds/vicissitude.ogg'
	var/list/obj/item/bodypart/strengthened_limbs

/datum/discipline_power/vicissitude/horrid_form/pre_activation_checks()
	. = ..()
	owner.Stun(1 TURNS)
	owner.do_jitter_animation(1 TURNS)
	if(!do_after(owner, 1 TURNS, owner))
		return FALSE
	return TRUE

/datum/discipline_power/vicissitude/horrid_form/activate()
	. = ..()
	// All Physical Attributes increase by three
	owner.st_add_stat_mod(STAT_STRENGTH, 3, HORRID_FORM_SOURCE)
	owner.st_add_stat_mod(STAT_DEXTERITY, 3, HORRID_FORM_SOURCE)
	owner.st_add_stat_mod(STAT_STAMINA, 3, HORRID_FORM_SOURCE)

	// but all Social Attributes drop to zero
	owner.st_add_stat_mod(STAT_CHARISMA, -owner.st_get_stat(STAT_CHARISMA), HORRID_FORM_SOURCE)
	owner.st_add_stat_mod(STAT_MANIPULATION, -owner.st_get_stat(STAT_MANIPULATION), HORRID_FORM_SOURCE)
	owner.st_add_stat_mod(STAT_APPEARANCE, -owner.st_get_stat(STAT_APPEARANCE), HORRID_FORM_SOURCE)

	for(var/obj/item/bodypart/limb in owner.bodyparts)
		limb.unarmed_damage_low += 5
		limb.unarmed_damage_high += 5
		LAZYADD(strengthened_limbs, limb)

	RegisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_DEATHCOMA), PROC_REF(deactivate))

/datum/discipline_power/vicissitude/horrid_form/pre_deactivation_checks()
	. = ..()
	owner.Stun(1 TURNS)
	owner.do_jitter_animation(1 TURNS)
	if(!do_after(owner, 1 TURNS, owner))
		return FALSE
	return TRUE

/datum/discipline_power/vicissitude/horrid_form/deactivate()
	. = ..()
	owner.Stun(2 SECONDS)
	owner.do_jitter_animation(5 SECONDS)

	owner.st_remove_stat_mod(STAT_STRENGTH, HORRID_FORM_SOURCE)
	owner.st_remove_stat_mod(STAT_DEXTERITY, HORRID_FORM_SOURCE)
	owner.st_remove_stat_mod(STAT_STAMINA, HORRID_FORM_SOURCE)

	owner.st_remove_stat_mod(STAT_CHARISMA, HORRID_FORM_SOURCE)
	owner.st_remove_stat_mod(STAT_MANIPULATION, HORRID_FORM_SOURCE)
	owner.st_remove_stat_mod(STAT_APPEARANCE, HORRID_FORM_SOURCE)

	for(var/obj/item/bodypart/limb in strengthened_limbs)
		limb.unarmed_damage_low -= 5
		limb.unarmed_damage_high -= 5
	strengthened_limbs = null

	UnregisterSignal(owner, SIGNAL_REMOVETRAIT(TRAIT_DEATHCOMA))

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/discipline_power/vicissitude/bloodform
	name = "Bloodform"
	desc = "Liquify into a shifting mass of sentient Vitae."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = NONE
	violates_masquerade = TRUE
	cooldown_length = 1 TURNS
	activate_sound = 'modular_darkpack/modules/powers/sounds/vicissitude.ogg'

/datum/discipline_power/vicissitude/bloodform/activate()
	. = ..()


/datum/discipline_power/vicissitude/bloodform/deactivate()
	. = ..()
