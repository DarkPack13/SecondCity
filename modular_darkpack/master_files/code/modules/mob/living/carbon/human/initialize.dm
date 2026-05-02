/mob/living/carbon/human/Initialize(mapload)
	. = ..()

	//Initializes Jumping on the player
	AddComponent(/datum/component/jumper)
	AddComponent(/datum/component/violation_observer, violation_aoe)
	if(CONFIG_GET(flag/swing_combat))
		AddElement(/datum/element/swing_attack)
	else if(CONFIG_GET(flag/directional_combat))
		AddElement(/datum/element/directional_attack)
	update_visible_name()
