/obj/item/occult_artifact/vampire/fae_charm
	true_name = "Fae Charm"
	true_desc = "Dexterity boost."
	icon_state = "fae_charm"
	research_value = 35

/obj/item/occult_artifact/vampire/fae_charm/grant_powers()
	. = ..()
	owner.st_add_stat_mod(STAT_DEXTERITY, 1, type)

/obj/item/occult_artifact/vampire/fae_charm/ungrant_powers()
	. = ..()
	owner.st_remove_stat_mod(STAT_DEXTERITY, 1, type)
