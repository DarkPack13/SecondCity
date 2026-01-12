/mob/living/basic/shadow_guard
	name = "heart of silence"
	desc = "A shadow given life, creature of fathomless..."
	icon = 'modular_darkpack/modules/npc/icons/shadow_guard.dmi'
	icon_state = "shadow2"
	icon_living = "shadow2"

	basic_mob_flags = DEL_ON_DEATH

	speed = 0
	maxHealth = 150
	health = 150

	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "gouges"
	attack_verb_simple = "gouge"
	attack_sound = 'sound/mobs/non-humanoids/venus_trap/venus_trap_hit.ogg'

	faction = list(VAMPIRE_CLAN_LASOMBRA)
	bloodpool = 1
	maxbloodpool = 1

	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon

/mob/living/basic/shadow_guard/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/ai_retaliate)

