/datum/action/cooldown/spell/shapeshift/gangrel/beast_form
	name = "Gangrel Form"
	desc = "Take on the shape of an animal."

	possible_shapes = list(
		/mob/living/basic/bat/protean,
		/mob/living/basic/pet/dog/darkpack/protean, // DARKPACK TODO - WOLF
	)

/mob/living/basic/bat/protean
	maxHealth = 300
	health = 300
	mob_size = MOB_SIZE_SMALL

/mob/living/basic/pet/dog/darkpack/protean
	maxHealth = 300
	health = 300
	melee_damage_lower = 20
	melee_damage_upper = 20

/mob/living/basic/bear/vampire/protean
	maxHealth = 300
	health = 300
	melee_damage_lower = 20
	melee_damage_upper = 20

/datum/action/cooldown/spell/shapeshift/gangrel/beast_form/Grant(mob/grant_to)
	. = ..()
	if(ishuman(grant_to))
		var/mob/living/carbon/human/grant_to_human = grant_to
		if(grant_to_human.is_clan(/datum/vampire_clan/gangrel))
			possible_shapes += list(
				/mob/living/basic/bear/vampire/protean
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
