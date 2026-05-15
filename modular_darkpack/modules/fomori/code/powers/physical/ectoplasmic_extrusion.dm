/datum/bodypart_overlay/simple/ectoplasmic_extrusion
	icon_state = "ectoplasmic_extrusion"
	icon = 'modular_darkpack/modules/fomori/icons/fomori_sprite_accessories.dmi'
	layers = LOW_FACEMASK_LAYER

/datum/action/cooldown/power/fomori_power/weapon/ectoplasmic_extrusion
	name = "Ectoplasmic Extrusion"
	desc = "(UNIMPLEMENTED) Sprout grotesque tendrils from your back to use as extra hands or as a weapon."
	button_icon_state = "ectoplasmic_extrusion"
	rank = 1 // of 1

//	weapon_type = /obj/item/melee/ectoplasmic_extrusion
	sheathe_text = "Your ectoplasmic tendrils retract into your body."

	fomor_part = /datum/bodypart_overlay/simple/ectoplasmic_extrusion
	feature_bodypart = BODY_ZONE_CHEST

/datum/action/cooldown/power/fomori_power/horns/Activate(atom/target)
	. = ..()
	toggle_feature(deployed)

	if(deployed)
		deployed = FALSE
	else
		deployed = TRUE
		SEND_SIGNAL(owner, COMSIG_MASQUERADE_VIOLATION)

#warn ECTOPLASMIC EXTRUSION UNFINISHED
