/obj/item/toy/plush/argemia
	name = "strange plushie"
	desc = "Voiding..."
	icon_state = "argemia"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/toys/icons/toys_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL

/obj/item/toy/plush/argemia/microwave_act(obj/machinery/microwave/microwave_source, mob/microwaver, randomize_pixel_offset)
	. = ..()
	playsound(microwave_source.loc, 'modular_darkpack/modules/toys/sounds/aeaeae.ogg', 100, FALSE)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/obj/item/toy/plush/argemia, microwave_explode), microwave_source), 5 SECONDS)

/obj/item/toy/plush/argemia/proc/microwave_explode(obj/machinery/microwave/microwave_source)
	explosion(microwave_source.loc, 0, 1, 2)

/obj/item/toy/plush/goatplushie
	name = "strange goat plushie"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	icon_state = "goat"
	desc = "Despite its cuddly appearance and plush nature, it will beat you up all the same. Goats never change."
	squeak_override = list('sound/items/weapons/punch1.ogg'=1)

/obj/item/toy/plush/tzi
	name = "wretched creature"
	desc = "A horrid flesh-thing with a still functioning brain. Perfect for working intricate meat contraptions!"
	icon = 'modular_darkpack/modules/toys/icons/toys.dmi'
	icon_state = "plushtzi"
	attack_verb_continuous = list("tortures", "scourges")
	attack_verb_simple = list("torture", "scourge")
	squeak_override = list('modular_darkpack/modules/toys/sounds/femurbreaker.ogg'=1)
