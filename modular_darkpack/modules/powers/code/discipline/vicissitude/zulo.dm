GLOBAL_LIST_INIT(zulo_forms, list(
	"Fiend" = /datum/zulo_form,
	"Leviathan" = /datum/zulo_form/leviathan,
	"Shrikebush" = /datum/zulo_form/shrikebush,
	"Impaler Steed" = /datum/zulo_form/impalersteed,
	"Black Fiend" = /datum/zulo_form/black_fiend,
	"Doctor" = /datum/zulo_form/doctor,
	"Dog" = /datum/zulo_form/dog,
	"Emily" = /datum/zulo_form/emily,
	"Dragon" = /datum/zulo_form/dragon,
	"Tendril Dragon" = /datum/zulo_form/tendrildragon,
))

/datum/zulo_form
	var/name = "Fiend"
	var/icon_state = "fiend"

/datum/zulo_form/leviathan
	name = "Leviathan"
	icon_state = "leviathan"

/datum/zulo_form/shrikebush
	name = "Shrikebush"
	icon_state = "shrikebush"

/datum/zulo_form/impalersteed
	name = "Impaler Steed"
	icon_state = "impalersteed"

/datum/zulo_form/black_fiend
	name = "Black Fiend"
	icon_state = "black_fiend"

/datum/zulo_form/doctor
	name = "Doctor"
	icon_state = "doctor"

/datum/zulo_form/dog
	name = "Dog"
	icon_state = "dog"

/datum/zulo_form/emily
	name = "Emily"
	icon_state = "emily"

/datum/zulo_form/dragon
	name = "Dragon"
	icon_state = "dragon"

/datum/zulo_form/tendrildragon
	name = "Tendril Dragon"
	icon_state = "tendrildragon"

/datum/action/cooldown/spell/shapeshift/zulo
	name = "Zulo Form"
	desc = "Take on the shape a beast."
	cooldown_time = 1 TURNS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	spell_requirements = NONE
	convert_damage = FALSE
	possible_shapes = list(/mob/living/basic/zulo)
	click_to_activate = FALSE
	owner_has_control = FALSE

/mob/living/basic/zulo
	name = "unknown creature"
	desc = "What the hell is that thing!?"
	icon = 'modular_darkpack/modules/powers/icons/zulo_forms.dmi'
	icon_state = "fiend" // Default icon_state, changed by character preference
	pixel_w = -16
	mob_biotypes = MOB_ORGANIC
	mob_size = MOB_SIZE_HUGE

	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE

	maxHealth = 600
	health = 600
	speed = 2
	obj_damage = 20
	armour_penetration = 5
	wound_bonus = 0
	sharpness = SHARP_POINTY
	attacked_sound = SFX_DESECRATION

	bloodpool = 2
	maxbloodpool = 2
