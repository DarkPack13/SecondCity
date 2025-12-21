/mob/living/carbon/human/npc
	faction = list(FACTION_NPC)
	ai_controller = /datum/ai_controller/npc
	move_intent = MOVE_INTENT_WALK
	var/outfit_type = /datum/outfit/npc

/mob/living/carbon/human/npc/Initialize(mapload)
	. = ..()
	equipOutfit(outfit_type)

/mob/living/carbon/human/npc/bandit
	outfit_type = /datum/outfit/npc/bandit

/mob/living/carbon/human/npc/rich
	outfit_type = /datum/outfit/npc/rich

/mob/living/carbon/human/npc/average
	outfit_type = /datum/outfit/npc/average

/mob/living/carbon/human/npc/poor
	outfit_type = /datum/outfit/npc/poor

/mob/living/carbon/human/npc/shop
	ai_controller = /datum/ai_controller/npc/stand_still
	outfit_type = /datum/outfit/npc/shop

/mob/living/carbon/human/npc/police
	outfit_type = /datum/outfit/npc/police

/mob/living/carbon/human/npc/police/standing
	ai_controller = /datum/ai_controller/npc/stand_still
	outfit_type = /datum/outfit/npc/police
