
/obj/item/fishing_rod
	w_class = WEIGHT_CLASS_NORMAL // so they can fit in backpacks

/datum/fish_source/on_challenge_completed(mob/user, datum/fishing_challenge/challenge, success)
	SHOULD_CALL_PARENT(FALSE)
	UnregisterSignal(user, COMSIG_MOB_COMPLETE_FISHING)
	if(!success)
		return
	var/atom/movable/reward = dispense_reward(challenge.reward_path, user, challenge.location, challenge.used_rod)
	SEND_SIGNAL(challenge.used_rod, COMSIG_FISHING_ROD_CAUGHT_FISH, reward, user)
	challenge.used_rod.on_reward_caught(reward, user)
	if(reward) // this override is to fix this bug. upstream doesnt guard remove_trait incase reward is null lol
		user.add_mob_memory(/datum/memory/caught_fish, protagonist = user, deuteragonist = reward.name)
		REMOVE_TRAIT(reward, TRAIT_FISH_JUST_SPAWNED, TRAIT_GENERIC)

// much needed overrides for the base /tg/ fishing rewards
/obj/structure/mystery_box/fishing/generate_valid_types()
	var/list/mystery_types = list(
	/obj/item/storage/toolbox/fishing/master,
	/obj/item/storage/box/fish_revival_kit,
	/obj/item/fishing_rod/telescopic/master,
	/obj/item/bait_can/super_baits,
	/obj/item/storage/fish_case/tiziran,
	/obj/item/storage/fish_case/syndicate,
	/obj/item/gun/ballistic/rifle/boltaction/surplus,
	/obj/item/food/canned/squid_ink,
	/obj/item/reagent_containers/cup/glass/bottle/rum/aged,
	/obj/item/stack/dollar/thousand,
	/obj/item/language_manual/piratespeak,
	/obj/item/clothing/head/costume/pirate/armored,
	/obj/item/clothing/suit/costume/pirate/armored,
)
	valid_types = mystery_types

/obj/item/coin/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 100, "coin_value", FALSE)

// replaces the /tg/ fishing minigame with a skill check.
// difficulty 5 is easiest, 1 is hardest. difficulty determines how big the success zone is on the skillcheck
/datum/fishing_challenge/start_minigame_phase(auto_reel = FALSE)
	SEND_SIGNAL(user, COMSIG_MOB_BEGIN_FISHING_MINIGAME, src)
	if(!get_difficulty()) // difficulty <= 0: instant win, already handled
		return
	if(auto_reel)
		on_skillcheck_result(user, TRUE)
		return
	var/sc_diff = clamp(round(5 - difficulty * 0.04), 1, 5)
	var/datum/skillcheck/sc = new()
	INVOKE_ASYNC(sc, TYPE_PROC_REF(/datum/skillcheck, start), user, sc_diff, CALLBACK(src, PROC_REF(on_skillcheck_result)))

/datum/fishing_challenge/proc/on_skillcheck_result(mob/living/cb_user, passed)
	complete(passed)

/obj/structure/closet/crate/cooler
	name = "cooler"
	desc = "An insulated cooler full of ice. Great for keeping fish fresh."
	icon = 'icons/obj/storage/crates.dmi'
	base_icon_state = "food"

/obj/structure/closet/crate/cooler/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/fish_safe_storage)

/obj/item/cooler_kit
	name = "cooler kit"
	desc = "A cooler crafting kit, complete with ice! Fish and beer not included."
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "food"
	w_class = WEIGHT_CLASS_BULKY

/datum/crafting_recipe/cooler_kit
	name = "Cooler Construction Kit"
	result = /obj/structure/closet/crate/cooler
	reqs = list(
		/obj/item/cooler_kit = 1
	)
	time = 10 SECONDS
	category = CAT_MISC
	crafting_flags = CRAFT_SKIP_MATERIALS_PARITY

