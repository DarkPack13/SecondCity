/mob/living/basic/blood_guard
	name = "blood guardian"
	desc = "A clot of blood in humanoid form."
	icon = 'modular_darkpack/modules/npc/icons/blood_guard.dmi'
	icon_state = "blood_guardian"
	icon_living = "blood_guardian"

	basic_mob_flags = DEL_ON_DEATH

	speed = 0
	maxHealth = 150
	health = 150

	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20

	bloodpool = 1
	maxbloodpool = 1

	faction = list("Tremere")
	ai_controller = /datum/ai_controller/basic_controller/blood_guard

/mob/living/basic/blood_guard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)

///nothing unique, just retaliation.
/datum/ai_controller/basic_controller/blood_guard
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
	)

	ai_traits = PASSIVE_AI_FLAGS
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk/less_walking

	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)
