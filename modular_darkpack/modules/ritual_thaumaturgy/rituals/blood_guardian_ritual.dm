/obj/ritual_rune/thaumaturgy/blood_guardian
	name = "blood guardian"
	desc = "Creates the Blood Guardian to protect tremere or his domain."
	icon_state = "rune1"
	word = "UR'JOLA"
	level = 3

/obj/ritual_rune/thaumaturgy/blood_guardian/complete()
	var/mob/living/carbon/human/H = last_activator
	H.add_beastmaster_minion(/mob/living/basic/blood_guard)
	playsound(loc, 'modular_darkpack/modules/powers/sounds/thaum.ogg', 50, FALSE)
	if(length(H.beastmaster_minions) > 3+H.st_get_stat(STAT_LEADERSHIP))
		var/mob/living/basic/blood_guard/B = pick(H.beastmaster_minions)
		B.death()
	qdel(src)

