/// Inits GLOB.glyph_list
/proc/init_glyphs()
	var/glyph_list = list()
	for(var/path in valid_subtypesof(/obj/effect/decal/garou_glyph))
		var/obj/effect/decal/garou_glyph/S = path
		glyph_list[S.garou_name] = S
	sort_list(glyph_list, GLOBAL_PROC_REF(cmp_typepaths_asc))
	return glyph_list

/obj/item/pen/charcoal/interact_with_atom(atom/target, mob/user, list/modifiers, list/attack_modifiers)
	if(!isopenturf(target) || isgroundlessturf(target))
		return NONE

	if(!user.has_language(/datum/language/garou_tongue, UNDERSTOOD_LANGUAGE))
		return NONE

	if(!GLOB.glyph_list.len)
		to_chat(user, span_notice("There are no glyphs available."))
		return NONE

	var/list/glyph_names = list()

	for(var/glyph in GLOB.glyph_list)
		glyph_names += glyph

	var/choice = tgui_input_list(user, "Select a glyph to draw.", "Glyph Selection", glyph_names)
	if(!choice)
		return ITEM_INTERACT_BLOCKING

	var/obj/effect/decal/garou_glyph/drawn_glyph = GLOB.glyph_list[choice]
	if(drawn_glyph)
		user.visible_message(span_notice("[user] starts to scrape a glyph into the ground..."), \
		span_notice("You begin to etch the spirals and lines of your chosen glyph..."))

		if(do_after(user, 5 SECONDS, target))
			new drawn_glyph.type(target)
			user.visible_message(span_notice("[user] finishes up their rune."), \
			span_notice("You put the finishing touches on your rune, as it marks the ground before you."))
			return ITEM_INTERACT_SUCCESS
		else
			user.visible_message(span_notice("[user] slips, smduges and ruins their glyph."), \
			span_notice("You mess it up, the glyph turning into nothing more than a smear upon the ground."))
			return ITEM_INTERACT_FAILURE

/obj/effect/decal/garou_glyph
	abstract_type = /obj/effect/decal/garou_glyph
	name = "odd glyph"
	desc = "An odd collection of symbols drawn in what seems to be charcoal."
	anchored = TRUE
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/glyphs.dmi'
	icon_state = "garou"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	// Very likely not needed
	// layer = SIGIL_LAYER
	var/garou_name = "basic glyph"
	var/garou_desc = "a basic glyph with no meaning." // This is shown to werewolves who examine the glyph in order to determine its true meaning.

/obj/effect/decal/garou_glyph/examine(mob/user)
	. = ..()
	if(user.has_language(/datum/language/garou_tongue, UNDERSTOOD_LANGUAGE))
		. += "<b>Name:</b> [garou_name]\n"
		. += "<b>Description:</b> [garou_desc]\n"

/obj/effect/decal/garou_glyph/wyrm
	name = "creepy glyph"
	garou_name = "wyrm glyph"
	garou_desc = "A glyph that represents the Wyrm, a force of corruption and destruction."
	icon_state = "wyrm"

/obj/effect/decal/garou_glyph/vampire
	name = "weird glyph"
	garou_name = "vampire glyph"
	garou_desc = "A glyph that represents the Kindred, leeches of the Weaver and Wyrm."
	icon_state = "vampire"

/obj/effect/decal/garou_glyph/kinfolk
	name = "uncanny glyph"
	garou_name = "kinfolk glyph"
	garou_desc = "A glyph that represents the Kinfolk, the human relatives of the Garou."
	icon_state = "kinfolk"

/obj/effect/decal/garou_glyph/dance
	name = "funky glyph"
	garou_name = "dancing glyph"
	garou_desc = "A glyph that represents the spiritual dancing of the Garou."
	icon_state = "dance"

/obj/effect/decal/garou_glyph/caern
	name = "eerie glyph"
	garou_name = "caern glyph"
	garou_desc = "A glyph that represents the Caern, a sacred location that naturally flows with spiritual energy."
	icon_state = "caern"

/obj/effect/decal/garou_glyph/danger
	name = "peculiar glyph"
	garou_name = "danger glyph"
	garou_desc = "A glyph that represents danger! Proceed with caution."
	icon_state = "danger"

/obj/effect/decal/garou_glyph/garou
	name = "freakish glyph"
	garou_name = "garou glyph"
	garou_desc = "A glyph that represents the Garou, the warriors of Gaia."
	icon_state = "garou"

/obj/effect/decal/garou_glyph/conceal
	name = "mysterious glyph"
	garou_name = "conceal glyph"
	garou_desc = "A glyph that represents the obfuscation of something. What may be hidden from you?"
	icon_state = "conceal"

/obj/effect/decal/garou_glyph/hive
	name = "outlandish glyph"
	garou_name = "hive glyph"
	garou_desc = "A glyph that represents a Hive, the foul home of a Black Spiral Dancer pack."
	icon_state = "hive"

/obj/effect/decal/garou_glyph/howl
	name = "unusual glyph"
	garou_name = "howling glyph"
	garou_desc = "A glyph that represents the natural song of the Garou, the howl."
	icon_state = "howl"

/obj/effect/decal/garou_glyph/remembrance
	name = "morose glyph"
	garou_name = "remembrance glyph"
	garou_desc = "A glyph that represents the mourning and remembrance of the fallen."
	icon_state = "remembrance"

/obj/effect/decal/garou_glyph/watch
	name = "odd glyph"
	garou_name = "watch glyph"
	garou_desc = "A glyph that marks something as in need of monitoring"
	icon_state = "watch"

/obj/effect/decal/garou_glyph/toxic
	name = "foul glyph"
	garou_name = "toxic glyph"
	garou_desc = "A glyph that represents toxicity, the material corruption of the Wyrm on the Earth."
	icon_state = "toxic"

/obj/effect/decal/garou_glyph/dancers
	name = "alien glyph"
	garou_name = "\improper Black Spiral Dancer glyph"
	garou_desc = "A glyph that represents the tribe of the Black Spiral Dancers."
	icon_state = "black_spiral_dancers"

/obj/effect/decal/garou_glyph/glasswalkers
	name = "quirky glyph"
	garou_name = "\improper Glasswalkers glyph"
	garou_desc = "A glyph that represents the Glasswalkers tribe."
	icon_state = "glasswalkers"

/obj/effect/decal/garou_glyph/galestalkers
	name = "abnormal glyph"
	garou_name = "\improper Younger Brother glyph"
	garou_desc = "A glyph that represents the Galestalkers tribe."
	icon_state = "younger_brother"

/obj/effect/decal/garou_glyph/war_against_wyrm
	name = "terrifying glyph"
	garou_name = "war against wyrm glyph"
	garou_desc = "A glyph that represents the apocalyptic war of the Garou against the Wyrm."
	icon_state = "war_against_wyrm"
