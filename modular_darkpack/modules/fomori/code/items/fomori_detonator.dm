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
	name = "fomor debug pda"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_items.dmi'
	base_icon_state = "detonator_off"
	icon_state = "detonator_off"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fomori/icons/fomori_items_onfloor.dmi')
	starting_programs = list(/datum/computer_file/program/fomori_detonator)
	max_capacity = 1
	icon_state_powered = "detonator"
	icon_state_unpowered = "detonator_off"
	greyscale_config = null
	base_active_power_usage = 0.2 WATTS // power efficient!
	base_idle_power_usage = 0.1 WATTS
	var/light_mask = "detonator-light-mask"

/obj/item/modular_computer/detonator/update_overlays()
	. = ..()
	if(light_mask && enabled)
		. += emissive_appearance(icon, light_mask, src)
