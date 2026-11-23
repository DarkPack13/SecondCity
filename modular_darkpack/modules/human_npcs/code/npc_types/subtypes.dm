/mob/living/carbon/human/npc/bandit
	ai_controller = /datum/ai_controller/npc/bandit
	socialrole_type = /datum/socialrole/bandit

/mob/living/carbon/human/npc/bandit/Initialize(mapload)
	. = ..()
	st_set_stat(STAT_FIREARMS, rand(1, 2))


/mob/living/carbon/human/npc/rich
	bloodquality = BLOOD_QUALITY_HIGH

/mob/living/carbon/human/npc/rich/get_socialrole_type()
	. = ..()
	if(.)
		return . // Here so vars edits or subtypes can override default pick.
	return pick(/datum/socialrole/richmale, /datum/socialrole/richfemale)


/mob/living/carbon/human/npc/average

/mob/living/carbon/human/npc/average/get_socialrole_type()
	. = ..()
	if(.)
		return .
	return pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale)

/mob/living/carbon/human/npc/average/standing
	ai_controller = /datum/ai_controller/npc/stand_still

/mob/living/carbon/human/npc/average/standing/incel
	socialrole_type = /datum/socialrole/usualmale

/mob/living/carbon/human/npc/average/club
	ai_controller = /datum/ai_controller/npc/stand_still/club


/mob/living/carbon/human/npc/poor
	bloodquality = BLOOD_QUALITY_LOW

/mob/living/carbon/human/npc/poor/Initialize(mapload)
	. = ..()
	ai_controller?.set_blackboard_key(BB_HUMAN_ATTRIBUTE_ENERGY, 5)

/mob/living/carbon/human/npc/poor/get_socialrole_type()
	. = ..()
	if(.)
		return .
	return pick(/datum/socialrole/poormale, /datum/socialrole/poorfemale)

/mob/living/carbon/human/npc/police
	ai_controller = /datum/ai_controller/npc/police
	socialrole_type = /datum/socialrole/police

/mob/living/carbon/human/npc/police/Initialize(mapload)
	. = ..()
	st_set_stat(STAT_FIREARMS, rand(1, 3))

#warn cleanup
/mob/living/carbon/human/npc/police/Life()
	. = ..()

	if (IS_UNCONSCIOUS_OR_CRIT(src))
		return
	if (!prob(10))
		return

	INVOKE_ASYNC(src, PROC_REF(check_for_criminals))

/mob/living/carbon/human/npc/police/proc/check_for_criminals()
	for (var/mob/living/carbon/human/H in oviewers(4, src))
		if (!H.warrant)
			continue

		#warn crime
		// aggro_npc(H, FALSE)

/mob/living/carbon/human/npc/police/standing
	ai_controller = /datum/ai_controller/npc/stand_still


/mob/living/carbon/human/npc/guard
	ai_controller = /datum/ai_controller/npc/stand_still
	socialrole_type = /datum/socialrole/guard

/mob/living/carbon/human/npc/guard/Initialize(mapload)
	. = ..()
	st_set_stat(STAT_FIREARMS, rand(1, 2))
