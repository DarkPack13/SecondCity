/obj/item/vtm_artifact/bloodstar
	true_name = "Bloodstar"
	true_desc = "Increases Bloodpower duration."
	icon_state = "bloodstar"
	research_value = 10

/obj/item/vtm_artifact/bloodstar/get_powers()
	. = ..()
	owner.bloodpower_time_plus = 50

/obj/item/vtm_artifact/bloodstar/remove_powers()
	. = ..()
	owner.bloodpower_time_plus = 0
