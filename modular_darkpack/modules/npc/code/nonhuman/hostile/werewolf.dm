/mob/living/basic/crinos_beast
	name = "Wolf-like Beast"
	desc = "The peak of abominations damage. Unbelievably deadly..."
	icon = 'modular_darkpack/modules/npc/icons/werewolf.dmi'
	icon_state = "beast_crinos"
	icon_living = "beast_crinos"

	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_BEAST

	speed = 1
	max_stamina = 575
	maxHealth = 575
	health = 575

	butcher_results = list(/obj/item/stack/human_flesh = 10)

	combat_mode = TRUE
	melee_damage_lower = 35
	melee_damage_upper = 35

	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'

	bloodpool = 10
	maxbloodpool = 10
	ai_controller = /datum/ai_controller/basic_controller/crinos_beast

/mob/living/basic/crinos_beast/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)

///nothing unique, just retaliation.
/datum/ai_controller/basic_controller/crinos_beast
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/escape_captivity,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
