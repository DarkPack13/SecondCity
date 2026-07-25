// Largely copied from code/game/objects/items/implants/implant_explosive.dm, but snowflaked because it functions relatively different.
/obj/item/implant/walking_bomb
	name = "failsafe implant"
	desc = "And boom goes the weasel."
	icon_state = "explosive"
	actions_types = null
	brand = "nastrum"
	///Whether the implant's explosion sequence has been activated or not
	var/active = FALSE
	///The final countdown (delay before we explode)
	var/delay = 3 TURNS
	///If the delay is equal or lower to 3 TURNS (15 sec), the explosion will be instantaneous.
	var/instant_explosion = TRUE
	///Radius of weak devastation explosive impact
	var/explosion_light = 3
	///Radius of medium devastation explosive impact
	var/explosion_heavy = 1
	///Radius of heavy devastation explosive impact
	var/explosion_devastate = 0
	///Whether the confirmation UI popup is active or not
	var/popup = FALSE
	///Do we rapidly increase the beeping speed as it gets closer to detonating?
	var/panic_beep_sound = TRUE
	///Do we disable paralysis upon activation
	var/no_paralyze = TRUE
	///Do we explode on death?
	var/explode_on_death
	///Do we override other explosive implants?
	var/master_implant = FALSE
	///Will this implant notify ghosts when activated?
	var/notify_ghosts = TRUE


/obj/item/implant/walking_bomb/proc/on_death(datum/source, gibbed)
	SIGNAL_HANDLER

	// There may be other signals that want to handle mob's death
	// and the process of activating destroys the body, so let the other
	// signal handlers at least finish. Also, the "delayed explosion"
	// uses sleeps, which is bad for signal handlers to do.
	if(explode_on_death)
		INVOKE_ASYNC(src, PROC_REF(activate), "death")

/obj/item/implant/walking_bomb/activate(cause, activator)
	. = ..()
	if(!cause || !imp_in || active)
		return FALSE
	if(cause == "death" && HAS_TRAIT(imp_in, TRAIT_PREVENT_IMPLANT_AUTO_EXPLOSION))
		return FALSE
	active = TRUE
	var/turf/boomturf = get_turf(imp_in)
	message_admins("[ADMIN_LOOKUPFLW(imp_in)]'s [name] has been activated at [ADMIN_VERBOSEJMP(boomturf)].")
	//If the delay is shorter or equal to the default delay, just blow up already jeez
	if(delay < 3 TURNS && instant_explosion)
		explode()
		return
	timed_explosion()

/obj/item/implant/walking_bomb/implant(mob/living/target, mob/user, silent = FALSE, force = FALSE)
	for(var/target_implant in target.implants)
		if(istype(target_implant, /obj/item/implant/walking_bomb))
			target.balloon_alert(user, "cannot fit implant!")
			return FALSE

	. = ..()
	if(.)
		RegisterSignal(target, COMSIG_LIVING_DEATH, PROC_REF(on_death))

/obj/item/implant/walking_bomb/removed(mob/target, silent = FALSE, special = FALSE)
	. = ..()
	if(.)
		UnregisterSignal(target, COMSIG_LIVING_DEATH)

/**
 * Explosive activation sequence for implants with a delay longer than 3 TURNS.
 * Make the implantee beep a few times, keel over and explode. Usually to a devastating effect.
 */
/obj/item/implant/walking_bomb/proc/timed_explosion()
	if (isnull(imp_in))
		visible_message(span_warning("[src] starts beeping ominously!"))
	else
		imp_in.visible_message(span_warning("[imp_in] starts beeping ominously!"))
		if(notify_ghosts)
			notify_ghosts(
				"[imp_in.real_name]'s [name] is about to explode!",
				source = src,
				header = "Tick Tick Tick...",
				notify_flags = NOTIFY_CATEGORY_NOFLASH,
				ghost_sound = 'sound/machines/warning-buzzer.ogg',
				notify_volume = 75,
			)

	playsound(loc, 'sound/items/timer.ogg', 30, FALSE)
	if(!panic_beep_sound)
		sleep(delay * 0.25)
	if(imp_in && !imp_in.stat && !no_paralyze)
		imp_in.visible_message(span_warning("[imp_in] doubles over in pain!"))
		imp_in.Paralyze(14 SECONDS)

	if(!panic_beep_sound)
		for(var/index in 1 to 3) // Total of 4 bomb beeps, and we've already beeped once
			//for extra spice
			var/beep_volume = 30 + (5 * index)
			playsound(loc, 'sound/items/timer.ogg', beep_volume, vary = FALSE)
			sleep(delay * 0.25)
		explode()
	else
		addtimer(CALLBACK(src, PROC_REF(explode)), delay)
		while(delay > 1) //so we dont accidentally enter an infinite sleep
			var/beep_volume = 35
			playsound(loc, 'sound/items/timer.ogg', beep_volume, vary = FALSE)
			sleep(delay * 0.1)
			delay -= delay * 0.1
			beep_volume += 5

///When called, just explodes
/obj/item/implant/walking_bomb/proc/explode(atom/override_explode_target = null)
	explosion_devastate = floor(explosion_devastate)
	explosion_heavy = floor(explosion_heavy)
	explosion_light = floor(explosion_light)
	explosion(override_explode_target || src, devastation_range = explosion_devastate, heavy_impact_range = explosion_heavy, light_impact_range = explosion_light, flame_range = explosion_light, flash_range = explosion_light, explosion_cause = src)
	var/mob/living/kill_mob = isliving(override_explode_target) ? override_explode_target : imp_in
	if(!isnull(kill_mob))
		kill_mob.investigate_log("has been gibbed by an explosive implant.", INVESTIGATE_DEATHS)
		kill_mob.gib(DROP_ORGANS|DROP_BODYPARTS)
	qdel(src)

/datum/action/cooldown/power/fomori_power/walking_bomb // Freak Legion pg. 47
	name = "Walking Bomb"
	desc = "There's a bomb in your head"
	rank = 1 // of 1
	cooldown_time = 5 SCENES // 15 minutes

/datum/action/cooldown/power/fomori_power/walking_bomb/Grant(mob/granted_to)
	. = ..()
	var/mob/living/carbon/human/fomor = granted_to
	var/obj/item/implant/walking_bomb/imp = new
	imp.implant(fomor, fomor, TRUE, TRUE)
	Remove(fomor)
