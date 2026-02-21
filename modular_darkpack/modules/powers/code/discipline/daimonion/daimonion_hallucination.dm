/datum/hallucination/baali
	var/obj/effect/hallucination/simple/demon/demon
	var/demontype // TFN ADDITION - Psychomania Rework
	var/turf/landing
	var/charged
	COOLDOWN_DECLARE(next_cooldown)

/datum/hallucination/baali/New(mob/living/carbon/C, forced = TRUE, new_demontype)
	set waitfor = FALSE
	. = ..()
	var/turf/closed/wall/wall
	for(var/turf/closed/wall/W in range(7,hallucinator))
		wall = W
		break
	if(!wall)
		return INITIALIZE_HINT_QDEL
	feedback_details += "Source: [wall.x],[wall.y],[wall.z]"
	hallucinator.playsound_local(wall,'sound/effects/meteorimpact.ogg', 150, 1)
	demon = new(wall, hallucinator)
	//TFN EDIT START - Psychomania Rework
	demontype = new_demontype
	if (isnull(new_demontype))
		demontype = pick("demon", "spectre", "wyrm", "banu", "tremere")
	switch(demontype)
		if("demon")
			demon.image_icon = 'code/modules/wod13/32x48.dmi'
			demon.image_state = "baali"
		if("spectre")
			demon.name = "Specter"
			demon.image_icon = 'icons/mob/mob.dmi'
			demon.image_state = "shadeh"
		if("wyrm")
			demon.name = "Wyrmic Avatar"
			demon.image_icon = 'code/modules/wod13/48x64.dmi'
			demon.image_state = "bigskeleton"
		if("tremere")
			demon.name = "RECLAIMER"
			demon.image_icon = 'code/modules/wod13/48x64.dmi'
			demon.image_state = "4armstzi"
		if("banu")
			demon.name = "LOREMASTER"
			demon.image_icon = 'icons/mob/32x64.dmi'
			demon.image_state = "eva"
	//TFN EDIT END - Psychomania Rework
	addtimer(CALLBACK(src, PROC_REF(start_processing)), 10)


/datum/hallucination/baali/proc/start_processing()
	if (isnull(hallucinator))
		qdel(src)
		return
	START_PROCESSING(SSfastprocess, src)

/datum/hallucination/baali/process(delta_time)
	if(!COOLDOWN_FINISHED(src, next_cooldown))
		return

	if (hallucinator?.stat != DEAD)
		demon.forceMove(get_step_towards(demon, hallucinator))
		demon.setDir(get_dir(demon, hallucinator))
		hallucinator.playsound_local(get_turf(demon), 'sound/effects/meteorimpact.ogg', 150, 1)
		QDEL_IN(src, 4 SECONDS)
		if(demon.Adjacent(hallucinator) && !charged)
			charged = TRUE
			//TFN EDIT START - Psychomania Rework
			switch(demontype)
				if("demon")
					hallucinator.visible_message(span_warning("[hallucinator] falls on their knees"), span_warning("[demon] grasps my head with its hands"),)
					hallucinator.Paralyze(7 SECONDS)
					hallucinator.adjustStaminaLoss(200)
					hallucinator.playsound_local(hallucinator, "modular_tfn/modules/daim/audio/demonlaugh1.ogg", 50, FALSE)
					to_chat(hallucinator, span_cult("HELL IS REAL, IT HAS TOUCHED ME"))
				if("spectre")
					hallucinator.visible_message(span_warning("[hallucinator] collapses onto the ground"), span_warning("[demon] touches you with an outstretched hand"),) //Spectres being spooky
					hallucinator.Paralyze(7 SECONDS)
					hallucinator.adjustStaminaLoss(200)
					to_chat(hallucinator, span_cult("THE SPIRIT HAS TAKEN SOMETHING FROM ME"))
				if("wyrm")
					hallucinator.visible_message(span_warning("[hallucinator] whines in animalistic fear"), span_cult("THE WYRM HAS NOTICED ME"),) //Pick your bane name
					hallucinator.Paralyze(5 SECONDS)
					hallucinator.playsound_local(hallucinator, "modular_tfn/modules/daim/audio/malklaugh.ogg", 50, FALSE)
				if("banu")
					hallucinator.visible_message(span_warning("[hallucinator] grasps his chest, feeling for a hole"), span_cult("THE [demon] PLUCKS OUT YOUR HEART"),) //Ur-Shulgi doesnt take shit from anyone
					hallucinator.Paralyze(7 SECONDS)
				if("tremere")
					hallucinator.visible_message(span_warning("[hallucinator] collapses onto the ground, convulsing"), span_cult("THE [demon] TAKES YOUR VITAE"),) //saulot/tzimice's repo man
					hallucinator.playsound_local(hallucinator, "modular_tfn/modules/daim/audio/malklaugh.ogg", 50, FALSE)
					hallucinator.Paralyze(7 SECONDS)
			//TFN EDIT END - Psychomania Rework
			step_away(hallucinator, demon)
			STOP_PROCESSING(SSfastprocess, src)
			qdel(src)
		COOLDOWN_START(src, next_cooldown, 2 SECONDS)
	else
		STOP_PROCESSING(SSfastprocess, src)
		QDEL_IN(src, 3 SECONDS)

/datum/hallucination/baali/Destroy()
	QDEL_NULL(demon)
	STOP_PROCESSING(SSfastprocess, src)
	return ..()
