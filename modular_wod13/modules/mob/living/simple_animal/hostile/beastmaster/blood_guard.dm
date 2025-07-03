/mob/living/simple_animal/hostile/beastmaster/blood_guard
	name = "blood guardian"
	desc = "A clot of blood in humanoid form."
	icon = 'icons/wod13/mobs.dmi'
	icon_state = "blood_guardian"
	icon_living = "blood_guardian"
	del_on_death = 1
	healable = 0
	mob_biotypes = MOB_SPIRIT
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("gnashes")
	speed = 0
	maxHealth = 150
	health = 150

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
	faction = list("Tremere")
	pressure_resistance = 200
	bloodpool = 1
	maxbloodpool = 1