/datum/supply_pack/local/cooler_kit
	name = "Cooler kit"
	desc = "A cooler crafting kit, complete with an ice! Fish and beer not included."
	cost = 100
	contains = list(/obj/item/cooler_kit)

// fish definitions
/obj/item/fish/darkpack
	var/fish_price = 1

/obj/item/fish/darkpack/Initialize(mapload)
	. = ..()
	fish_price = round(average_weight / 50) + rand(1, 50) // mostly determined by average weight, with an RNG component. still multiplies with charisma at point of sale

/obj/item/fish/darkpack/shark
	name = "leopard shark"
	icon_state = "shark"
	icon = 'modular_darkpack/modules/fishing/icons/fish48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fishing/icons/fish_onfloor.dmi')
	base_pixel_w = -16
	pixel_w = -16
	fish_id = "darkpack_shark"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	average_size = 60
	average_weight = 1400
	stable_population = 4
	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#33302e"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/shark/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/tuna
	name = "bluefin tuna"
	icon = 'modular_darkpack/modules/fishing/icons/fish.dmi'
	icon_state = "fish"
	fish_id = "darkpack_tuna"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	num_fillets = 2

	stable_population = 9
	average_size = 50
	average_weight = 600

	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#33302e"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/tuna/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/catfish
	name = "channel catfish"
	icon = 'modular_darkpack/modules/fishing/icons/fish.dmi'
	icon_state = "catfish"
	fish_id = "darkpack_catfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER

	stable_population = 9
	average_size = 55
	average_weight = 800

	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#33302e"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/catfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/crab
	name = "dungeness crab"
	icon = 'modular_darkpack/modules/fishing/icons/fish.dmi'
	icon_state = "crab"
	fillet_type = /obj/item/food/meat/slab/rawcrab
	fish_id = "darkpack_crab"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER

	stable_population = 8
	average_size = 50
	average_weight = 600

	dedicated_in_aquarium_icon_state = "crab_small"
	sprite_height = 6
	sprite_width = 10

/obj/item/fish/darkpack/crab/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/guppy
	name = "guppy"
	icon_state = "guppy"
	fish_id = "darkpack_guppy"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 15
	average_size = 5
	average_weight = 40
	dedicated_in_aquarium_icon_state = "guppy_small"
	aquarium_vc_color = "#d97f4e"
	sprite_width = 8
	sprite_height = 5
	required_temperature_min = MIN_AQUARIUM_TEMP+20
	required_temperature_max = MIN_AQUARIUM_TEMP+28

/obj/item/fish/darkpack/guppy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/greenchromis
	name = "green chromis"
	icon_state = "greenchromis"
	fish_id = "darkpack_greenchromis"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 12
	average_size = 8
	average_weight = 60
	dedicated_in_aquarium_icon_state = "greenchromis_small"
	aquarium_vc_color = "#4ca843"
	sprite_width = 5
	sprite_height = 3
	required_temperature_min = MIN_AQUARIUM_TEMP+23
	required_temperature_max = MIN_AQUARIUM_TEMP+28

/obj/item/fish/darkpack/greenchromis/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/cardinalfish
	name = "cardinal fish"
	icon_state = "cardinalfish"
	fish_id = "darkpack_cardinalfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 12
	average_size = 8
	average_weight = 70
	dedicated_in_aquarium_icon_state = "cardinalfish_small"
	aquarium_vc_color = "#d4312c"
	sprite_width = 6
	sprite_height = 3
	fish_traits = list(/datum/fish_trait/vegan)
	required_temperature_min = MIN_AQUARIUM_TEMP+22
	required_temperature_max = MIN_AQUARIUM_TEMP+30

/obj/item/fish/darkpack/cardinalfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/plastetra
	name = "plastetra"
	icon_state = "plastetra"
	fish_id = "darkpack_plastetra"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 13
	average_size = 5
	average_weight = 45
	dedicated_in_aquarium_icon_state = "plastetra_small"
	sprite_width = 4
	sprite_height = 2
	required_temperature_min = MIN_AQUARIUM_TEMP+20
	required_temperature_max = MIN_AQUARIUM_TEMP+28
	aquarium_vc_color = "#4287f5"

