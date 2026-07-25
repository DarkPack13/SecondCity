/datum/computer_file/program/fomori_detonator
	filename = "failsafe_fl"
	filedesc = "Failsafe FL-8006"
	can_run_on_flags = PROGRAM_PDA
	downloader_category = PROGRAM_CATEGORY_DEVICE
	program_open_overlay = "generic"
	extended_desc = "A program for denying company assets to competitors in the event \
		of a catastrophic failure in containment protocols or asset retention exercises."
	size = 1
	tgui_id = "DarkpackFomoriFailsafe"
	program_icon = "fa-bomb"
	var/list/implants = list()

/datum/computer_file/program/fomori_detonator/proc/boom(dna)
	var/obj/item/implant/implant = implants[dna]
	implant.activate("remote detonation")

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
			if(isnull(fomor.mind))
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

/obj/item/modular_computer/pda/detonator
	name = "fomor debug pda"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_items.dmi'
	icon_state = "detonator"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fomori/icons/fomori_items_onfloor.dmi')
	starting_programs = list(/datum/computer_file/program/fomori_detonator)
	max_capacity = 1
	icon_state_powered = "detonator"
	icon_state_unpowered = "detonator"
	greyscale_config = null
