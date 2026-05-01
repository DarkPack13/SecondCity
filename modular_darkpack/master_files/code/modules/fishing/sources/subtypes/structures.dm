/datum/fish_source/moisture_trap
	fish_table = list(
		FISHING_DUD = 20,
		/obj/effect/spawner/random/trash/garbage = 10,
		/obj/effect/spawner/random/maintenance = 1,
	)

/datum/fish_source/toilet
	catalog_description = "City toilets"
	fish_table = list(
		FISHING_DUD = 10,
		/obj/effect/spawner/random/trash/garbage = 10,
		/obj/effect/spawner/random/maintenance = 3,
		/obj/item/stack/dollar/rand = 2,
	)
	fish_counts = list(
		/obj/item/stack/dollar/rand = 2,
	)

/datum/fish_source/deepfryer
	fish_table = list(
		/obj/item/food/badrecipe = 15,
		/obj/item/food/nugget = 5,
	)
	fish_counts = list()
	fish_count_regen = list()