/obj/item/fish/darkpack/plastetra/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/angelfish
	name = "angelfish"
	icon_state = "angelfish"
	fish_id = "darkpack_angelfish"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 10
	average_size = 15
	average_weight = 150
	dedicated_in_aquarium_icon_state = "angelfish_small"
	aquarium_vc_color = "#c8a832"
	sprite_width = 4
	sprite_height = 7

/obj/item/fish/darkpack/angelfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/clownfish
	name = "clownfish"
	icon_state = "clownfish"
	fish_id = "darkpack_clownfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 11
	average_size = 10
	average_weight = 100
	dedicated_in_aquarium_icon_state = "clownfish_small"
	aquarium_vc_color = "#e8692b"
	sprite_width = 7
	sprite_height = 4

/obj/item/fish/darkpack/clownfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/holo_clownfish // the one that actually looks like a clownfish. the other one has a clown wig and mask on
	name = "holographic clownfish"
	icon_state = "holo_clownfish"
	fish_id = "darkpack_holo_clownfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 3
	average_size = 10
	average_weight = 100
	dedicated_in_aquarium_icon_state = "holo_clownfish_small"
	aquarium_vc_color = "#7bd4f0"
	sprite_width = 7
	sprite_height = 4

/obj/item/fish/darkpack/holo_clownfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/lanternfish
	name = "lanternfish"
	icon_state = "lanternfish"
	fish_id = "darkpack_lanternfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 8
	average_size = 12
	average_weight = 120
	dedicated_in_aquarium_icon_state = "lanternfish_small"
	aquarium_vc_color = "#204878"
	sprite_width = 6
	sprite_height = 5

/obj/item/fish/darkpack/lanternfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/goldfish
	name = "goldfish"
	icon_state = "goldfish"
	fish_id = "darkpack_goldfish"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 13
	average_size = 10
	average_weight = 80
	dedicated_in_aquarium_icon_state = "goldfish"
	aquarium_vc_color = "#f5a623"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/goldfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/dwarf_moonfish
	name = "dwarf moonfish"
	icon_state = "dwarf_moonfish"
	fish_id = "darkpack_dwarf_moonfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 9
	average_size = 12
	average_weight = 100
	dedicated_in_aquarium_icon_state = "dwarf_moonfish_small"
	aquarium_vc_color = "#90c8e0"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/dwarf_moonfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/tizira_moonfish
	name = "tiziran moonfish"
	icon_state = "tizira_moonfish"
	fish_id = "darkpack_tizira_moonfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 5
	average_size = 18
	average_weight = 250
	dedicated_in_aquarium_icon_state = "tizira_moonfish_small"
	aquarium_vc_color = "#9060e8"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/tizira_moonfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/needlefish
	name = "needlefish"
	icon_state = "needlefish"
	fish_id = "darkpack_needlefish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 9
	average_size = 30
	average_weight = 200
	dedicated_in_aquarium_icon_state = "needlefish_small"
	aquarium_vc_color = "#60c878"
	sprite_width = 8
	sprite_height = 2

/obj/item/fish/darkpack/needlefish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/armorfish
	name = "armorfish"
	icon_state = "armorfish"
	fish_id = "darkpack_armorfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 5
	average_size = 35
	average_weight = 900
	dedicated_in_aquarium_icon_state = "armorfish_small"
	aquarium_vc_color = "#607080"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/armorfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/pufferfish
	name = "pufferfish"
	icon_state = "pufferfish"
	fish_id = "darkpack_pufferfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 8
	average_size = 20
	average_weight = 300
	dedicated_in_aquarium_icon_state = "pufferfish_small"
	aquarium_vc_color = "#e8c840"
	sprite_width = 8
	sprite_height = 6

