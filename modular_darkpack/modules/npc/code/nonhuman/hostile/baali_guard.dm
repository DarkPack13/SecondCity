/mob/living/basic/baali_guard
	name = "Infernal Creature"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "baali"
	icon_living = "baali"

	speed = 0
	max_stamina = 1500
	maxHealth = 1500
	health = 1500

	guaranteed_butcher_results = list(/obj/item/stack/human_flesh = 20)

	combat_mode = TRUE
	melee_damage_type = AGGRAVATED
	melee_damage_lower = 20
	melee_damage_upper = 20

	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'

	bloodpool = 10
	maxbloodpool = 10

	faction = list("Baali")

/mob/living/basic/baali_guard/Initialize(mapload)
	. = ..()
	AddComponent(\
		/datum/component/ghost_direct_control,\
		poll_candidates = TRUE,\
		role_name = "a Baali Demon",\
		poll_ignore_key = POLL_IGNORE_BAALI_GUARD,\
		assumed_control_message = "You are a demon from hell! Wreak havoc to all!",\
		after_assumed_control = CALLBACK(src, PROC_REF(became_player_controlled)),\
	)

/// Triggers an alert to all ghosts that the rat has become player controlled.
/mob/living/basic/baali_guard/proc/became_player_controlled()
	notify_ghosts(
		"All rise for [name], given domain to this realm in \the [get_area(src)].",
		source = src,
		header = "Baali Demon Created",
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
	)
