/mob/living/carbon/human/npc/police
	aggressive = TRUE
	max_stat = DEAD
	my_backup_weapon_type = /obj/item/melee/baton/vamp

/mob/living/carbon/human/npc/police/Initialize(mapload)
	. = ..()

	AssignSocialRole(/datum/socialrole/police)

/mob/living/carbon/human/npc/police/Life()
	. = ..()

	if (stat >= SOFT_CRIT)
		return
	if (!prob(10))
		return

	INVOKE_ASYNC(src, PROC_REF(check_for_criminals))

/mob/living/carbon/human/npc/police/proc/check_for_criminals()
	for (var/mob/living/carbon/human/H in oviewers(4, src))
		if (!H.warrant)
			continue

		Aggro(H, FALSE)

/* DARKPACK TODO: create a police npc that just stands there
/mob/living/carbon/human/npc/police/static
	fights_anyway = TRUE
	staying = TRUE
	max_stat = 4
	my_backup_weapon_type = /obj/item/melee/classic_baton/vampire

/mob/living/carbon/human/npc/police/Initialize()
	. = ..()
	if(prob(66))
		set_body_model(FAT_BODY_MODEL)
	AssignSocialRole(/datum/socialrole/police)
*/
