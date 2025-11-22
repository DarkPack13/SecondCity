//the parent type of necromancy, arcane, abyss mysticism tomes
/obj/item/ritual_tome
	abstract_type = /obj/item/ritual_tome
	name = "ritual tome"
	desc = "A mysterious tome. This shouldnt be spawning ingame, if it is, something's wrong."
	w_class = WEIGHT_CLASS_SMALL
	var/list/rituals = list()
	var/rune_type //ritual_rune/abyss, ritual_rune/thaumaturgy, etc

/obj/item/ritual_tome/Initialize()
	. = ..()
	if(!rune_type)
		return

	for(var/rune_path in subtypesof(rune_type))
		var/obj/R = new rune_path(src)
		rituals += R

/obj/item/ritual_tome/attack_self(mob/user)
	. = ..()
	display_rituals(user)

/obj/item/ritual_tome/proc/display_rituals(mob/user)
	for(var/obj/R in rituals)
		var/requirements = get_ritual_requirements(R)
		var/level = get_ritual_level(R)
		var/ritual_name = R.name
		var/ritual_desc = R.desc

		to_chat(user, span_cult("[level] [ritual_name] - [ritual_desc][requirements ? " Requirements: [requirements]." : ""]"))

/obj/item/ritual_tome/proc/get_ritual_requirements(obj/rune)
	if(!islist(rune.vars["sacrifices"]))
		return ""

	var/list/sacrifices = rune.vars["sacrifices"]
	if(!length(sacrifices))
		return ""

	var/list/required_items = list()
	for(var/item_type in sacrifices)
		var/obj/item/I = new item_type(src)
		required_items += I.name
		qdel(I)

	return required_items.Join("\n")

/obj/item/ritual_tome/proc/get_ritual_level(obj/rune)
	if(rune.vars["level"])
		return rune.vars["level"]
	return ""
