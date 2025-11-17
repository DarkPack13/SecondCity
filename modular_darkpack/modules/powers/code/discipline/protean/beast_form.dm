/datum/action/cooldown/spell/shapeshift/gangrel/beast_form
	name = "Gangrel Form"
	desc = "Take on the shape of a wolf."

	possible_shapes = list(
		/mob/living/basic/gangrel,
		/mob/living/basic/bear/vampire,
		/mob/living/basic/pet/dog/darkpack,
	)

/mob/living/basic/gangrel
	name = "horrid form"
	desc = "The pinnacle of bestial terror. Unbelievably tough."
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "gangrel_f"
	icon_living = "gangrel_f"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_HUGE
	speed = -0.4
	maxHealth = 275
	health = 275
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	bloodpool = 10
	maxbloodpool = 10
	held_items = list(null, null)

/mob/living/basic/gangrel/better
	maxHealth = 325
	health = 325
	melee_damage_lower = 35
	melee_damage_upper = 35
	speed = -0.6

/mob/living/basic/gangrel/best
	icon_state = "gangrel_m"
	icon_living = "gangrel_m"
	maxHealth = 400
	health = 400
	melee_damage_lower = 40
	melee_damage_upper = 40
	speed = -0.8
