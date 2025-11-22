/obj/structure/brazier
	name = "brazier"
	desc = "A metal pan atop stone brick, meant to hold fire. It is gas-powered, with a strange insignia around the gas knob center."
	icon = 'modular_darkpack/modules/brazier/icons/brazier.dmi'
	icon_state = "brazier"
	layer = OBJ_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = FIRE_PROOF | LAVA_PROOF
	light_range = 0
	light_power = 0
	light_color = "null"
	var/lit = FALSE

/obj/structure/brazier/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(.)
		return

	if(lit)
		turn_off(user)
	else
		turn_on(user)

/obj/structure/brazier/proc/turn_on(mob/user)
	if(lit)
		return

	lit = TRUE
	icon_state = "brazier_lit"
	light_range = 5
	light_power = 3
	light_color = "#ffa35c"
	playsound(src, 'modular_darkpack/modules/brazier/sounds/pilotlight.ogg', 75, TRUE)
	set_light(light_range, light_power, light_color)

	if(user)
		to_chat(user, span_notice("You turn the knob, lighting the [name]."))
		user.visible_message(span_notice("[user] turns the knob, lighting the [name]."), null, null, 3)

/obj/structure/brazier/proc/turn_off(mob/user)
	if(!lit)
		return

	lit = FALSE
	icon_state = "brazier"
	set_light(0)

	if(user)
		to_chat(user, span_notice("You turn the knob backwards, extinguishing the [name]."))
		user.visible_message(span_notice("[user] extinguishes the [name]."), null, null, 3)
