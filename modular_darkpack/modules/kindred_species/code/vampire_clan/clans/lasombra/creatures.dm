/mob/living/basic/biter/lasombra
	name = "shadow abomination"
	mob_biotypes = MOB_SPIRIT
	icon_state = "shadow"
	icon_living = "shadow"
	basic_mob_flags = DEL_ON_DEATH
	maxHealth = 100
	health = 100
	bloodpool = 0
	maxbloodpool = 0
	faction = list(VAMPIRE_CLAN_LASOMBRA)

/mob/living/basic/biter/lasombra/better
	icon_state = "shadow2"
	icon_living = "shadow2"
	maxHealth = 200
	health = 200
	melee_damage_lower = 50
	melee_damage_upper = 50
