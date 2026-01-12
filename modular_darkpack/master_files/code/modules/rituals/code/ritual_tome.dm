//the parent type of necromancy, arcane, abyss mysticism tomes
/obj/item/ritual_tome
	abstract_type = /obj/item/ritual_tome
	name = "ritual tome"
	desc = "A mysterious tome. This shouldnt be spawning ingame, if it is, something's wrong."
	w_class = WEIGHT_CLASS_SMALL
	custom_materials = list(/datum/material/paper = SHEET_MATERIAL_AMOUNT * 0.75)
	var/list/rituals = list()
	var/rune_type //ritual_rune/abyss, ritual_rune/thaumaturgy, etc
	var/static/list/ritual_cache = list()

/obj/item/ritual_tome/Initialize()
	. = ..()
	if(!rune_type)
		return

	if(!ritual_cache[rune_type])
		ritual_cache[rune_type] = list()
		for(var/rune_path in subtypesof(rune_type))
			var/obj/R = new rune_path()
			ritual_cache[rune_type] += R

	rituals = ritual_cache[rune_type]

/obj/item/ritual_tome/attack_self(mob/user)
	. = ..()
	if(!isliving(user))
		return
	var/mob/living/reader = user
	if(!iskindred(user) && !isghoul(user))
		if(reader.st_get_stat(STAT_OCCULT) < 3)
			to_chat(reader, span_cult("A strange book that looks like it belongs in a dusty Library or a garage sale. You find yourself not caring, or understanding, too much about it."))
			return

	display_rituals(reader)

/obj/item/ritual_tome/proc/display_rituals(mob/user)
	for(var/obj/ritual_rune/R in rituals)
		var/requirements = get_ritual_requirements(R)
		var/level = get_ritual_level(R)
		var/ritual_name = R.ritual_name
		var/ritual_desc = R.desc

		to_chat(user, span_cult("[level] <b>[ritual_name]</b> - [ritual_desc][requirements ? " Requirements: [requirements]." : ""]"))

/obj/item/ritual_tome/proc/get_ritual_requirements(obj/rune)
	if(!islist(rune.vars["sacrifices"]))
		return ""

	var/list/sacrifices = rune.vars["sacrifices"]
	if(!length(sacrifices))
		return ""

	var/list/required_items = list()
	for(var/obj/item/item_type as anything in sacrifices)
		required_items += item_type::name

	return required_items.Join("\n")

/obj/item/ritual_tome/proc/get_ritual_level(obj/rune)
	if(rune.vars["level"])
		return rune.vars["level"]
	return ""
