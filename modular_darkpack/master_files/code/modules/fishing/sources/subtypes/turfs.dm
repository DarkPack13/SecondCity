/datum/fish_source/ocean
	fish_table = list(
		FISHING_DUD = 10,
		/obj/effect/spawner/random/trash/garbage = 2,
		/obj/effect/spawner/message_in_a_bottle = 1,
		/obj/item/coin/gold = 3,
		/obj/item/fish/darkpack/tuna = 20,
		/obj/item/fish/darkpack/crab = 5,
		/obj/item/fish/darkpack/shark = 5,
	)
	fish_counts = list(
		///obj/structure/mystery_box/fishing = 1,
	)
	fish_count_regen = list(
		///obj/structure/mystery_box/fishing = 32 MINUTES,
	)

/datum/fish_source/river
	fish_table = list(
		FISHING_DUD = 4,
		/obj/effect/spawner/random/trash/garbage = 1,
		/obj/item/fish/darkpack/catfish = 20,
	)
	fish_counts = list()
	fish_count_regen = list()

/datum/fish_source/sand
	fish_table = list(
		FISHING_DUD = 15,
		/obj/effect/spawner/random/trash/garbage = 5,
		/obj/item/fish/darkpack/crab = 10,
	)
