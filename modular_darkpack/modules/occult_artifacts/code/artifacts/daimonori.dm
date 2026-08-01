/obj/item/occult_artifact/vampire/daimonori
	true_name = "Daimonori"
	true_desc = "Increases thaumaturgy damage."
	icon_state = "daimonori"
	research_value = 20

/obj/item/occult_artifact/vampire/daimonori/grant_powers()
	. = ..()
	owner.thaum_damage_plus = 20

/obj/item/occult_artifact/vampire/daimonori/ungrant_powers()
	. = ..()
	owner.thaum_damage_plus = 0
