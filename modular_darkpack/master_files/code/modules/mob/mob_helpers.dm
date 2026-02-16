/mob/Initialize(mapload)
	. = ..()
	if(has_emotion)
		AddComponent(/datum/component/aura)
