GLOBAL_LIST_INIT(zulo_forms, list(
	"Fiend" = "fiend",
	"Leviathan" = "leviathan",
	"Shrikebush" = "shrikebush",
	"Impaler Steed" = "impalersteed",
	"Black Fiend" = "black_fiend",
	"Doctor" = "doctor",
	"Dog" = "dog",
	"Emily" = "emily",
	"Dragon" = "dragon",
	"Tendril Dragon" = "tendrildragon",
))

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

/mob/living/basic/zulo/Initialize(mapload)
	. = ..()
	var/preffered_form = client?.prefs.read_preference(/datum/preference/choiced/subsplat/zulo_form)
	icon_state = preffered_form ? preffered_form : "fiend"
