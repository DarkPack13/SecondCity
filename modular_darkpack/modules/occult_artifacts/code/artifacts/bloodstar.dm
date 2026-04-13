/obj/item/occult_artifact/vampire/bloodstar
	true_name = "Bloodstar"
	true_desc = "Increases Bloodpower efficiency."
	icon_state = "bloodstar"
	research_value = 10

/obj/item/occult_artifact/vampire/bloodstar/grant_powers()
	. = ..()
	owner.blood_efficiency = 0.8

/obj/item/occult_artifact/vampire/bloodstar/ungrant_powers()
	. = ..()
	owner.blood_efficiency = 1
