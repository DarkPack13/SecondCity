/datum/emote/living/carbon/human/sigh_exasperated
	key = "esigh" // short for exasperated sigh
	key_third_person = "esighs"
	message = "lets out an exasperated sigh."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/carbon/human/sigh_exasperated/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/image/emote_animation = image('icons/mob/human/emote_visuals.dmi', user, "sigh")
	flick_overlay_global(emote_animation, GLOB.clients, 2.0 SECONDS)

/datum/emote/living/carbon/human/sigh_exasperated/get_sound(mob/living/carbon/human/user)
	if(user.physique == MALE)
		return 'modular_darkpack/modules/emotes/sound/male/male_sigh_exasperated.ogg'
	return 'modular_darkpack/modules/emotes/sound/female/female_sigh_exasperated.ogg'

