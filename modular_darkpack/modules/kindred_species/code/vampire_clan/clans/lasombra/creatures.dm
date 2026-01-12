/mob/living/basic/lasombra
	name = "shadow abomination"
	desc = "A ferocious, fang-bearing creature that resembles a spider."
	icon = 'modular_darkpack/modules/npc/icons/shadow_guard.dmi'
	icon_state = "shadow"
	icon_living = "shadow"
	mob_biotypes = MOB_SPIRIT
	basic_mob_flags = DEL_ON_DEATH
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = -1
	maxHealth = 100
	health = 100
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("gnashes")
	faction = list(VAMPIRE_CLAN_LASOMBRA)
	pressure_resistance = 200
	bloodpool = 0
	maxbloodpool = 0
	bloodquality = BLOOD_QUALITY_LOW

/mob/living/basic/lasombra/better
	icon_state = "shadow2"
	icon_living = "shadow2"
	maxHealth = 200
	health = 200
	melee_damage_lower = 50
	melee_damage_upper = 50

/mob/living/basic/lasombra/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/lasombra/better/hostile
	faction = list(FACTION_HOSTILE)
