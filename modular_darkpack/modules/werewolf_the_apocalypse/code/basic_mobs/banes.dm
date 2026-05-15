/mob/living/basic/bane
	name = "creature"
	abstract_type = /mob/living/basic/bane

	mob_biotypes = MOB_SPIRIT
	basic_mob_flags = DEL_ON_DEATH

	maxHealth = 100
	health = 100
	combat_mode = TRUE
	obj_damage = 10
	melee_damage_lower = 20
	melee_damage_upper = 20

	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("gnashes")

	faction = list("hostile") // Could prob its own faction

	pressure_resistance = 200
	bloodpool = 0
	maxbloodpool = 0
	bloodquality = BLOOD_QUALITY_LOW

	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile_obstacles

/mob/living/basic/bane/suffocating
	icon_state = "suffocating_bane"
	icon = 'modular_darkpack/modules/werewolf_the_apocalypse/icons/basic/suffocating_bane.dmi'
