// RITUALISM

/datum/action/necroritualism
	name = "necroritualism"
	desc = "Draw runes to perform Necromancy Rituals."
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "necroritualism"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/drawing = FALSE
	var/level = 1

/datum/action/necroritualism/Trigger(trigger_flags)
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.bloodpool < 2)
		to_chat(H, span_warning("You need more <b>BLOOD</b> to do that!"))
		return

	if(istype(H.get_active_held_item(), /obj/item/necromancy_tome))
		var/list/rune_names = list()
		for(var/i in subtypesof(/obj/necrorune))
			var/obj/necrorune/R = new i(owner)
			if(R.necrolevel <= level)
				rune_names[R.name] = i
			qdel(R)
		var/ritual = tgui_input_list(owner, "Choose rune to draw:", "Necromancy", rune_names)
		if(!ritual)
			return
		if(do_after(H, 3 SECONDS * max(1, 5 - H.st_get_stat(STAT_OCCULT)), H))
			var/ritual_type = rune_names[ritual]
			new ritual_type(H.loc)
			H.bloodpool = max(H.bloodpool - 2, 0)
			SEND_SIGNAL(H, COMSIG_MASQUERADE_VIOLATION)

	else
		var/list/rune_names = list()
		for(var/i in subtypesof(/obj/necrorune))
			var/obj/necrorune/R = new i(owner)
			if(R.necrolevel <= level)
				rune_names += i
			qdel(R)
		var/ritual = tgui_input_list(owner, "Choose rune to draw:", "necroritualism", list("???"))
		if(!ritual)
			return
		if(do_after(H, 30*max(1, 5-H.st_get_stat(STAT_OCCULT)), H))
			var/rune = pick(rune_names)
			new rune(H.loc)
			H.bloodpool = max(H.bloodpool - 2, 0)
			SEND_SIGNAL(H, COMSIG_MASQUERADE_VIOLATION)
