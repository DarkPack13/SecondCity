/mob/living/basic/zombie/darkpack
	name = "Shambling Corpse"
	desc = "When there is no more room in Hell, the dead will walk on Earth."
	icon = 'modular_darkpack/modules/graveyard/icons/zombies.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	icon_dead = "zombie_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	maxHealth = 50
	health = 50
	melee_damage_lower = 21
	melee_damage_upper = 21
	obj_damage = 2
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'modular_darkpack/modules/deprecated/sounds/zombuzi.ogg'
	status_flags = CANPUSH
	basic_mob_flags = DEL_ON_DEATH
	speed = 1
	faction = list("zombie")
	ai_controller = /datum/ai_controller/basic_controller/zombie/darkpack
	outfit = null

	var/obj/vampgrave/source_grave

/mob/living/basic/zombie/darkpack/Initialize(mapload)
	. = ..()
	// the parent is causing them to appear as space station 13 zombies - this removes that.
	icon = 'modular_darkpack/modules/graveyard/icons/zombies.dmi'
	icon_state = icon_living
	cut_overlays()
	update_body()
	AddElement(/datum/element/ai_retaliate)

/mob/living/basic/zombie/darkpack/Destroy()
	if(source_grave)
		source_grave.spawned_zombies -= src
	source_grave = null
	return ..()

// need a custom targeting strategy so they don't kill other zombies
/datum/targeting_strategy/basic/zombie_darkpack

/datum/targeting_strategy/basic/zombie_darkpack/can_attack(mob/living/basic/basic_mob, atom/target, vision_range)
	if(istype(target, /mob/living/basic/zombie/darkpack))
		return FALSE

	// don't break down the fence - just try to break the gate
	if(istype(target, /obj/structure/vampfence/rich))
		return FALSE

	if(istype(target, /obj/structure/vampgate))
		return TRUE

	// use the parent class for everything else
	return ..()

// planning subtree specifically for finding and targeting vampire gates
/datum/ai_planning_subtree/find_and_attack_vampgate
	var/scan_range = 9

/datum/ai_planning_subtree/find_and_attack_vampgate/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/mob/living/basic/zombie = controller.pawn

	var/atom/current_target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]

	// if we're attacking a gate, use the targeting strategy to find nearby living mobs.
	if(istype(current_target, /obj/structure/vampgate))
		var/datum/targeting_strategy/targeter = GET_TARGETING_STRATEGY(controller.blackboard[BB_TARGETING_STRATEGY])
		if(targeter)
			for(var/mob/living/potential_target in oview(controller.blackboard[BB_VISION_RANGE], zombie))
				if(targeter.can_attack(zombie, potential_target, controller.blackboard[BB_VISION_RANGE]))
					// if we can attack the potential target clear the gate from the list and attack the nearby living thing.
					controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET)
					return

	// if we already have a living current target don't run this
	if(isliving(current_target))
		return

	// if we currently have a mob target from the blackboard then don't run this
	if(controller.blackboard_key_exists(BB_BASIC_MOB_CURRENT_TARGET))
		return

	// is there a nearby vampgate?
	for(var/obj/structure/vampgate/gate in oview(scan_range, zombie))
		if(!gate.broken)
			// theres one, kill it
			controller.set_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET, gate)
			controller.clear_blackboard_key(BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)
		return

// AI controller for darkpack zombies
/datum/ai_controller/basic_controller/zombie/darkpack
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic/zombie_darkpack,
		BB_TARGET_MINIMUM_STAT = DEAD,
		BB_VISION_RANGE = 9,
	)
	ai_movement = /datum/ai_movement/basic_avoidance
	idle_behavior = /datum/idle_behavior/idle_random_walk
	planning_subtrees = list(
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/find_and_attack_vampgate,
		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

/obj/vampgrave
	icon = 'modular_darkpack/modules/graveyard/icons/graves.dmi'
	icon_state = "grave1"
	name = "grave"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

	var/spawn_interval = 15 MINUTES
	var/max_zombies_per_grave = 2
	var/list/spawned_zombies = list()

/obj/vampgrave/Initialize(mapload)
	. = ..()
	randomize_appearance()
	spawn_interval += rand(-10 SECONDS, 10 SECONDS) // Prevent them from all spawning at the same time.
	addtimer(CALLBACK(src, PROC_REF(try_spawn_zombie)), spawn_interval, TIMER_STOPPABLE | TIMER_LOOP)

//they have the indestructible flag so this should never happen but just in case
/obj/vampgrave/Destroy()
	spawned_zombies.Cut()
	return ..()

/obj/vampgrave/proc/try_spawn_zombie()

	clean_zombie_list()
	if(!should_spawn())
		return
	if(length(spawned_zombies) >= max_zombies_per_grave)
		return

	spawn_zombie()

/obj/vampgrave/proc/should_spawn()
	// Check if graveyard keeper is online
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!H.mind)
			continue
		if(istype(H.mind.assigned_role, /datum/job/vampire/graveyard) && !considered_afk(H.mind))
			return TRUE
	return FALSE

