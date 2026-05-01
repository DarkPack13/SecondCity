/obj/item/vtm_artifact/daimonori
	true_name = "Daimonori"
	true_desc = "Increases thaumaturgy damage."
	icon_state = "daimonori"
	research_value = 20

/obj/item/vtm_artifact/daimonori/get_powers()
	. = ..()
	owner.thaum_damage_plus = 20

/obj/item/vtm_artifact/daimonori/remove_powers()
	. = ..()
	owner.thaum_damage_plus = 0
