/obj/ritualrune
	name = "Tremere Rune"
	desc = "Learn the secrets of blood, neonate..."
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "rune1"
	color = rgb(128,0,0)
	anchored = TRUE
	var/word = "IDI NAH"
	var/activator_bonus = 0
	var/activated = FALSE
	var/mob/living/last_activator
	var/thaumlevel = 1
	var/list/sacrifices = list()

/obj/ritualrune/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_CLICK_ALT, PROC_REF(on_alt_click))

/obj/ritualrune/proc/on_alt_click(datum/source, mob/user)
	SIGNAL_HANDLER

	qdel(src)

/obj/ritualrune/proc/complete()
	return

/obj/ritualrune/attack_hand(mob/user)
	if(!activated)
		var/mob/living/L = user
		if(HAS_TRAIT(L, TRAIT_THAUMATURGY_KNOWLEDGE))
			L.say(word)
			L.Immobilize(30)
			last_activator = user
			activator_bonus = L.thaum_damage_plus

			// (Optionally a rune animation to glow brighter)
			animate(src, color = rgb(255, 64, 64), time = 10)

			if(sacrifices.len > 0)
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
					complete()
				else
					to_chat(user, "You lack the necessary sacrifices to complete the ritual. Found [found_items.len], required [sacrifices.len].")
			else
				complete()
