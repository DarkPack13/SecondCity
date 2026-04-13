/obj/item/vtm_artifact/fae_charm
	true_name = "Fae Charm"
	true_desc = "Dexterity boost."
	icon_state = "fae_charm"
	research_value = 35

/obj/item/vtm_artifact/fae_charm/bind(mob/user)
	. = ..()
	owner.st_add_stat_mod(STAT_DEXTERITY, 1, type)

/obj/item/vtm_artifact/fae_charm/unbind(mob/user)
	. = ..()
	owner.st_remove_stat_mod(STAT_DEXTERITY, 1, type)

/datum/movespeed_modifier/fae_charm
	multiplicative_slowdown = -0.20