/obj/item/fish/darkpack/pufferfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/emulsijack
	name = "emulsijack"
	icon_state = "emulsijack"
	fish_id = "darkpack_emulsijack"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 6
	average_size = 25
	average_weight = 400
	dedicated_in_aquarium_icon_state = "emulsijack_small"
	aquarium_vc_color = "#9060c0"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/emulsijack/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/donkfish
	name = "donkfish"
	icon_state = "donkfish"
	fish_id = "darkpack_donkfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 7
	average_size = 20
	average_weight = 250
	dedicated_in_aquarium_icon_state = "donkfish_small"
	aquarium_vc_color = "#8a6840"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/donkfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/ratfish
	name = "rat"
	desc = "A common rat, found paddling around in the water. Not actually a fish."
	icon_state = "ratfish"
	fish_id = "darkpack_ratfish"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 7
	average_size = 18
	average_weight = 200
	dedicated_in_aquarium_icon_state = "ratfish_small"
	aquarium_vc_color = "#7a6a4a"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/ratfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/chrab
	name = "chrab"
	icon_state = "chrab"
	fillet_type = /obj/item/food/meat/slab/rawcrab
	fish_id = "darkpack_chrab"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 8
	average_size = 20
	average_weight = 350
	dedicated_in_aquarium_icon_state = "chrab_small"
	aquarium_vc_color = "#c85030"
	sprite_width = 6
	sprite_height = 5

/obj/item/fish/darkpack/chrab/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/arctic_chrab
	name = "arctic chrab"
	icon_state = "arctic_chrab"
	fillet_type = /obj/item/food/meat/slab/rawcrab
	fish_id = "darkpack_arctic_chrab"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 6
	average_size = 22
	average_weight = 400
	dedicated_in_aquarium_icon_state = "arctic_chrab_small"
	aquarium_vc_color = "#90b8c8"
	sprite_width = 6
	sprite_height = 5

/obj/item/fish/darkpack/arctic_chrab/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/half_fish
	name = "half fish"
	icon_state = "half_fish"
	fish_id = "darkpack_half_fish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 6
	average_size = 15
	average_weight = 150
	dedicated_in_aquarium_icon_state = "half_fish_small"
	aquarium_vc_color = "#c8c8c8"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/half_fish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/bonemass
	name = "bonemass"
	desc = "A mass of bones riddled with parasites. Gross!"
	icon_state = "bonemass"
	fish_id = "darkpack_bonemass"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 4
	average_size = 40
	average_weight = 700
	dedicated_in_aquarium_icon_state = "bonemass_small"
	aquarium_vc_color = "#e8e4d0"
	sprite_width = 5
	sprite_height = 5

/obj/item/fish/darkpack/bonemass/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/sludgefish
	name = "sludgefish"
	icon_state = "sludgefish"
	fish_id = "darkpack_sludgefish"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 7
	average_size = 30
	average_weight = 500
	dedicated_in_aquarium_icon_state = "sludgefish_small"
	aquarium_vc_color = "#507840"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/sludgefish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/sludgefish_purple
	name = "purple sludgefish"
	icon_state = "sludgefish_purple"
	fish_id = "darkpack_sludgefish_purple"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 5
	average_size = 30
	average_weight = 550
	dedicated_in_aquarium_icon_state = "sludgefish_purple_small"
	aquarium_vc_color = "#785090"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/sludgefish_purple/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/starfish
	name = "starfish"
	icon_state = "starfish"
	fish_id = "darkpack_starfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 9
	average_size = 20
	average_weight = 180
	dedicated_in_aquarium_icon_state = "starfish_small"
	aquarium_vc_color = "#e05830"
	sprite_width = 5
	sprite_height = 5

/obj/item/fish/darkpack/starfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/zipzap
	name = "zipzap"
	icon_state = "zipzap"
	fish_id = "darkpack_zipzap"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 6
	average_size = 20
	average_weight = 200
	dedicated_in_aquarium_icon_state = "zipzap_small"
	aquarium_vc_color = "#f0e840"
	sprite_width = 6
	sprite_height = 3

