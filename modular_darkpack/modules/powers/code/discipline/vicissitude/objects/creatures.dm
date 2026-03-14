/mob/living/basic/szlachta
	name = "biter"
	desc = "A ferocious, fang-bearing creature that resembles a spider."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "biter"
	icon_living = "biter"
	icon_dead = "biter_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	butcher_results = list(/obj/item/stack/sheet/meat = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	speed = -1
	maxHealth = 75
	health = 75
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("gnashes")
	faction = list(VAMPIRE_CLAN_TZIMISCE)
	pressure_resistance = 200
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 2
	maxbloodpool = 2
	ai_controller = /datum/ai_controller/basic_controller/simple/simple_hostile_obstacles
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 2)

/mob/living/basic/szlachta/fister
	name = "fister"
	desc = "A true abomination walking on both hands."
	icon_state = "fister"
	icon_living = "fister"
	icon_dead = "fister_dead"
	maxHealth = 125
	health = 125
	butcher_results = list(/obj/item/stack/sheet/meat = 2)
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	combat_mode = TRUE
	status_flags = CANPUSH
	bloodpool = 5
	maxbloodpool = 5
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 5)

/mob/living/basic/szlachta/tanker
	name = "tanker"
	desc = "The peak of abominable armor. Unbelievably undamagable..."
	icon_state = "tanker"
	icon_living = "tanker"
	icon_dead = "tanker_dead"
	maxHealth = 350
	health = 350
	butcher_results = list(/obj/item/stack/sheet/meat = 4)
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	bloodpool = 7
	maxbloodpool = 7
	custom_materials = list(/datum/material/meat = SHEET_MATERIAL_AMOUNT * 10)

/mob/living/basic/szlachta/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/szlachta/fister/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/szlachta/tanker/hostile
	faction = list(FACTION_HOSTILE)
