/obj/item/argemia
	name = "strange plushie"
	desc = "Voiding..."
	icon_state = "argemia"
	icon = 'modular_darkpack/modules/depreciated/icons/items.dmi'
	onflooricon = 'modular_darkpack/modules/depreciated/icons/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/argemia/microwave_act(obj/machinery/microwave/M)
	playsound(M.loc, 'modular_darkpack/modules/depreciated/sound/aeaeae.ogg', 100, FALSE)
	spawn(50)
		explosion(M.loc, 0, 1, 2)
