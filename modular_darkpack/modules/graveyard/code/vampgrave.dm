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
	GLOB.generic_event_spawns += src
	randomize_appearance()
	spawn_interval += rand(-10 SECONDS, 10 SECONDS) // Prevent them from all spawning at the same time.
	addtimer(CALLBACK(src, PROC_REF(try_spawn_zombie)), spawn_interval, TIMER_STOPPABLE | TIMER_LOOP)

//they have the indestructible flag so this should never happen but just in case
/obj/vampgrave/Destroy()
	GLOB.generic_event_spawns -= src
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

