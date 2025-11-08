// inspired* by Fallout NV's Wild Wasteland Trait
/datum/station_trait/wild_masquerade
	name = "Wild Masquerade"
	weight = 1
	trait_to_give = STATION_TRAIT_WILD_MASQUERADE
	darkpack_allowed = TRUE

/datum/station_trait/filled_trash
	name = "Trash Man Strike"
	//trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	//show_in_report = TRUE
	//report_message = "Our workers accidentally forgot more of their personal belongings in the maintenace areas."
	blacklist = list(/datum/station_trait/empty_trash)
	trait_to_give = STATION_TRAIT_FILLED_MAINT

	// This station trait is checked when loot drops initialize, so it's too late
	can_revert = FALSE
	darkpack_allowed = TRUE

/datum/station_trait/empty_trash
	name = "Trash Day"
	//trait_type = STATION_TRAIT_NEGATIVE
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	//show_in_report = TRUE
	//report_message = "Our workers cleaned out most of the junk in the maintenace areas."
	blacklist = list(/datum/station_trait/filled_trash)
	trait_to_give = STATION_TRAIT_EMPTY_MAINT

	// This station trait is checked when loot drops initialize, so it's too late
	can_revert = FALSE
	darkpack_allowed = TRUE

/datum/station_trait/infestation
	name = "Rat Infestation"
	//trait_type = STATION_TRAIT_POSITIVE
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	//show_in_report = TRUE
	//report_message = "Our workers accidentally forgot more of their personal belongings in the maintenace areas."
	blacklist = list(/datum/station_trait/pest_control)
	trait_to_give = STATION_TRAIT_INFESTATION

	#warn consider
	can_revert = FALSE
	darkpack_allowed = TRUE

/datum/station_trait/pest_control
	name = "Pest Control"
	//trait_type = STATION_TRAIT_NEGATIVE
	weight = 5
	cost = STATION_TRAIT_COST_MINIMAL
	//show_in_report = TRUE
	//report_message = "Our workers cleaned out most of the junk in the maintenace areas."
	blacklist = list(/datum/station_trait/infestation)
	trait_to_give = STATION_TRAIT_PEST_CONTROL

	#warn consider
	can_revert = FALSE
	darkpack_allowed = TRUE


/obj/effect/spawner/random/trash/rat
	name = "sewer rats"
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
