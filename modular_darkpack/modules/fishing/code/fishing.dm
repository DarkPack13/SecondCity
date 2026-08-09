/obj/item/fish/darkpack
	abstract_type = /obj/item/fish/darkpack
	desc = "marine life"
	icon = 'modular_darkpack/modules/fishing/icons/fish.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fishing/icons/fish_onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	//eatsound = 'modular_darkpack/modules/food/sounds/eat.ogg'

/obj/item/fish/darkpack/shark
	name = "leopard shark"
	icon_state = "shark"
	icon = 'modular_darkpack/modules/fishing/icons/fish48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fishing/icons/fish_onfloor.dmi')
	base_pixel_w = -16
	pixel_w = -16
	fish_id = "darkpack_shark"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER

	average_size = 135
	average_weight = 180
	stable_population = 4

	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#33302e"
	beauty = FISH_BEAUTY_GREAT
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/shark/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 60, "fish", FALSE)

/obj/item/fish/darkpack/tuna
	name = "bluefin tuna"
	icon_state = "fish"
	fish_id = "darkpack_tuna"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	num_fillets = 3

	stable_population = 3
	average_size = 225
	average_weight = 600

	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#33302e"
	sprite_width = 5
	sprite_height = 3

/obj/item/fish/darkpack/tuna/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 100, "fish", FALSE)

/obj/item/fish/darkpack/catfish
	name = "channel catfish"
	icon_state = "catfish"
	fish_id = "darkpack_catfish"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER

	stable_population = 3
	average_size = 30
	average_weight = 160

	dedicated_in_aquarium_icon_state = "catfish_small"
	beauty = FISH_BEAUTY_GOOD
	sprite_width = 4
	sprite_height = 2

/obj/item/fish/darkpack/catfish/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 20, "fish", FALSE)

/obj/item/fish/darkpack/crab
	name = "dungeness crab"
	icon_state = "crab"
	fillet_type = /obj/item/food/meat/slab/rawcrab
	fish_id = "darkpack_crab"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER

	stable_population = 8
	average_size = 160
	average_weight = 110

	dedicated_in_aquarium_icon_state = "crab_small"
	sprite_height = 4
	sprite_width = 4

/obj/item/fish/darkpack/crab/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 30, "fish", FALSE)

/obj/item/fish/darkpack/stickleback
	name = "three-spined stickleback"
	icon_state = "stickleback"
	fish_id = "darkpack_stickleback"
	required_fluid_type = AQUARIUM_FLUID_ANADROMOUS
	w_class = WEIGHT_CLASS_TINY

	stable_population = 8
	average_size = 10
	average_weight = 30

	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#9c8527"
	beauty = FISH_BEAUTY_NULL
	sprite_height = 1
	sprite_width = 2

/obj/item/fish/darkpack/stickleback/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 5, "fish", FALSE)

/obj/item/fish/darkpack/anchovy
	name = "anchovy"
	icon_state = "anchovy"
	fish_id = "darkpack_anchovy"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	w_class = WEIGHT_CLASS_TINY

	stable_population = 12
	average_size = 15
	average_weight = 50

	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#818493"
	beauty = FISH_BEAUTY_NULL
	sprite_height = 1
	sprite_width = 2

/obj/item/fish/darkpack/anchovy/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 10, "fish", FALSE)

/obj/item/fish/darkpack/crappie
	name = "crappie"
	icon_state = "crappie"
	fish_id = "darkpack_crappie"
	required_fluid_type = AQUARIUM_FLUID_FRESHWATER
	w_class = WEIGHT_CLASS_TINY

	stable_population = 16
	average_size = 15
	average_weight = 50

	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#819390"
	beauty = FISH_BEAUTY_BAD
	sprite_height = 1
	sprite_width = 2

/obj/item/fish/darkpack/crappie/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 10, "fish", FALSE)


/obj/item/fish/darkpack/trout
	name = "rainbow trout"
	icon_state = "trout"
	fish_id = "darkpack_trout"
	required_fluid_type = AQUARIUM_FLUID_ANADROMOUS

	stable_population = 8
	average_size = 30
	average_weight = 250

	dedicated_in_aquarium_icon_state = "fish_greyscale"
	aquarium_vc_color = "#c7c5d2"
	beauty = FISH_BEAUTY_GOOD
	sprite_height = 5
	sprite_width = 3

/obj/item/fish/darkpack/trout/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 50, "fish", FALSE)