/obj/item/fish/darkpack/zipzap/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/jumpercable
	name = "jumpercablefish"
	desc = "A dense cluster of tiny fish that have gotten themselves stuck in a loop of jumper cables."
	icon_state = "jumpercable"
	fish_id = "darkpack_jumpercable"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 5
	average_size = 30
	average_weight = 450
	dedicated_in_aquarium_icon_state = "jumpercable_small"
	aquarium_vc_color = "#e8c830"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/jumpercable/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/arctic_char
	name = "arctic char"
	icon_state = "arctic_char"
	fish_id = "darkpack_arctic_char"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 8
	average_size = 40
	average_weight = 600
	dedicated_in_aquarium_icon_state = "arctic_char_small"
	aquarium_vc_color = "#ff8c69"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/arctic_char/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/stingray
	name = "stingray"
	icon_state = "stingray"
	fish_id = "darkpack_stingray"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 7
	average_size = 80
	average_weight = 1200
	dedicated_in_aquarium_icon_state = "stingray_small"
	aquarium_vc_color = "#405878"
	sprite_width = 8
	sprite_height = 7

/obj/item/fish/darkpack/stingray/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/sockeye
	name = "sockeye salmon"
	icon_state = "sockeye"
	fish_id = "darkpack_sockeye"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 9
	average_size = 45
	average_weight = 700
	dedicated_in_aquarium_icon_state = "sockeye_small"
	aquarium_vc_color = "#c44020"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/sockeye/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/swordfish
	name = "swordfish"
	icon_state = "swordfish_small"
	fish_id = "darkpack_swordfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 5
	average_size = 150
	average_weight = 1800
	dedicated_in_aquarium_icon_state = "swordfish_small"
	aquarium_vc_color = "#4870a0"
	sprite_width = 13
	sprite_height = 6

/obj/item/fish/darkpack/swordfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/bumpy
	name = "bumpy fish"
	icon_state = "bumpy"
	fish_id = "darkpack_bumpy"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 8
	average_size = 15
	average_weight = 200
	dedicated_in_aquarium_icon_state = "bumpy_small"
	aquarium_vc_color = "#a08060"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/bumpy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/sand_surfer
	name = "sand surfer"
	icon_state = "sand_surfer"
	fish_id = "darkpack_sand_surfer"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 7
	average_size = 25
	average_weight = 300
	dedicated_in_aquarium_icon_state = "sand_surfer_small"
	aquarium_vc_color = "#c8b870"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/sand_surfer/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/three_eyes
	name = "three-eyed fish"
	icon_state = "three_eyes"
	fish_id = "darkpack_three_eyes"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 5
	average_size = 20
	average_weight = 180
	dedicated_in_aquarium_icon_state = "three_eyes"
	aquarium_vc_color = "#50a060"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/three_eyes/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/tadpole
	name = "tadpole"
	icon_state = "tadpole"
	fish_id = "darkpack_tadpole"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 14
	average_size = 3
	average_weight = 30
	dedicated_in_aquarium_icon_state = "tadpole_small"
	aquarium_vc_color = "#404840"
	sprite_width = 3
	sprite_height = 1

/obj/item/fish/darkpack/tadpole/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/squid
	name = "squid"
	icon_state = "squid"
	fish_id = "darkpack_squid"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 8
	average_size = 35
	average_weight = 500
	dedicated_in_aquarium_icon_state = "squid_small"
	aquarium_vc_color = "#c84870"
	sprite_width = 4
	sprite_height = 5

