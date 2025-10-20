
/mob/living/simple_animal/hostile/biter
	name = "biter"
	desc = "A ferocious, fang-bearing creature that resembles a spider."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "biter"
	icon_living = "biter"
	icon_dead = "biter_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/stack/human_flesh = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("gnashes")
	speed = -1
	maxHealth = 75
	health = 75

	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/items/weapons/bite.ogg'
	speak_emote = list("gnashes")

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list(VAMPIRE_CLAN_TZIMISCE)
	pressure_resistance = 200
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 2
	maxbloodpool = 2

/mob/living/simple_animal/hostile/biter/lasombra
	name = "shadow abomination"
	mob_biotypes = MOB_SPIRIT
	icon_state = "shadow"
	icon_living = "shadow"
	del_on_death = TRUE
	maxHealth = 100
	health = 100
	bloodpool = 0
	maxbloodpool = 0
	faction = list(VAMPIRE_CLAN_LASOMBRA)

/mob/living/simple_animal/hostile/biter/lasombra/better
	icon_state = "shadow2"
	icon_living = "shadow2"
	maxHealth = 200
	health = 200
	melee_damage_lower = 50
	melee_damage_upper = 50

/mob/living/simple_animal/hostile/fister
	name = "fister"
	desc = "True abomination walking on both hands."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "fister"
	icon_living = "fister"
	icon_dead = "fister_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	maxHealth = 125
	health = 125
	butcher_results = list(/obj/item/stack/human_flesh = 2)
	harm_intent_damage = 5
	melee_damage_lower = 30
	melee_damage_upper = 30
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	combat_mode = TRUE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	status_flags = CANPUSH
	faction = list(VAMPIRE_CLAN_TZIMISCE)
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 5
	maxbloodpool = 5

/mob/living/simple_animal/hostile/tanker
	name = "tanker"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "tanker"
	icon_living = "tanker"
	icon_dead = "tanker_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	maxHealth = 350
	health = 350
	butcher_results = list(/obj/item/stack/human_flesh = 4)
	harm_intent_damage = 5
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	faction = list(VAMPIRE_CLAN_TZIMISCE)
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 7
	maxbloodpool = 7

/mob/living/simple_animal/hostile/gangrel
	name = "Gangrel Form"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "gangrel_f"
	icon_living = "gangrel_f"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_HUGE
	speak_chance = 0
	speed = -0.4
	maxHealth = 400
	health = 400
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 40
	melee_damage_upper = 40
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	held_items = list(null, null)

/mob/living/simple_animal/hostile/gangrel/better
	maxHealth = 500
	health = 500
	melee_damage_lower = 45
	melee_damage_upper = 45
	speed = -0.6

/mob/living/simple_animal/hostile/gangrel/best
	icon_state = "gangrel_m"
	icon_living = "gangrel_m"
	maxHealth = 600
	health = 600
	melee_damage_lower = 55
	melee_damage_upper = 55
	speed = -0.8

/mob/living/simple_animal/hostile/gargoyle
	name = "Gargoyle"
	desc = "Stone-skinned..."
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "gargoyle_m"
	icon_living = "gargoyle_m"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_LARGE
	speak_chance = 0
	speed = -1
	maxHealth = 400
	health = 400
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 25
	melee_damage_upper = 45
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/items/weapons/punch1.ogg'
	combat_mode = TRUE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	held_items = list(null, null)
	faction = list(VAMPIRE_CLAN_TREMERE)

/mob/living/simple_animal/hostile/gargoyle/Initialize(mapload)
	. = ..()
	var/datum/action/gargoyle/G = new()
	G.Grant(src)

/datum/action/gargoyle
	name = "Turn into stone"
	desc = "Save some time till healing..."
	button_icon_state = "gargoyle"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/abuse_fix = 0

/datum/action/gargoyle/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(abuse_fix+100 > world.time)
		return
	abuse_fix = world.time
	var/mob/living/simple_animal/hostile/gargoyle/G = owner
	G.adjustBruteLoss(-300)
	G.adjustFireLoss(-300)
	G.Stun(50)
	G.petrify(50)

/mob/living/simple_animal/hostile/tzimisce_beast
	name = "Tzimisce Beast Form"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "weretzi"
	icon_living = "weretzi"
	pixel_w = -16
	pixel_z = -16
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mob_size = MOB_SIZE_HUGE
	speak_chance = 0
	speed = -0.55
	maxHealth = 575
	health = 575
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 35
	melee_damage_upper = 70
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
	dodging = TRUE

/mob/living/simple_animal/hostile/bloodcrawler
	name = "Tzimisce Blood Form"
	desc = "The peak of abominations. Unbelievably undamagable..."
	icon = 'modular_darkpack/modules/deprecated/icons/mobs.dmi'
	icon_state = "liquid"
	icon_living = "liquid"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	speed = 3
	maxHealth = 100
	health = 100
	butcher_results = list(/obj/item/stack/human_flesh = 1)
	harm_intent_damage = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/items/weapons/slash.ogg'
	combat_mode = TRUE
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 20
	maxbloodpool = 20

/mob/living/simple_animal/hostile/biter/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/simple_animal/hostile/fister/hostile
	faction = list(FACTION_HOSTILE)

/mob/living/simple_animal/hostile/tanker/hostile
	faction = list(FACTION_HOSTILE)
