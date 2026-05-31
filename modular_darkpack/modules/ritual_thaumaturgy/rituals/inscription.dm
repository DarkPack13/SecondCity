/obj/ritual_rune/thaumaturgy/inscription
	name = "inscription"
	desc = "Create a scroll inscribed with vitae to allow unskilled thaumaturgists or those without thaumaturgy to use a level one or two ritual."
	icon_state = "rune5"
	word = ""
	level = 2
	sacrifices = list(/obj/item/paper)
	var/ritual_selected

/obj/ritual_rune/thaumaturgy/inscription/attack_hand(mob/living/user)
	. = ..()
	var/datum/action/ritual_drawing/ritual_action = locate() in user.actions
	if(!ritual_action)
		return
	var/list/ritual_selection = ritual_action.get_available_runes()

	var/selection = tgui_input_list(user, "What ritual do you wish to inscribe onto the scroll?", "Ritual Inscription", ritual_selection)
	if(!selection)
		to_chat(user, span_cult("You decide not to inscribe a ritual onto the parchment."))
		return

	ritual_selected = selection

/obj/ritual_rune/thaumaturgy/inscription/complete()
	. = ..()
	var/obj/item/thaumaturgy_scroll/ritual_scroll = new() // add ritual selected here

	if(!ritual_roll_datum)
		return

	to_chat(last_activator, span_cult("You inscribe your vitae onto the paper using Thaumaturgy, allowing the scroll, and the ritual inscribed, to be used by unskilled thaumaturgists, or those without any skill in Thaumaturgy at all."))
	qdel(src)

/obj/item/thaumaturgy_scroll
	name = "scroll"
	desc = "a scroll allowing non-thaumaturgists to use ritual thaumaturgy."
	icon = 'modular_darkpack/modules/ritual_thaumaturgy/icons/ritual_scroll.dmi'
	icon_state = "scroll"
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/ritual_thaumaturgy/icons/onfloor.dmi')
	var/ritual

/obj/item/thaumaturgy_scroll/Initialize(mapload)
	. = ..()


