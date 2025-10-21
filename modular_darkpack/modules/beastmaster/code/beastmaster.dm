/mob/living/simple_animal/hostile/beastmaster
	name = "dog"
	desc = "Woof-woof."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "dog"
	icon_living = "dog"
	icon_dead = "dog_dead"
	del_on_death = 1
	footstep_type = FOOTSTEP_MOB_SHOE
	mob_biotypes = MOB_ORGANIC
	speak_chance = 0
	turns_per_move = 1
	speed = 0.35
	maxHealth = 80
	health = 85
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 25
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'modular_darkpack/modules/deprecated/sounds/dog.ogg'
	bloodpool = 2
	maxbloodpool = 2
	loot = list()
	AIStatus = AI_OFF

// ============= BEASTMASTER MINION COMPONENT =============
/datum/component/beastmaster_minion
	/// The master who controls this beast
	var/mob/living/carbon/human/master
	/// List of enemies this beast should attack
	var/list/enemies = list()
	/// Whether to follow the master when not in combat
	var/follow = TRUE
	/// Current target
	var/atom/target

/datum/component/beastmaster_minion/Initialize(mob/living/carbon/human/new_master)

	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE

	master = new_master
	GLOB.beast_component_list += src

	RegisterSignal(parent, COMSIG_ATOM_BULLET_ACT, PROC_REF(on_hit))
	RegisterSignal(parent, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/datum/component/beastmaster_minion/Destroy()
	var/mob/living/beast = parent

	if(beast)
		walk(beast, 0)

		if(istype(beast, /mob/living/simple_animal))
			var/mob/living/simple_animal/S = beast
			S.stop_automated_movement = TRUE

		if(beast.pulling)
			beast.stop_pulling()

	if(master && master.beastmaster_minions)
		master.beastmaster_minions -= beast
		if(master.beastmaster_minion_components)
			master.beastmaster_minion_components -= src

		// Unregister signals if no more minions
		if(!length(master.beastmaster_minions))
			master.unregister_beastmaster_signals()

	GLOB.beast_component_list -= src

	master = null
	enemies = null
	target = null

	return ..()

/datum/component/beastmaster_minion/proc/on_death(mob/living/source, gibbed)
	SIGNAL_HANDLER
	qdel(src)

/datum/component/beastmaster_minion/proc/handle_automated_beasting()
	var/mob/living/beast = parent

	if(beast.client)
		return
	if(beast.stat > 0)
		GLOB.beast_component_list -= src
		return

	if(!target)
		if(length(enemies))
			for(var/mob/living/L in enemies)
				if(L.stat < 1 && L.z == beast.z && get_dist(beast, L) < 12)
					target = L
					break
	else
		var/mob/living/living_target = target
		if(!isliving(target) || target.z != beast.z || get_dist(beast, target) > 11 || living_target.stat > 0)
			target = null
			if(length(enemies))
				for(var/mob/living/L in enemies)
					if(L.stat < 1 && L.z == beast.z && get_dist(beast, L) < 12)
						target = L
						break

	var/totalshit = 1
	if(beast.cached_multiplicative_slowdown > 0)
		totalshit = beast.cached_multiplicative_slowdown

	if(target)
		var/reqsteps = round((SSbeastmastering.next_fire - world.time) / totalshit)
		walk_to(beast, target, reqsteps, beast.cached_multiplicative_slowdown)
		if(get_dist(beast, target) <= 1)
			beast.ClickOn(target)
	else
		if(follow && isliving(master) && isturf(master.loc))
			if(master.stat != DEAD && beast.z != master.z && get_dist(master.loc, beast.loc) <= 10)
				beast.forceMove(get_turf(master))
			else if(master.stat != DEAD)
				var/reqsteps = round((SSbeastmastering.next_fire - world.time) / totalshit)
				walk_to(beast, master, reqsteps, beast.cached_multiplicative_slowdown)
		else
			walk(beast, 0)

/datum/component/beastmaster_minion/proc/add_beastmaster_enemies(mob/living/L)
	var/datum/component/beastmaster_minion/L_component = L.GetComponent(/datum/component/beastmaster_minion)
	if(L_component && L_component.master == master)
		return
	if(L == master)
		return
	enemies |= L
	if(!target)
		target = L

/datum/component/beastmaster_minion/proc/on_hit(datum/source, obj/projectile/P)
	SIGNAL_HANDLER

	if(!P?.firer || !master)
		return

	for(var/mob/living/minion in master.beastmaster_minions)
		var/datum/component/beastmaster_minion/minion_component = minion.GetComponent(/datum/component/beastmaster_minion)
		if(minion_component)
			minion_component.add_beastmaster_enemies(P.firer)
