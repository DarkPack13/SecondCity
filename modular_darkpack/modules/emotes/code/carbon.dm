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
