/obj/item/vtm_artifact/heart_of_eliza
	true_name = "Heart of Eliza"
	true_desc = "Melee damage boost."
	icon_state = "h_eliza"
	research_value = 30

/obj/item/vtm_artifact/heart_of_eliza/get_powers()
	. = ..()
	owner.st_add_stat_mod(STAT_STRENGTH, 1, type)

/obj/item/vtm_artifact/heart_of_eliza/remove_powers()
	. = ..()
	owner.st_remove_stat_mod(STAT_STRENGTH, 1, type)
