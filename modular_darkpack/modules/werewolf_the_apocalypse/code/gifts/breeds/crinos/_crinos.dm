/**
 * The Garou knows the trick of shedding and growing fur at an alarming rate.
 * This Gift makes the Garou especially difficult to grapple successfully; opponents find themselves
 * holding tufts of fur instead of their target. The Garou can also slide through tight spaces
 * using his shedding fur as natural lubrication. A lizard-spirit or snake-spirit teaches this Gift.
 *
 * The Garou may use his slick outer coating to avoid being grappled.
 * With a successful Dexterity + Primal-Urge roll (difficulty 7), he can free himself
 * from any successful grappling attack. The fur also reduces by two the werewolf’s difficulty
 * whenever he squeezes through tight spaces or slips restraints, such as handcuffs.
 *
 * TODO handcuff part
 */
/datum/action/cooldown/power/gift/shed

	name = "Shed"
	desc = "The Garou knows the trick of shedding and growing fur at an alarming rate."
	#warn placeholder asset.
	button_icon_state = "shed" // TODO: get an icon for this
	rank = 1
	cooldown_time = 1 TURNS
	var/datum/storyteller_roll/shed/roll

/datum/action/cooldown/power/gift/shed/New()
	. = ..()
	roll = new()

/datum/action/cooldown/power/gift/shed/Destroy()
	QDEL_NULL(roll)
	return ..()

/datum/action/cooldown/power/gift/shed/Activate(atom/target)
	var/mob/living/carbon/owner = src.owner
	if(!istype(owner))
		return FALSE // eh

	if(!owner.pulledby && !owner.handcuffed && !owner.legcuffed)
		to_chat(owner, span_warning("No one is grappling or restraining you, all this would amount to is theatrics."))
		return FALSE

	switch(roll.st_roll(owner, null, PRIMAL_URGE_PLACEHOLDER))
		if(ROLL_SUCCESS)
			astype(owner, /mob/living).apply_status_effect(/datum/status_effect/shed)
			return TRUE
		if(ROLL_FAILURE)
			pass()
		if(ROLL_COOLDOWN)
			return FALSE // shouldn't happen..?
		if(ROLL_BOTCH)
			pass()

	StartCooldown()
	return TRUE

/datum/status_effect/shed
	id = "shed"
	duration = 1 SCENES // duration higher than gift CD. we just refresh

	status_type = STATUS_EFFECT_REFRESH

	alert_type = /atom/movable/screen/alert/status_effect/shed

/datum/status_effect/shed/on_apply()
	var/mob/living/carbon/owner = src.owner
	if(!istype(owner))
		return FALSE // eh

	if(owner.pulledby)
		to_chat(owner, span_notice("You shed your fur, and [owner.pulledby] loses [owner.pulledby.p_their()] grip on you!"))
		owner.pulledby.stop_pulling()
	else if(owner.handcuffed || owner.legcuffed)
		to_chat(owner, span_notice("You shed your fur, using the slick coating as lubrication to slip out of your restraints."))
		owner.uncuff()

	#warn do when len decides what to do with restraints
	return FALSE // also pull master branch mf

/atom/movable/screen/alert/status_effect/shed
	name = "Shed"
	desc = "The shedding fur reduces the difficulty of slipping restraints by two."
	icon = 'modular_darkpack/modules/deprecated/icons/hud/screen_alert.dmi'
	#warn placeholder asset.
	icon_state = "riddle" // TODO: get an icon for this

/datum/storyteller_roll/shed
	bumper_text = "shedding fur"
	difficulty = 7
	applicable_stats = list(STAT_DEXTERITY)
	reroll_cooldown = 1 TURNS
