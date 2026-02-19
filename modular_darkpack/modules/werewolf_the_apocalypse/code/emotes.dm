/datum/emote/living/growl
	key = "growl"
	key_third_person = "growls"
	message = "growls!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/growl/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	return user.dna.species.get_growl_sound(user)

/// Returns the species' growl sound
/datum/species/proc/get_growl_sound(mob/living/carbon/human/human)
	if(human.physique == FEMALE)
		return 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/emotes/female_growl.ogg'
	return 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/emotes/male_growl.ogg'

/datum/species/human/shifter/war/get_growl_sound(mob/living/carbon/human/human)
	return 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/emotes/crinos_growl.ogg'
/datum/species/human/shifter/dire/get_growl_sound(mob/living/carbon/human/human)
	return 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/emotes/crinos_growl.ogg'
/datum/species/human/shifter/feral/get_growl_sound(mob/living/carbon/human/human)
	return 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/emotes/lupus_growl.ogg'

/* // DARKPACK TODO - CORAX
/datum/emote/living/caw
	key = "caw"
	key_third_person = "caws"
message = "caws!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/caw/get_sound(mob/living/carbon/human/user)
	if(!istype(user))
		return
	return user.dna.species.get_caw_sound(user)
*/

/datum/emote/living/howl
	key = "howl"
	key_third_person = "howls"
	message = "howls!"
	message_param = "howls for %t!"
	emote_type = EMOTE_AUDIBLE | EMOTE_VISIBLE

/datum/emote/living/howl/get_sound(mob/living/user)
	var/static/list/howl_sounds = list(
		'modular_darkpack/modules/werewolf_the_apocalypse/sounds/emotes/awo1.ogg',
		'modular_darkpack/modules/werewolf_the_apocalypse/sounds/emotes/awo2.ogg',
	)
	if(isdog(user) || istype(user, /mob/living/basic/mining/wolf))
		return pick(howl_sounds)

	if(isgarou(user))
		return pick(howl_sounds)

	if(user.is_clan(/datum/vampire_clan/gangrel))
		return pick(howl_sounds)

/datum/emote/living/howl/get_range(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_LOUD_HOWLER))
		return 60

	if(isdog(user) || istype(user, /mob/living/basic/mining/wolf))
		return 7

	if(isgarou(user))
		return 15

	if(user.is_clan(/datum/vampire_clan/gangrel))
		return 7
