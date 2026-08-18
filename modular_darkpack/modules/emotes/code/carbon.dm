/datum/emote/living/carbon/clap
	key = "clap"
	key_third_person = "claps"
	message = "claps."
	hands_use_check = TRUE
	emote_type = EMOTE_AUDIBLE
	vary = TRUE
	affected_by_pitch = FALSE

/datum/emote/living/carbon/clap/get_sound(mob/living/user)
	return pick('sound/mobs/humanoids/human/clap/clap1.ogg',
				'sound/mobs/humanoids/human/clap/clap2.ogg',
				'sound/mobs/humanoids/human/clap/clap3.ogg',
				'sound/mobs/humanoids/human/clap/clap4.ogg')

/datum/emote/living/carbon/clap/can_run_emote(mob/living/carbon/user, status_check = TRUE, intentional, params)
	if(user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/carbon/clap1
	key = "clap1"
	key_third_person = "claps once"
	message = "claps once."
	emote_type = EMOTE_AUDIBLE
	hands_use_check = TRUE
	vary = TRUE
	affected_by_pitch = FALSE

/datum/emote/living/carbon/clap1/get_sound(mob/living/user)
	return pick('modular_darkpack/modules/emotes/sound/claponce1.ogg',
				'modular_darkpack/modules/emotes/sound/claponce2.ogg')

/datum/emote/living/carbon/clap1/can_run_emote(mob/living/carbon/user, status_check = TRUE , intentional, params)
	if(user.usable_hands < 2)
		return FALSE
	return ..()

/datum/emote/living/carbon/sweatdrop
	key = "sweatdrop"
	key_third_person = "sweatdrops"
	message = "sweats."
	emote_type = EMOTE_VISIBLE
	vary = TRUE

/datum/emote/living/carbon/sweatdrop/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/image/emote_animation = image('modular_darkpack/modules/emotes/icons/emote_visuals.dmi', user, "sweatdrop", ABOVE_MOB_LAYER, 0, 10, 10)
	flick_overlay_global(emote_animation, GLOB.clients, 3.0 SECONDS)

/datum/emote/living/carbon/sweatdrop/get_sound(mob/living/user)
	return 'modular_darkpack/modules/emotes/sound/sweatdrop.ogg'

/datum/emote/living/carbon/sweatdrop/sweat //This is entirely the same as sweatdrop, however people might use either, so i'm adding this one instead of editing the other one.
	key = "sweat"

/datum/emote/living/carbon/annoyed
	key = "annoyed"
	emote_type = EMOTE_VISIBLE
	vary = TRUE

/datum/emote/living/carbon/annoyed/get_sound(mob/living/user)
	return 'modular_darkpack/modules/emotes/sound/annoyed.ogg'

/datum/emote/living/carbon/annoyed/run_emote(mob/user, params, type_override, intentional)
	. = ..()
	var/image/emote_animation = image('modular_darkpack/modules/emotes/icons/emote_visuals.dmi', user, "annoyed", ABOVE_MOB_LAYER, 0, 10, 10)
	flick_overlay_global(emote_animation, GLOB.clients, 5.0 SECONDS)
