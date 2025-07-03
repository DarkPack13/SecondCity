/mob/living/carbon/human/npc/bandit
	max_stat = HARD_CRIT
	// TODO: [Lucia] reimplement weapons
	/*
	my_backup_weapon_type = /obj/item/melee/vampirearms/knife
	*/

/mob/living/carbon/human/npc/bandit/Initialize(mapload)
	. = ..()

	if (prob(50))
		set_body_weight(FAT_BODY_WEIGHT)

	AssignSocialRole(/datum/socialrole/bandit)
