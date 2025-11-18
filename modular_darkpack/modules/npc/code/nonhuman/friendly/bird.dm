/mob/living/basic/corvid
	name = "corvid"
	desc = "Caw."
	abstract_type = /mob/living/basic/corvid
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	icon_state = "black"
	icon_living = "black"
	icon_dead = "black"
	icon = 'modular_darkpack/modules/npc/icons/corvid.dmi'
	density = FALSE
	butcher_results = list(/obj/item/food/meat/slab/chicken = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "pecks"
	response_harm_simple = "peck"
	attack_verb_continuous = "pecks"
	attack_verb_simple = "peck"
	friendly_verb_continuous = "headbutts"
	friendly_verb_simple = "headbutt"
	speak_emote = list("caws")
	health = 20
	maxHealth = 20
	pass_flags = PASSTABLE | PASSMOB
	mob_size = MOB_SIZE_SMALL
	gold_core_spawnable = FRIENDLY_SPAWN

	ai_controller = /datum/ai_controller/basic_controller/corvid

/mob/living/basic/corvid/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
	AddElement(/datum/element/pet_bonus, "caw")
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_CLAW)

/datum/emote/corvid
	mob_type_allowed_typecache = /mob/living/basic/corvid
	mob_type_blacklist_typecache = list()

/datum/emote/corvid/caw
	key = "caw"
	key_third_person = "caws"
	message = "caws!"
	emote_type = EMOTE_VISIBLE | EMOTE_AUDIBLE
	vary = TRUE
	sound = 'modular_darkpack/modules/npc/sound/caw.ogg'

/mob/living/basic/corvid/crow
	name = "crow"
	desc = "Unlike a raven, it has a fan shaped tail."

/mob/living/basic/corvid/raven
	name = "raven"
	desc = "Unlike a crow, it has a wedge shaped tail."
	speak_emote = list("gronks")

/mob/living/basic/corvid/raven/Initialize(mapload)
	. = ..()
	update_transform(1.1)



