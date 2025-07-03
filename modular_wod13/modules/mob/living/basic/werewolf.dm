/mob/living/basic/werewolf
	name = "Werewolf"
	desc = "AUF."
	icon_state = "werewolf"
	icon_living = "werewolf"
	icon_dead = "werewolf_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speed = -1
	maxHealth = 1000
	health = 1000
	butcher_results = list(/obj/item/stack/human_flesh = 20)
	melee_damage_lower = 50
	melee_damage_upper = 50
	attack_verb_continuous = "slashes"
	combat_mode = TRUE
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	bloodpool = 10
	maxbloodpool = 10
	pixel_w = -8