/obj/item/fish/darkpack/eagle_ray
	name = "bat ray"
	icon_state = "eagle ray"
	fish_id = "darkpack_eagle_ray"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER

	stable_population = 2
	average_size = 150
	average_weight = 1100

	dedicated_in_aquarium_icon_state = "stingray_small"
	beauty = FISH_BEAUTY_EXCELLENT
	sprite_height = 7
	sprite_width = 9

/obj/item/fish/darkpack/eagle_ray/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 100, "fish", FALSE)

/obj/item/food/darkpack/leech
	name = "leech"
	desc = "A vile creature known to feast on the blood of others."
	icon_state = "leech"
	icon = 'modular_darkpack/modules/fishing/icons/fish.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fishing/icons/fish_onfloor.dmi')
	w_class = WEIGHT_CLASS_TINY

	bite_consumption = 1
	tastes = list("slime" = 1, "blood" = 1)
	foodtypes = GROSS | MEAT | RAW
	eat_time = 5
	food_reagents = list(/datum/reagent/consumable/nutriment/leech = 1)

/obj/item/fish/darkpack/leech/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 1, "fish", FALSE)

/datum/reagent/consumable/nutriment/leech
	nutriment_factor = 1 * REAGENTS_METABOLISM
	taste_description = "copper"

/datum/reagent/consumable/nutriment/leech/on_mob_life(mob/living/carbon/M)
	if(prob(25))
		if(get_kindred_splat(M))
			M.adjust_blood_pool(0.25)
		if(get_ghoul_splat(M))
			M.adjust_blood_pool(0.25)
	return ..()

/obj/item/food/darkpack/horn_snail
	name = "horn snail"
	icon = 'modular_darkpack/modules/fishing/icons/fish.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fishing/icons/fish_onfloor.dmi')
	icon_state = "horn snail"
	trash_type = /obj/item/toy/seashell/vampire/horn_snail
	w_class = WEIGHT_CLASS_TINY

	bite_consumption = 1
	tastes = list("snail" = 1)
	foodtypes = MEAT | RAW
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/protein = 1)

/obj/item/fish/darkpack/horn_snail/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 15, "fish", FALSE)

/obj/item/toy/seashell/vampire/horn_snail
	icon = 'modular_darkpack/modules/fishing/icons/fish.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/fishing/icons/fish_onfloor.dmi')
	icon_state = "horn snail"

/*
/obj/item/fishing_rod
	name = "fishing rod"
	icon_state = "fishing"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_BULKY
	lefthand_file = 'modular_darkpack/modules/deprecated/icons/lefthand.dmi'
	righthand_file = 'modular_darkpack/modules/deprecated/icons/righthand.dmi'
	var/catching = FALSE

/obj/item/fishing_rod/attack_self(mob/user)
	. = ..()
	if(isturf(user.loc))
		forceMove(user.loc)
		onflooricon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
		icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
		dir = user.dir
		anchored = TRUE

/obj/item/fishing_rod/mouse_drop_receive(atom/over_object)
	. = ..()
	if(isturf(loc))
		if(istype(over_object, /mob/living))
			if(get_dist(src, over_object) < 2)
				if(anchored)
					anchored = FALSE
					onflooricon = initial(onflooricon)
					icon = onflooricon

/obj/item/fishing_rod/attack_hand(mob/living/user)
	if(anchored)
		if(!istype(get_step(src, dir), /turf/open/water))
			return
		if(user.isfishing)
			return
		if(!catching)
			catching = TRUE
			user.isfishing = TRUE
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/catching.ogg', 50, FALSE)
			if(do_after(user, 15 SECONDS, src))
				catching = FALSE
				user.isfishing = FALSE
				var/diceroll = rand(1, 20)
				var/obj/item/fish/darkpack/new_fish
				if(diceroll <= 5)
					new_fish = /obj/item/fish/darkpack/tuna
				else if(diceroll <= 10)
					new_fish = /obj/item/fish/darkpack/catfish
				else if(diceroll <= 15)
					new_fish = /obj/item/fish/darkpack/crab
				else
					new_fish = /obj/item/fish/darkpack/shark
				new new_fish(user.loc)
				playsound(loc, 'modular_darkpack/modules/deprecated/sounds/catched.ogg', 50, FALSE)
			else
				catching = FALSE
				user.isfishing = FALSE
		return
	. = ..()
*/
