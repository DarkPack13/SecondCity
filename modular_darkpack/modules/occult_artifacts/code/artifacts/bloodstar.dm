/obj/item/vtm_artifact/bloodstar
	true_name = "Bloodstar"
	true_desc = "Increases Bloodpower efficiency."
	icon_state = "bloodstar"
	research_value = 10

/obj/item/vtm_artifact/bloodstar/get_powers()
	. = ..()
	owner.blood_efficiency = 0.8

/obj/item/vtm_artifact/bloodstar/remove_powers()
	. = ..()
	owner.blood_efficiency = 1
