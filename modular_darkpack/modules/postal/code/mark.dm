
/* LETTER MARK */
/obj/item/mark // Created after a targeted letter is unsealed
	name = "letter mark"
	desc = "Used to seal a letter."
	icon_state = "mark"
	icon = 'modular_darkpack/modules/postal/icons/postal.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/postal/icons/postal_onfloor.dmi')
	w_class = WEIGHT_CLASS_TINY

/obj/item/mark/Initialize(mapload) // look what we need to mimic a fraction of TG's whimsy
	. = ..()
	if(prob(0.1))
		desc = "Why did you make me do this? You’re fighting so that you can watch everyone around you die! Think Mark! \
			You’ll outlast every fragile insignificant being on this planet. You’ll live to see this world crumble to dust and blow away! \
			Everyone and everything you know will be gone! What will you have after 500 years?"
