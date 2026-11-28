/mob/living/carbon/human/npc/bandit
	my_backup_weapon_type = /obj/item/knife/vamp
	taint_wyrm = 1

/mob/living/carbon/human/npc/bandit/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/bandit)
