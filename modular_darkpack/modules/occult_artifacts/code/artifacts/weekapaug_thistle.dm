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
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return
	human_owner.physiology.armor = human_owner.physiology.armor.add_other_armor(/datum/armor/weekapaug_thistle)

/obj/item/occult_artifact/vampire/weekapaug_thistle/ungrant_powers()
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(owner)
	if(!human_owner)
		return
	human_owner.physiology.armor = human_owner.physiology.armor.subtract_other_armor(/datum/armor/weekapaug_thistle)
