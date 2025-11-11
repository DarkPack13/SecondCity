/mob/living/basic/blood_guard
	name = "blood guardian"
	desc = "A clot of blood in humanoid form."
	icon = 'modular_darkpack/modules/npc/icons/blood_guard.dmi'
	icon_state = "blood_guardian"
	icon_living = "blood_guardian"

	basic_mob_flags = DEL_ON_DEATH

	speed = 0
	maxHealth = 150
	health = 150

	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20

	bloodpool = 1
	maxbloodpool = 1

	faction = list(VAMPIRE_CLAN_TREMERE)
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon

/mob/living/basic/blood_guard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)
