/datum/action/mysticism
	name = "Mysticism"
	desc = "Abyss Mysticism rune drawing."
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "mysticism"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	vampiric = TRUE
	var/drawing = FALSE
	var/level = 1

/datum/action/mysticism/Trigger(trigger_flags)
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(drawing)
		return

	var/list/rituals = list()
	for(var/i in subtypesof(/obj/abyssrune))
		var/obj/abyssrune/R = new i(owner)
		if(R.mystlevel <= level)
			rituals[R.name] = list("name" = i, "cost" = R.cost)
		qdel(R)

	var/ritual

	if(istype(H.get_active_held_item(), /obj/item/mystic_tome))
		ritual = tgui_input_list(owner, "Choose rune to draw:", "Mysticism", rituals, null)
	else
		ritual = tgui_input_list(owner, "Choose rune to draw (You need a Mystic Tome to reduce random):", "Mysticism", list("???"))
		if(ritual)
			ritual = pick(rituals)

	if(!ritual)
		return

	var/rtype = rituals[ritual]
	var/rname = rtype["name"]
	var/rcost = rtype["cost"]

	if(H.bloodpool >= rcost)
		drawing = TRUE
		if(do_after(H, 3 SECONDS * max(1, 5 - H.st_get_stat(STAT_OCCULT)), H))
			drawing = FALSE
			new rname(H.loc)
			H.bloodpool = max(H.bloodpool - rcost, 0)
			SEND_SIGNAL(H, COMSIG_MASQUERADE_VIOLATION)
	else
		to_chat(H, span_warning("You need more <b>BLOOD</b> to do that!"))
		drawing = FALSE
		return

	drawing = FALSE
