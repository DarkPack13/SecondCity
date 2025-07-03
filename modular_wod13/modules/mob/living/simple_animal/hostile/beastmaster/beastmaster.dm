/mob/living/simple_animal/hostile/beastmaster
	name = "dog"
	desc = "Woof-woof."
	icon = 'icons/wod13/mobs.dmi'
	icon_state = "dog"
	icon_living = "dog"
	icon_dead = "dog_dead"
	del_on_death = 1
	footstep_type = FOOTSTEP_MOB_SHOE
	mob_biotypes = MOB_ORGANIC
	speak_chance = 0
	turns_per_move = 1
	speed = 0.35
//	move_to_delay = 3
//	rapid = 3
//	ranged = 1
	maxHealth = 80
	health = 85
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 25
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/wod13/dog.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 2
	maxbloodpool = 2
//	retreat_distance = 3
//	minimum_distance = 5
//	casingtype = /obj/item/ammo_casing/vampire/c556mm
//	projectilesound = 'sound/wod13/rifle.ogg'
	loot = list()
	AIStatus = AI_OFF

	var/follow = TRUE
	var/mob/living/carbon/human/beastmaster
	var/list/enemies = list()
	var/mob/living/targa

/mob/living/simple_animal/hostile/beastmaster/Initialize(mapload)
	. = ..()
	GLOB.beast_list += src

/mob/living/simple_animal/hostile/beastmaster/Destroy()
	. = ..()

	if (stat >= SOFT_CRIT)
		return

	if(beastmaster)
		beastmaster.beastmaster -= src
		if(!length(beastmaster.beastmaster))
			for(var/datum/action/beastmaster_stay/E in beastmaster.actions)
				if(E)
					qdel(E)
			for(var/datum/action/beastmaster_deaggro/E in beastmaster.actions)
				if(E)
					qdel(E)
	GLOB.beast_list -= src

/mob/living/simple_animal/hostile/beastmaster/death(gibbed)
	. = ..()
	if(beastmaster)
		beastmaster.beastmaster -= src
		if(!length(beastmaster.beastmaster))
			for(var/datum/action/beastmaster_stay/E in beastmaster.actions)
				if(E)
					qdel(E)
			for(var/datum/action/beastmaster_deaggro/E in beastmaster.actions)
				if(E)
					qdel(E)
	GLOB.beast_list -= src

/mob/living/simple_animal/hostile/beastmaster/proc/handle_automated_beasting()
	if(client)
		return
	if(stat > 0)
		GLOB.beast_list -= src
		return
	if(!targa)
		if(length(enemies))
			for(var/mob/living/L in enemies)
				if(L)
					if(L.stat < 1 && L.z == z && get_dist(src, L) < 12)
						targa = L
	else if(targa.z != z || get_dist(src, targa) > 11 || targa.stat > 0)
		targa = null
		if(length(enemies))
			for(var/mob/living/L in enemies)
				if(L)
					if(L.stat < 1 && L.z == z && get_dist(src, L) < 12)
						targa = L

	var/totalshit = 1
	if(total_multiplicative_slowdown() > 0)
		totalshit = total_multiplicative_slowdown()

	if(targa)
		var/reqsteps = round((SSbeastmastering.next_fire-world.time)/totalshit)
		walk_to(src, targa, reqsteps, total_multiplicative_slowdown())
		if(get_dist(src, targa) <= 1)
			ClickOn(targa)
	else
		if(follow && isturf(beastmaster.loc))
			if( (z != beastmaster.z) & (get_dist(beastmaster.loc, loc) <= 10) )
				forceMove(get_turf(beastmaster))
			else
				var/reqsteps = round((SSbeastmastering.next_fire-world.time)/totalshit)
				walk_to(src, beastmaster, reqsteps, total_multiplicative_slowdown())
		else
			walk(src, 0)

/mob/living/simple_animal/hostile/beastmaster/proc/add_beastmaster_enemies(mob/living/L)
	if(istype(L, /mob/living/simple_animal/hostile/beastmaster))
		var/mob/living/simple_animal/hostile/beastmaster/M = L
		if(M.beastmaster == beastmaster)
			return
	if(L == beastmaster)
		return
	enemies |= L
	if(!targa)
		targa = L

/mob/living/simple_animal/hostile/beastmaster/attack_hand(mob/user)
	if(user)
		if(user.a_intent != INTENT_HELP)
			for(var/mob/living/simple_animal/hostile/beastmaster/B in beastmaster.beastmaster)
				B.add_beastmaster_enemies(user)
	. = ..()

/mob/living/simple_animal/hostile/beastmaster/on_hit(obj/projectile/P)
	. = ..()

	if (!P?.firer)
		return

	for (var/mob/living/simple_animal/hostile/beastmaster/B in beastmaster.beastmaster)
		B.add_beastmaster_enemies(P.firer)

/mob/living/simple_animal/hostile/beastmaster/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	. = ..()

	if (!throwingdatum?.thrower)
		return

	for(var/mob/living/simple_animal/hostile/beastmaster/B in beastmaster.beastmaster)
		B.add_beastmaster_enemies(throwingdatum.thrower)

/mob/living/simple_animal/hostile/beastmaster/attackby(obj/item/W, mob/living/user, params)
	. = ..()

	if (!user || !W.force)
		return

	for (var/mob/living/simple_animal/hostile/beastmaster/B in beastmaster.beastmaster)
		B.add_beastmaster_enemies(user)

/mob/living/simple_animal/hostile/beastmaster/grabbedby(mob/living/carbon/user, supress_message = FALSE)
	. = ..()

	if (!user)
		return

	for(var/mob/living/simple_animal/hostile/beastmaster/B in beastmaster.beastmaster)
		B.add_beastmaster_enemies(user)

/mob/living/simple_animal/hostile/beastmaster/attack_animal(mob/user)
	if (user)
		for (var/mob/living/simple_animal/hostile/beastmaster/B in beastmaster.beastmaster)
			B.add_beastmaster_enemies(user)

	. = ..()
