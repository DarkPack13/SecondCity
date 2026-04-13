/obj/item/vtm_artifact/daimonori
	true_name = "Daimonori"
	true_desc = "Increases thaumaturgy damage."
	icon_state = "daimonori"
	research_value = 20

/obj/item/vtm_artifact/daimonori/bind(mob/user)
	. = ..()
	owner.thaum_damage_plus = 20

/obj/item/vtm_artifact/daimonori/unbind(mob/user)
	. = ..()
	owner.thaum_damage_plus = 0
