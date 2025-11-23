//parent rune type for thaumaturgy, necromancy, obtenebration
/obj/ritual_rune
	abstract_type = /obj/ritual_rune
	name = "ritual rune"
	desc = "A mystical rune."
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "rune1"
	anchored = TRUE

	var/word = "IDI NAH"
	var/activator_bonus = 0
	var/activated = FALSE
	var/mob/living/last_activator
	var/level = 1
	var/list/sacrifices = list()
	var/activation_color
	var/cost = 2
	var/ritual_name

	// TRAIT_MYSTICISM_KNOWLEDGE, TRAIT_THAUMATURGY_KNOWLEDGE, TRAIT_NECROMANCY_KNOWLEDGE
	var/required_trait


/obj/ritual_rune/Initialize(mapload)
	. = ..()
	ritual_name = name
	name = "[name] rune"
	RegisterSignal(src, COMSIG_CLICK_ALT, PROC_REF(on_alt_click))

/obj/ritual_rune/proc/on_alt_click(datum/source, mob/user)
	SIGNAL_HANDLER
	qdel(src)

/obj/ritual_rune/proc/complete()
	return

/obj/ritual_rune/attack_hand(mob/user)
	if(activated)
		return

	if(!required_trait || !HAS_TRAIT(user, required_trait))
		return

	var/mob/living/L = user
	L.say(word)
	L.Immobilize(30)
	last_activator = user
	if(activation_color)
		animate(src, color = activation_color, time = 10)
	if(length(sacrifices))
		if(!check_and_consume_sacrifices(user))
			return

	complete()

/obj/ritual_rune/proc/check_and_consume_sacrifices(mob/user)
	var/list/found_items = list()

	for(var/obj/item/I in get_turf(src))
		for(var/item_type in sacrifices)
			if(istype(I, item_type))
				if(istype(I, /obj/item/reagent_containers/blood))
					var/obj/item/reagent_containers/blood/bloodpack = I
					if(bloodpack.reagents && bloodpack.reagents.total_volume > 0)
						found_items += I
						break
				else
					found_items += I
					break

	if(found_items.len == sacrifices.len)
		for(var/obj/item/I in found_items)
			qdel(I)
		return TRUE
	else
		to_chat(user, span_warning("You lack the necessary sacrifices to complete the ritual. Found [found_items.len], required [sacrifices.len]."))
		return FALSE