/obj/vampgrave/proc/clean_zombie_list()
	for(var/mob/living/basic/zombie/darkpack/Z in spawned_zombies)
		if(QDELETED(Z))
			spawned_zombies -= Z

/obj/vampgrave/proc/spawn_zombie()
	var/mob/living/basic/zombie/darkpack/Z = new(loc)
	Z.source_grave = src
	spawned_zombies += Z

	visible_message(span_danger("The ground at [src] stirs as something claws its way out!"))

/obj/vampgrave/proc/randomize_appearance()
	icon_state = "grave[rand(1, 10)]"
	if(check_holidays(CHRISTMAS) && is_outdoors())
		icon_state += "-snow"

/obj/vampgrave/proc/is_outdoors()
	var/area/my_area = get_area(src)
	return my_area.outdoors

// Adminbus or testing
/obj/vampgrave/rapid
	name = "upturned grave"
	spawn_interval = 30 SECONDS
	max_zombies_per_grave = 1

/obj/structure/vampgate
	name = "graveyard gate"
	desc = "It opens and closes."
	icon = 'modular_darkpack/modules/graveyard/icons/gate.dmi'
	icon_state = "gate"
	pixel_x = -32
	base_pixel_x = -32
	anchored = TRUE
	density = TRUE
	max_integrity = 500
	prevent_destruction = TRUE

	var/repairing = FALSE

/obj/structure/vampgate/Initialize(mapload)
	. = ..()
	var/turf/right_turf = get_step(src, EAST)
	var/turf/left_turf = get_step(src, WEST)
	if(right_turf)
		right_turf.set_density(TRUE)
	if(left_turf)
		left_turf.set_density(TRUE)

/obj/structure/vampgate/take_damage(damage_amount, damage_type = BRUTE, damage_flag = "", sound_effect = TRUE, attack_dir, armour_penetration = 0)
	. = ..()
	if(!broken)
		if(sound_effect)
			playsound(get_turf(src), 'modular_darkpack/master_files/sounds/effects/door/get_bent.ogg', 100, FALSE)

		shake_gate()

		if(atom_integrity <= 0)
			break_open()

/obj/structure/vampgate/atom_destruction(damage_flag)
	. = ..()
	break_open()

/obj/structure/vampgate/proc/shake_gate()
	pixel_z += rand(-1, 1)
	pixel_w += rand(-1, 1)
	addtimer(CALLBACK(src, PROC_REF(reset_position)), 0.2 SECONDS)

/obj/structure/vampgate/proc/reset_position()
	pixel_z = initial(pixel_z)
	pixel_w = initial(pixel_w)

/obj/structure/vampgate/proc/break_open()
	if(broken)
		return

	broken = TRUE
	density = FALSE
	icon_state = "gate-open"
	visible_message(span_boldwarning("[src] breaks open!"))

/obj/structure/vampgate/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(istype(tool, /obj/item/melee/vamp/tire))
		attempt_repair(user)
		return ITEM_INTERACT_SUCCESS

	return NONE

/obj/structure/vampgate/proc/attempt_repair(mob/living/user)
	if(repairing)
		to_chat(user, span_warning("Someone is already repairing [src]!"))
		return

	if(atom_integrity >= max_integrity)
		to_chat(user, span_notice("[src] is already fully repaired."))
		return

	repairing = TRUE

	if(do_after(user, 5 SECONDS, src))
		repair_damage(50)

		if(atom_integrity > 0 && broken)
			broken = FALSE
			density = TRUE
			icon_state = "gate"
			visible_message(span_notice("[src] is repaired and closed!"))

		playsound(src, 'modular_darkpack/master_files/sounds/effects/repair.ogg', 50, TRUE)
		to_chat(user, span_notice("You repair some damage on [src]. ([atom_integrity]/[max_integrity])"))
	else
		to_chat(user, span_warning("You stop repairing [src]."))

	repairing = FALSE
