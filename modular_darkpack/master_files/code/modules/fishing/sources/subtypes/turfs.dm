/datum/fish_source/ocean
	fish_table = list(
		FISHING_DUD = 10,
		/obj/item/fish/darkpack/stickleback = 20,
		/obj/item/fish/darkpack/anchovy = 15,
		/obj/item/fish/darkpack/tuna = 10,
		/obj/item/fish/darkpack/crab = 10,
		/obj/item/food/darkpack/horn_snail = 10,
		/obj/item/fish/darkpack/trout = 10,
		/obj/item/fish/darkpack/shark = 5,
		/obj/item/fish/darkpack/eagle_ray = 3,
		/obj/item/coin/gold = 3,
		/obj/effect/spawner/random/trash/garbage = 2,
		/obj/effect/spawner/message_in_a_bottle = 1,
		/obj/effect/spawner/random/occult/artifact = 1,
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
		/obj/item/fish/darkpack/stickleback = 20,
		/obj/item/fish/darkpack/crappie = 15,
		/obj/item/fish/darkpack/trout = 10,
		/obj/item/fish/darkpack/catfish = 5,
		/obj/item/food/darkpack/leech = 1,
		/obj/effect/spawner/random/trash/garbage = 1,
		/obj/effect/spawner/random/occult/artifact = 1,
	)
	fish_counts = list()
	fish_count_regen = list()

/datum/fish_source/sand
	fish_table = list(
		FISHING_DUD = 15,
		/obj/item/fish/darkpack/crab = 10,
		/obj/item/food/darkpack/horn_snail = 5,
		/obj/effect/spawner/random/trash/garbage = 5,
		/obj/effect/spawner/random/occult/artifact = 1,
	)

/datum/fish_source/sewer
	fish_table = list(
		FISHING_DUD = 5,
		/obj/effect/spawner/random/trash/garbage = 30,
		/obj/item/food/darkpack/leech = 10,
		/mob/living/basic/mouse/vampire = 5,
		/obj/item/fish/darkpack/stickleback = 5,
		/obj/item/fish/darkpack/crappie = 4,
		/obj/item/fish/darkpack/trout = 3,
		/obj/item/fish/darkpack/catfish = 2,
		/obj/item/coin/iron = 2,
		/obj/effect/spawner/random/occult/artifact = 1,
	)

/datum/fish_source/blood
	fish_table = list(
		FISHING_DUD = 10,
		/obj/item/food/darkpack/leech = 20,
		/obj/item/stack/sheet/bone = 10,
		/obj/item/clothing/head/vampire/skull = 5,
		/obj/item/storage/wallet/darkpack = 2,
		/mob/living/basic/szlachta = 1,
		/obj/effect/spawner/random/occult/artifact = 1,
	)