/obj/item/fish/darkpack/squid/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/perch
	name = "perch"
	icon_state = "perch"
	fish_id = "darkpack_perch"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 11
	average_size = 25
	average_weight = 300
	dedicated_in_aquarium_icon_state = "perch"
	aquarium_vc_color = "#7a9932"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/perch/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/plaice
	name = "plaice"
	icon_state = "plaice"
	fish_id = "darkpack_plaice"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 9
	average_size = 35
	average_weight = 550
	dedicated_in_aquarium_icon_state = "plaice_small"
	aquarium_vc_color = "#a89060"
	sprite_width = 6
	sprite_height = 7

/obj/item/fish/darkpack/plaice/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/monkfish
	name = "monkfish"
	icon_state = "monkfish"
	fish_id = "darkpack_monkfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 6
	average_size = 50
	average_weight = 800
	dedicated_in_aquarium_icon_state = "monkfish_small"
	aquarium_vc_color = "#6a5040"
	sprite_width = 7
	sprite_height = 7

/obj/item/fish/darkpack/monkfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/pike
	name = "pike"
	icon_state = "pike_small"
	fish_id = "darkpack_pike"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 7
	average_size = 60
	average_weight = 1000
	dedicated_in_aquarium_icon_state = "pike_small"
	aquarium_vc_color = "#4a7a3a"
	sprite_width = 7
	sprite_height = 3

/obj/item/fish/darkpack/pike/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/armored_pike
	name = "armored pike"
	icon_state = "armored_pike_small"
	fish_id = "darkpack_armored_pike"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 4
	average_size = 70
	average_weight = 1200
	dedicated_in_aquarium_icon_state = "armored_pike_small"
	aquarium_vc_color = "#6a7a5a"
	sprite_width = 7
	sprite_height = 3

/obj/item/fish/darkpack/armored_pike/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/sacabambaspis
	name = "sacabambaspis"
	icon_state = "sacabambaspis"
	fish_id = "darkpack_sacabambaspis"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 4
	average_size = 25
	average_weight = 350
	dedicated_in_aquarium_icon_state = "sacabambaspis_small"
	aquarium_vc_color = "#a0c890"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/sacabambaspis/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/baby_carp
	name = "baby carp"
	icon_state = "baby_carp"
	fish_id = "darkpack_baby_carp"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 12
	average_size = 8
	average_weight = 80
	dedicated_in_aquarium_icon_state = "baby_carp_small"
	aquarium_vc_color = "#8890a0"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/baby_carp/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/fryish
	name = "fryish"
	icon_state = "fryish"
	fish_id = "darkpack_fryish"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 11
	average_size = 6
	average_weight = 55
	sprite_width = 3
	sprite_height = 3
	dedicated_in_aquarium_icon_state = "fryish_small"
	aquarium_vc_color = "#c8882c"

/obj/item/fish/darkpack/fryish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/fritterish
	name = "fritterish"
	icon_state = "fritterish"
	fish_id = "darkpack_fritterish"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 10
	average_size = 8
	average_weight = 70
	sprite_width = 5
	sprite_height = 3
	dedicated_in_aquarium_icon_state = "fritterish_small"
	aquarium_vc_color = "#c8a050"

/obj/item/fish/darkpack/fritterish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/nessiefish
	name = "nessiefish"
	icon_state = "nessiefish_small"
	fish_id = "darkpack_nessiefish"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	stable_population = 2
	average_size = 200
	average_weight = 1500
	sprite_width = 12
	sprite_height = 4
	dedicated_in_aquarium_icon_state = "nessiefish_small"
	aquarium_vc_color = "#487848"

/obj/item/fish/darkpack/nessiefish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)

/obj/item/fish/darkpack/mastodon
	name = "mastodon fish"
	icon_state = "mastodon_small"
	fish_id = "darkpack_mastodon"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	stable_population = 2
	average_size = 180
	average_weight = 1400
	sprite_width = 12
	sprite_height = 7
	dedicated_in_aquarium_icon_state = "mastodon_small"
	aquarium_vc_color = "#787060"

/obj/item/fish/darkpack/mastodon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, fish_price, "fish", FALSE)
