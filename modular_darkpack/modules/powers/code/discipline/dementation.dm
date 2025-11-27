/datum/discipline/dementation
	name = "Dementation"
	desc = "Makes all humans in radius mentally ill for a moment, supressing their defending ability."
	icon_state = "dementation"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/dementation

/datum/discipline/dementation/post_gain()
	. = ..()
	owner.add_quirk(/datum/quirk/insanity)

/datum/discipline_power/dementation
	name = "Dementation power name"
	desc = "Dementation power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/insanity.ogg'

//PASSION
/datum/discipline_power/dementation/passion
	name = "Passion"
	desc = "Stir the deepest parts of your target to manipulate their psyche."

	level = 1

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 3 SECONDS

/datum/discipline_power/dementation/passion/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to corrupt!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/passion/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	//what the fuck
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	target.Stun(0.5 SECONDS)
	target.emote("laugh")
	to_chat(target, span_userdanger("<b>HAHAHAHAHAHAHAHAHAHAHAHA!!</b>"))
	owner.playsound_local(get_turf(H), pick('sound/items/SitcomLaugh1.ogg', 'sound/items/SitcomLaugh2.ogg', 'sound/items/SitcomLaugh3.ogg'), 100, FALSE)
	if(target.body_position == STANDING_UP)
		target.toggle_resting()

/datum/discipline_power/dementation/passion/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

//THE HAUNTING
/datum/discipline_power/dementation/the_haunting
	name = "The Haunting"
	desc = "Manipulate your target's senses, making them perceive what isn't there."

	level = 2

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 3 SECONDS

/datum/discipline_power/dementation/the_haunting/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to corrupt!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/the_haunting/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	//what the fuck
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	target.hallucination += 50
	new /datum/hallucination/oh_yeah(target, TRUE)

/datum/discipline_power/dementation/the_haunting/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

//EYES OF CHAOS
/datum/discipline_power/dementation/eyes_of_chaos
	name = "Eyes of Chaos"
	desc = "See the hidden patterns in the world and uncover people's true selves."

	level = 3

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 3 SECONDS

/datum/discipline_power/dementation/eyes_of_chaos/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to corrupt!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/eyes_of_chaos/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	//what the fuck
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	target.Immobilize(2 SECONDS)
	if(!HAS_TRAIT(target, TRAIT_KNOCKEDOUT) && !HAS_TRAIT(target, TRAIT_IMMOBILIZED) && !HAS_TRAIT(target, TRAIT_RESTRAINED))
		if(prob(50))
			dancefirst(target)
		else
			dancesecond(target)

/datum/discipline_power/dementation/eyes_of_chaos/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

//VOICE OF MADNESS
/datum/discipline_power/dementation/voice_of_madness
	name = "Voice of Madness"
	desc = "Your voice becomes a source of utter insanity, affecting you and all those around you."

	level = 4

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 3 SECONDS

/datum/discipline_power/dementation/voice_of_madness/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to corrupt!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/voice_of_madness/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	//what the fuck
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	//change this to something better than an 8 second instastun
	new /datum/hallucination/death(target, TRUE)

/datum/discipline_power/dementation/voice_of_madness/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)

//TOTAL INSANITY
/datum/discipline_power/dementation/total_insanity
	name = "Total Insanity"
	desc = "Bring out the darkest parts of a person's psyche, bringing them to utter insanity."

	level = 5

	check_flags = DISC_CHECK_CAPABLE | DISC_CHECK_SPEAK
	target_type = TARGET_HUMAN
	range = 7

	multi_activate = TRUE
	cooldown_length = 10 SECONDS
	duration_length = 3 SECONDS

/datum/discipline_power/dementation/total_insanity/pre_activation_checks(mob/living/target)
	var/mypower = owner.st_get_stat(STAT_CHARISMA)
	var/theirpower = target.st_get_stat(STAT_PERMANENT_WILLPOWER)
	if(theirpower >= mypower)
		to_chat(owner, span_warning("[target]'s mind is too powerful to corrupt!"))
		return FALSE
	return TRUE

/datum/discipline_power/dementation/total_insanity/activate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
	var/mutable_appearance/dementation_overlay = mutable_appearance('modular_darkpack/modules/deprecated/icons/icons.dmi', "dementation", -MUTATIONS_LAYER)
	dementation_overlay.pixel_z = 1
	//what the fuck
	target.overlays_standing[MUTATIONS_LAYER] = dementation_overlay
	target.apply_overlay(MUTATIONS_LAYER)

	var/datum/cb = CALLBACK(target, /mob/living/carbon/human/proc/attack_myself_command)
	for(var/i in 1 to 20)
		addtimer(cb, (i - 1) * 1.5 SECONDS)

/datum/discipline_power/dementation/total_insanity/deactivate(mob/living/carbon/human/target)
	. = ..()
	target.remove_overlay(MUTATIONS_LAYER)
