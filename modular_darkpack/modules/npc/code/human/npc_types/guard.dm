/mob/living/carbon/human/npc/guard
	staying = TRUE
	aggressive = TRUE
	max_stat = DEAD
	my_weapon_type = /obj/item/gun/ballistic/automatic/pistol/darkpack/m1911
	my_backup_weapon_type = /obj/item/melee/baton/vamp

/mob/living/carbon/human/npc/guard/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/guard)

/mob/living/carbon/human/npc/endronexecsecurity
	staying = TRUE
	fights_anyway = TRUE
	max_stat = 4
	my_weapon_type = /obj/item/gun/ballistic/automatic/pistol/darkpack/deagle
	my_backup_weapon_type = /obj/item/melee/baton/vamp

/mob/living/carbon/human/npc/endronexecsecurity/Initialize()
	. = ..()
	AssignSocialRole(/datum/socialrole/endronexecsecurity)

/mob/living/carbon/human/npc/endronlabsecurity
	staying = TRUE
	fights_anyway = TRUE
	max_stat = 4
	my_weapon_type = /obj/item/gun/ballistic/automatic/darkpack/mp5
	my_backup_weapon_type = /obj/item/melee/baton/vamp

/mob/living/carbon/human/npc/endronlabsecurity/Initialize()
	. = ..()
	AssignSocialRole(/datum/socialrole/endronlabsecurity)

/mob/living/carbon/human/npc/endronsecurity
	staying = TRUE
	fights_anyway = TRUE
	max_stat = 4
	my_weapon_type = /obj/item/gun/ballistic/automatic/darkpack/mp5
	my_backup_weapon_type = /obj/item/melee/baton/vamp

/mob/living/carbon/human/npc/endronsecurity/Initialize()
	. = ..()
	AssignSocialRole(/datum/socialrole/endronsecurity)
