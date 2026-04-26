/datum/fish_source/ocean
	fish_table = list(
		FISHING_DUD = 10,
		/obj/effect/spawner/random/trash/garbage = 2,
		/obj/effect/spawner/message_in_a_bottle = 1,
		/obj/item/coin/gold = 3,
		/obj/item/fish/darkpack/tuna = 20,
		/obj/item/fish/darkpack/crab = 5,
		/obj/item/fish/darkpack/shark = 5,
		/obj/item/fish/darkpack/clownfish = 12,
		/obj/item/fish/darkpack/cardinalfish = 12,
		/obj/item/fish/darkpack/greenchromis = 11,
		/obj/item/fish/darkpack/pufferfish = 10,
		/obj/item/fish/darkpack/stingray = 10,
		/obj/item/fish/darkpack/squid = 10,
		/obj/item/fish/darkpack/plaice = 8,
		/obj/item/fish/darkpack/monkfish = 7,
		/obj/item/fish/darkpack/needlefish = 7,
		/obj/item/fish/darkpack/lanternfish = 7,
		/obj/item/fish/darkpack/chrab = 7,
		/obj/item/fish/darkpack/starfish = 6,
		/obj/item/fish/darkpack/donkfish = 6,
		/obj/item/fish/darkpack/armorfish = 4,
		/obj/item/fish/darkpack/bonemass = 4,
		/obj/item/fish/darkpack/emulsijack = 4,
		/obj/item/fish/darkpack/half_fish = 4,
		/obj/item/fish/darkpack/arctic_chrab = 4,
		/obj/item/fish/darkpack/dwarf_moonfish = 4,
		/obj/item/fish/darkpack/jumpercable = 3,
		/obj/item/fish/darkpack/tizira_moonfish = 3,
		/obj/item/fish/darkpack/holo_clownfish = 2,
		/obj/item/fish/darkpack/swordfish = 2,
		/obj/item/fish/darkpack/mastodon = 2,
		/obj/item/fish/darkpack/sacabambaspis = 1,
		/obj/structure/mystery_box/fishing = 1,
	)
	fish_counts = list(
		/obj/item/fish/darkpack/holo_clownfish = 2,
		/obj/item/fish/darkpack/swordfish = 3,
		/obj/item/fish/darkpack/mastodon = 2,
		/obj/item/fish/darkpack/sacabambaspis = 3,
		/obj/structure/mystery_box/fishing = 1,
	)
	fish_count_regen = list(
		/obj/item/fish/darkpack/holo_clownfish = 6 MINUTES,
		/obj/item/fish/darkpack/swordfish = 5 MINUTES,
		/obj/item/fish/darkpack/mastodon = 8 MINUTES,
		/obj/item/fish/darkpack/sacabambaspis = 4 MINUTES,
		/obj/structure/mystery_box/fishing = 32 MINUTES,
	)

// for things like the little fishing pond left of the tzi manor, or the water in the nossie haven
/datum/fish_source/river
	fish_table = list(
		FISHING_DUD = 4,
		/obj/effect/spawner/random/trash/garbage = 1,
		/obj/item/fish/darkpack/catfish = 20,
		/obj/item/fish/darkpack/guppy = 12,
		/obj/item/fish/darkpack/goldfish = 12,
		/obj/item/fish/darkpack/tadpole = 11,
		/obj/item/fish/darkpack/baby_carp = 11,
		/obj/item/fish/darkpack/fryish = 10,
		/obj/item/fish/darkpack/fritterish = 10,
		/obj/item/fish/darkpack/plastetra = 7,
		/obj/item/fish/darkpack/angelfish = 7,
		/obj/item/fish/darkpack/perch = 7,
		/obj/item/fish/darkpack/ratfish = 6,
		/obj/item/fish/darkpack/three_eyes = 5,
		/obj/item/fish/darkpack/zipzap = 5,
		/obj/item/fish/darkpack/sludgefish = 4,
		/obj/item/fish/darkpack/sludgefish_purple = 3,
		/obj/item/fish/darkpack/arctic_char = 3,
		/obj/item/fish/darkpack/sockeye = 3,
		/obj/item/fish/darkpack/pike = 2,
		/obj/item/fish/darkpack/armored_pike = 2,
		/obj/item/fish/darkpack/nessiefish = 1,
	)
	fish_counts = list(
		/obj/item/fish/darkpack/pike = 4,
		/obj/item/fish/darkpack/armored_pike = 3,
		/obj/item/fish/darkpack/nessiefish = 1,
	)
	fish_count_regen = list(
		/obj/item/fish/darkpack/pike = 4 MINUTES,
		/obj/item/fish/darkpack/armored_pike = 5 MINUTES,
		/obj/item/fish/darkpack/nessiefish = 10 MINUTES,
	)

/datum/fish_source/sand
	fish_table = list(
		FISHING_DUD = 15,
		/obj/effect/spawner/random/trash/garbage = 5,
		/obj/item/fish/darkpack/crab = 10,
		/obj/item/fish/darkpack/sand_surfer = 15,
		/obj/item/fish/darkpack/bumpy = 15,
	)
