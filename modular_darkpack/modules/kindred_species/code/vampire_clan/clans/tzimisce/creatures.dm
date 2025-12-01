
/mob/living/basic/biter
	name = "biter"
	desc = "A ferocious, fang-bearing creature that resembles a spider."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "biter"
	icon_living = "biter"
	icon_dead = "biter_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	butcher_results = list(/obj/item/stack/human_flesh = 1)
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

/mob/living/basic/fister
	name = "fister"
	desc = "True abomination walking on both hands."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "fister"
	icon_living = "fister"
	icon_dead = "fister_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	maxHealth = 125
	health = 125
	butcher_results = list(/obj/item/stack/human_flesh = 2)
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	combat_mode = TRUE
	status_flags = CANPUSH
	faction = list(VAMPIRE_CLAN_TZIMISCE)
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 5
	maxbloodpool = 5

/mob/living/basic/tanker
	name = "tanker"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "tanker"
	icon_living = "tanker"
	icon_dead = "tanker_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	maxHealth = 350
	health = 350
	butcher_results = list(/obj/item/stack/human_flesh = 4)
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	faction = list(VAMPIRE_CLAN_TZIMISCE)
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 7
	maxbloodpool = 7

/mob/living/basic/tzimisce_beast
	name = "tzimisce beast form"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "weretzi"
	icon_living = "weretzi"
	pixel_w = -16
	pixel_z = -16
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_HUGE
	speed = -0.55
	maxHealth = 575
	health = 575
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	melee_damage_lower = 35
	melee_damage_upper = 70
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	bloodpool = 10
	maxbloodpool = 10

/mob/living/basic/bloodcrawler
	name = "tzimisce blood form"
	desc = "The peak of abominations. Unbelievably undamagable..."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "liquid"
	icon_living = "liquid"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speed = 3
	butcher_results = list(/obj/item/stack/human_flesh = 1)
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	bloodpool = 20
	maxbloodpool = 20

/mob/living/basic/biter/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/fister/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/tanker/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/basic/bloodcrawler
	var/collected_blood = 0

/mob/living/basic/bloodcrawler/Move(NewLoc, direct)
	. = ..()
	var/obj/structure/vampdoor/V = locate() in NewLoc
	if(V?.lockpick_difficulty <= 10)
		forceMove(get_turf(V))
	for(var/obj/effect/decal/cleanable/blood/B in range(1, NewLoc))
		if(B.bloodiness)
			collected_blood = collected_blood+1
			to_chat(src, span_info("You sense blood entering your mass..."))
			var/turf/T = get_turf(B)
			T?.wash(CLEAN_SCRUB)
