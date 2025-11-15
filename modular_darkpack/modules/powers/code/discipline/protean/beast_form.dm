/datum/action/cooldown/spell/shapeshift/gangrel
	name = "Gangrel Form"
	desc = "Take on the shape of a wolf."
	//charge_max = 50
	cooldown_time = 5 SECONDS
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	shapeshift_type = /mob/living/basic/gangrel

/mob/living/basic/gangrel
	#warn dont dox that this is a gangrel I think.
	name = "gangrel form"
	#warn wtf does this mean
	desc = "The peak of abominations armor. Unbelievably undamagable..."
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
