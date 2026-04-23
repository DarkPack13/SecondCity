/datum/armor/weekapaug_thistle
	melee = 10
	bullet = 10

/obj/item/occult_artifact/vampire/weekapaug_thistle
	true_name = "Weekapaug Thistle"
	true_desc = "Increases combat defense."
	icon_state = "w_thistle"
	research_value = 10

/obj/item/occult_artifact/vampire/weekapaug_thistle/grant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.physiology.armor = H.physiology.armor.add_other_armor(/datum/armor/weekapaug_thistle)

/obj/item/occult_artifact/vampire/weekapaug_thistle/ungrant_powers()
	. = ..()
	var/mob/living/carbon/human/H = owner
	H.physiology.armor = H.physiology.armor.subtract_other_armor(/datum/armor/weekapaug_thistle)
