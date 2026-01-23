/datum/armor/weekapaug_thistle
	melee = 10
	bullet = 10

/obj/item/vtm_artifact/weekapaug_thistle
	true_name = "Weekapaug Thistle"
	true_desc = "Increases combat defense."
	icon_state = "w_thistle"
	research_value = 10

/obj/item/vtm_artifact/weekapaug_thistle/get_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.physiology.armor = H.physiology.armor.add_other_armor(/datum/armor/weekapaug_thistle)

/obj/item/vtm_artifact/weekapaug_thistle/remove_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.physiology.armor = H.physiology.armor.subtract_other_armor(/datum/armor/weekapaug_thistle)

/obj/item/vtm_artifact/tarulfang
	true_name = "Tarulfang"
	true_desc = "Decreases chance of frenzy."
	icon_state = "tarulfang"

/obj/item/vtm_artifact/weekapaug_thistle/get_powers()
	. = ..()
	owner.frenzy_chance_boost = 5

/obj/item/vtm_artifact/weekapaug_thistle/remove_powers()
	. = ..()
	owner.frenzy_chance_boost = 10
