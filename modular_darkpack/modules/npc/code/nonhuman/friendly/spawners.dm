/obj/effect/spawner/random/trash/rat
	name = "sewer rats"
	icon = 'modular_darkpack/modules/npc/icons/rat.dmi'
	icon_state = "random"
	spawn_loot_chance = 50
	spawn_loot_count = null
	loot = list(/mob/living/basic/mouse/vampire = 1)

/obj/effect/spawner/random/trash/rat/Initialize(mapload)
	if(isnull(spawn_loot_count))
		spawn_loot_count = rand(1, 3)

	if(HAS_TRAIT(SSstation, STATION_TRAIT_INFESTATION))
		spawn_loot_count = FLOOR(spawn_loot_count * 1.5, 1)
		spawn_loot_chance = FLOOR(spawn_loot_chance * 1.5, 1)

	else if(HAS_TRAIT(SSstation, STATION_TRAIT_PEST_CONTROL))
		spawn_loot_count = FLOOR(spawn_loot_count * 0.5, 1)
		spawn_loot_chance = FLOOR(spawn_loot_chance * 0.5, 1)
	. = ..()

/obj/effect/spawner/random/stray_animal
	name = "stray animal"
	icon = 'modular_darkpack/master_files/icons/mobs/simple/pets.dmi'
	icon_state = "random"
	spawn_loot_chance = 50
	loot = list(
		/mob/living/basic/pet/cat/darkpack = 9,
		/mob/living/basic/pet/dog/darkpack = 1,
		/mob/living/basic/corvid/crow = 1,
		/mob/living/basic/corvid/raven = 1,
		/mob/living/basic/mouse/vampire = 1
	)

/obj/effect/spawner/random/stray_animal/Initialize(mapload)
	if(HAS_TRAIT(SSstation, STATION_TRAIT_STRAY_MIGRATION))
		spawn_loot_chance = FLOOR(spawn_loot_chance * 2, 1)
	. = ..()
