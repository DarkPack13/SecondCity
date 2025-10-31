// **************************************************************** BLOOD GUARDIAN *************************************************************

/obj/ritualrune/blood_guardian
	name = "Blood Guardian"
	desc = "Creates the Blood Guardian to protect tremere or his domain."
	icon_state = "rune1"
	word = "UR'JOLA"
	thaumlevel = 3

/obj/ritualrune/blood_guardian/complete()
	var/mob/living/carbon/human/H = last_activator
	H.add_beastmaster_minion(/mob/living/basic/blood_guard)
	playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 50, FALSE)
	if(length(H.beastmaster_minions) > 3+H.st_get_stat(STAT_LEADERSHIP))
		var/mob/living/basic/blood_guard/B = pick(H.beastmaster_minions)
		B.death()
	qdel(src)

/*
/mob/living/simple_animal/hostile/beastmaster/blood_guard
	name = "blood guardian"
	desc = "A clot of blood in humanoid form."
	icon = 'code/modules/wod13/mobs.dmi'
	icon_state = "blood_guardian"
	icon_living = "blood_guardian"
	del_on_death = 1
	mob_biotypes = MOB_SPIRIT
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("gnashes")
	speed = 0
	maxHealth = 110
	health = 110

	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	speak_emote = list("gnashes")

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(VAMPIRE_CLAN_TREMERE)
	bloodpool = 1
	maxbloodpool = 1
*/
