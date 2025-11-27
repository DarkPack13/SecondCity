/datum/discipline/dominate
	name = "Dominate"
	desc = "Supresses will of your targets and forces them to obey you, if their will is not more powerful than yours."
	icon_state = "dominate"
	power_type = /datum/discipline_power/dominate

/datum/discipline/dominate/post_gain()
	. = ..()
	if(level >= 1)
		var/obj/effect/proc_holder/spell/voice_of_god/voice_of_domination = new(owner)
		owner.mind.AddSpell(voice_of_domination)

/datum/discipline_power/dominate
	name = "Dominate power name"
	desc = "Dominate power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/dominate.ogg'

/datum/discipline_power/dominate/activate(mob/living/target)
	. = ..()
	var/mob/living/carbon/human/TRGT
	if(ishuman(target))
		TRGT = target
		TRGT.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/dominate_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dominate", -MUTATIONS_LAYER)
		dominate_overlay.pixel_z = 2
		TRGT.overlays_standing[MUTATIONS_LAYER] = dominate_overlay
		TRGT.apply_overlay(MUTATIONS_LAYER)
		spawn(2 SECONDS)
			if(TRGT)
				TRGT.remove_overlay(MUTATIONS_LAYER)
	return TRUE

/datum/movespeed_modifier/dominate
	multiplicative_slowdown = 5

//COMMAND
/datum/discipline_power/dominate/command
	name = "Command"
	desc = "Speak one word and force others to obey."

	level = 1

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 3 SECONDS
	range = 7

/datum/discipline_power/dominate/command/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)

	if (HAS_TRAIT(target, TRAIT_CANNOT_RESIST_MIND_CONTROL))
		return TRUE

	if((theirpower >= mypower) || (owner.generation > target.generation))
		to_chat(owner, span_warning("[target]'s mind is too powerful to dominate!"))
		return FALSE

	return TRUE

/datum/discipline_power/dominate/command/activate(mob/living/target)
	. = ..()
	to_chat(target, span_userdanger("<b>FORGET ABOUT IT</b>"))
	owner.say("FORGET ABOUT IT!!")
	ADD_TRAIT(target, TRAIT_BLIND, "dominate")

/datum/discipline_power/dominate/command/deactivate(mob/living/target)
	. = ..()
	REMOVE_TRAIT(target, TRAIT_BLIND, "dominate")

//MESMERIZE
/datum/discipline_power/dominate/mesmerize
	name = "Mesmerize"
	desc = "Plant a suggestion in a target's head and force them to obey it."

	level = 2

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	range = 7

/datum/discipline_power/dominate/mesmerize/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)

	if (HAS_TRAIT(target, TRAIT_CANNOT_RESIST_MIND_CONTROL))
		return TRUE

	if((theirpower >= mypower) || (owner.generation > target.generation))
		to_chat(owner, span_warning("[target]'s mind is too powerful to dominate!"))
		return FALSE

	return TRUE

/datum/discipline_power/dominate/mesmerize/activate(mob/living/target)
	. = ..()
	target.Immobilize(0.5 SECONDS)
	if(target.body_position == STANDING_UP)
		to_chat(target, span_userdanger("<b>GET DOWN</b>"))
		target.toggle_resting()
		owner.say("GET DOWN!!")
	else
		to_chat(target, span_userdanger("<b>STAY DOWN</b>"))
		owner.say("STAY DOWN!!")

//THE FORGETFUL MIND
/datum/discipline_power/dominate/the_forgetful_mind
	name = "The Forgetful Mind"
	desc = "Invade a person's mind and recreate their memories."

	level = 3

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 3 SECONDS
	range = 7

/datum/discipline_power/dominate/the_forgetful_mind/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)

	if (HAS_TRAIT(target, TRAIT_CANNOT_RESIST_MIND_CONTROL))
		return TRUE

	if((theirpower >= mypower) || (owner.generation > target.generation))
		to_chat(owner, span_warning("[target]'s mind is too powerful to dominate!"))
		return FALSE

	return TRUE

/datum/discipline_power/dominate/the_forgetful_mind/activate(mob/living/target)
	. = ..()
	to_chat(target, span_userdanger("<b>THINK TWICE</b>"))
	owner.say("THINK TWICE!!")
	target.add_movespeed_modifier(/datum/movespeed_modifier/dominate)

/datum/discipline_power/dominate/the_forgetful_mind/deactivate(mob/living/target)
	. = ..()
	target.remove_movespeed_modifier(/datum/movespeed_modifier/dominate)

//CONDITIONING
/datum/discipline_power/dominate/conditioning
	name = "Conditioning"
	desc = "Break a person's mind over time and bend them to your will."

	level = 4

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_LIVING

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	duration_length = 6 SECONDS
	range = 7

/datum/discipline_power/dominate/conditioning/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)

	if (HAS_TRAIT(target, TRAIT_CANNOT_RESIST_MIND_CONTROL))
		return TRUE

	if((theirpower >= mypower) || (owner.generation > target.generation))
		to_chat(owner, span_warning("[target]'s mind is too powerful to dominate!"))
		return FALSE

	return TRUE

/datum/discipline_power/dominate/conditioning/activate(mob/living/target)
	. = ..()
	to_chat(target, span_userdanger("<b>THINK TWICE</b>"))
	owner.say("THINK TWICE!!")
	target.add_movespeed_modifier(/datum/movespeed_modifier/dominate)

/datum/discipline_power/dominate/conditioning/deactivate(mob/living/target)
	. = ..()
	target.remove_movespeed_modifier(/datum/movespeed_modifier/dominate)

//POSSESSION
/datum/discipline_power/dominate/possession
	name = "Possession"
	desc = "Take full control of your target's mind and body."

	level = 5

	check_flags = DISC_CHECK_CAPABLE|DISC_CHECK_SPEAK|DISC_CHECK_SEE
	target_type = TARGET_HUMAN

	multi_activate = TRUE
	cooldown_length = 15 SECONDS
	range = 7

/datum/discipline_power/dominate/possession/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)

	if (HAS_TRAIT(target, TRAIT_CANNOT_RESIST_MIND_CONTROL))
		return TRUE

	if((theirpower >= mypower) || (owner.generation > target.generation))
		to_chat(owner, span_warning("[target]'s mind is too powerful to dominate!"))
		return FALSE

	return TRUE

/datum/discipline_power/dominate/possession/activate(mob/living/carbon/human/target)
	. = ..()
	to_chat(target, span_userdanger("<b>YOU SHOULD HARM YOURSELF NOW</b>"))
	owner.say("YOU SHOULD HARM YOURSELF NOW!!")
	var/datum/cb = CALLBACK(target, /mob/living/carbon/human/proc/attack_myself_command)
	for(var/i in 1 to 20)
		addtimer(cb, (i - 1) * 1.5 SECONDS)

/mob/living/carbon/human/proc/attack_myself_command()
	if(!CheckFrenzyMove())
		a_intent = INTENT_HARM
		var/obj/item/I = get_active_held_item()
		if(I)
			if(I.force)
				ClickOn(src)
			else
				drop_all_held_items()
				ClickOn(src)
		else
			ClickOn(src)
