/mob/living/basic/shadow_guard
	name = "shadow abomination"
	desc = "A shadow given life, creature of fathomless..."
	icon = 'modular_darkpack/modules/npc/icons/shadow_guard.dmi'
	icon_state = "shadow2"
	icon_living = "shadow2"

	basic_mob_flags = DEL_ON_DEATH

	speed = 0
	maxHealth = 200
	health = 200

	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "gouges"
	attack_verb_simple = "gouge"
	attack_sound = 'sound/mobs/non-humanoids/venus_trap/venus_trap_hit.ogg'

	faction = list("Lasombra")
	bloodpool = 1
	maxbloodpool = 1

	ai_controller = /datum/ai_controller/basic_controller/shadow_guard

/mob/living/basic/shadow_guard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)

///nothing unique, just retaliation.
/datum/ai_controller/basic_controller/shadow_guard
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
