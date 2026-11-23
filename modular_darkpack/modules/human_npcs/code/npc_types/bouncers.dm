/mob/living/carbon/human/npc/bouncer
	abstract_type = /mob/living/carbon/human/npc/bouncer
	ai_controller = /datum/ai_controller/npc/stand_still

/mob/living/carbon/human/npc/bouncer/Initialize(mapload)
	. = ..()
	st_set_stat(STAT_FIREARMS, rand(1, 3))


/mob/living/carbon/human/npc/bouncer/endron

/mob/living/carbon/human/npc/bouncer/endron/get_socialrole_type()
	assign_socialrole(/datum/socialrole/endronsecurity)
