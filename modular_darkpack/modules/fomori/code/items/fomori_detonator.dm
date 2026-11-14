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
	var/explosion_light = 4
	///Radius of medium devastation explosive impact
	var/explosion_heavy = 0
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
		addtimer(CALLBACK(src, PROC_REF(explode)), delay) // TODO: make the below filter blink
		imp_in.add_filter(name = "detonation_filter", priority = 1, params = list(
			type = "rays",
			y = 0,
			size = 32,
			color = COLOR_RED,
			density = 20))
		imp_in.set_light(3, 1, COLOR_RED)
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
		imp_in.remove_filter("detonation_filter")
		kill_mob.investigate_log("has been gibbed by an explosive implant.", INVESTIGATE_DEATHS)
		kill_mob.gib(DROP_ORGANS|DROP_BODYPARTS)
	qdel(src)

/datum/computer_file/program/fomori_detonator
	filename = "failsafe_fl"
	filedesc = "Failsafe FL-8006"
	can_run_on_flags = PROGRAM_PDA
	downloader_category = PROGRAM_CATEGORY_DEVICE
	program_open_overlay = null
	extended_desc = "A program for denying company assets to competitors in the event \
		of a catastrophic failure in containment protocols or asset retention exercises."
	size = 1
	tgui_id = "DarkpackFomoriFailsafe"
	program_icon = "fa-bomb"
	run_access = list("failsafe_detonator")
	var/list/obj/item/implant/walking_bomb/implants = list()

/datum/computer_file/program/fomori_detonator/proc/boom(dna)
	var/obj/item/implant/implant = implants[dna]
	var/mob/living/carbon/human/fomor = implant.imp_in
	computer.say("Failsafe procedure FL-[rand(0, 9999)] initiated at [get_area(fomor)]. Asset will be terminated in 15 seconds.", spans = list(SPAN_ROBOT))
	playsound(computer, 'sound/machines/terminal/terminal_processing.ogg', 50)
	implant.activate("remote detonation via [computer] at [ADMIN_VERBOSEJMP(computer)].")


/datum/computer_file/program/fomori_detonator/ui_data(mob/user)
	var/health_status

	var/list/data = list()
	data["fomor_list"] = list()
	for(var/mob/living/carbon/human/fomor in GLOB.human_list)
		if(get_fomori_splat(fomor))
			var/imp = locate(/obj/item/implant/walking_bomb) in fomor.implants
			if(!imp)
				continue
			implants[fomor.dna.unique_enzymes] = imp
			switch(fomor.stat)
				if(0) // conscious
					health_status = "GREEN"
				if(1) // soft crit
					health_status = "YELLOW"
				if(2) // unconscious
					health_status = "RED"
				if(3) // hard crit
					health_status = "BLACK"
				if(4) // dead
					health_status = "DECEASED"
			if(fomor.stat == DEAD && isnull(fomor.mind))
				health_status = "UNRECOVERABLE"

			var/list/fomor_data = list(
				"name" = fomor.dna.real_name,
				"location" = get_area(fomor),
				"status" = health_status,
				"boom" = FALSE,
				"dna" = fomor.dna.unique_enzymes,
				"armed" = implants[fomor.dna.unique_enzymes].active
			)
			data["fomor_list"] += list(fomor_data)
	return data

/datum/computer_file/program/fomori_detonator/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	switch(action)
		if("boom")
			boom(params["dna"])

			return TRUE

/obj/item/modular_computer/detonator
	name = "asset recovery failsafe device"
	desc = "For really big problems."
	icon = 'modular_darkpack/modules/fomori/icons/fomori_items.dmi'
	base_icon_state = "detonator"
	icon_state = "detonator_off"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fomori/icons/fomori_items_onfloor.dmi')
	overlays_icon = 'modular_darkpack/modules/fomori/icons/fomori_items.dmi'
	starting_programs = list(/datum/computer_file/program/fomori_detonator)
	max_capacity = 1
	icon_state_powered = "detonator"
	icon_state_unpowered = "detonator_off"
	greyscale_config = null
	base_active_power_usage = 0.2 WATTS // power efficient!
	base_idle_power_usage = 0.1 WATTS
	device_theme = PDA_THEME_TERMINAL
	var/light_mask = "detonator-light-mask"

/obj/item/modular_computer/detonator/update_overlays()
	. = ..()
	if(icon == onflooricon)
		overlays_icon = onflooricon

	if(light_mask && enabled)
		. += emissive_appearance(icon, light_mask, src)

/obj/item/card/id/advanced/gold/detonator
	name = "failsafe card"
	desc = "A golden card to authorize the Failsafe."
	access = list("failsafe_detonator")
	assignment = MAIN_EVIL_COMPANY + " Branch Lead"
	inherent_assigned_name = MAIN_EVIL_COMPANY + " Branch Lead"
	brand = "pentex"

/obj/item/storage/briefcase/secure/failsafe_detonator
	name = "failsafe football"
	desc = "The nuclear one has not yet been purchased by " + EVIL_NUCLEAR_COMPANY +", so this will have to do."
	icon = 'modular_darkpack/modules/fomori/icons/fomori_items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fomori/icons/fomori_items_onfloor.dmi')
	icon_state = "football"
	base_icon_state = "football"
	brand = "pentex"
	var/light_mask = "football-light-mask"

/obj/item/storage/briefcase/secure/failsafe_detonator/Initialize(mapload)
	. = ..()
	update_overlays()

/obj/item/storage/briefcase/secure/failsafe_detonator/update_overlays()
	. = ..()
	. += emissive_appearance(icon, light_mask, src)

/obj/item/storage/briefcase/secure/failsafe_detonator/PopulateContents()
	new /obj/item/modular_computer/detonator(src)
	new /obj/item/card/id/advanced/gold/detonator(src)
