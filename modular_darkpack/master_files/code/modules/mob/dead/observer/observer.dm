/mob/dead/observer
	var/soul_taken = FALSE //prevents necromancers from farming souls off one singular ghost

/mob/dead/observer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/aura)
