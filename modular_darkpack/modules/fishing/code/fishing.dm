/datum/fish_source/ocean/darkpack
	fish_table = list(
		FISHING_DUD = 10,
		/obj/effect/spawner/message_in_a_bottle = 2,
		/obj/item/coin/gold = 3,
		/obj/item/fish/darkpack/tuna = 20,
		// /obj/item/fish/darkpack/catfish = 20,
		/obj/item/fish/darkpack/crab = 11,
		/obj/item/fish/darkpack/shark = 5,
	)
	fish_counts = list(
		/obj/structure/mystery_box/fishing = 1,
	)
	fish_count_regen = list(
		/obj/structure/mystery_box/fishing = 32 MINUTES,
	)
	associated_safe_turfs = list(/turf/open/water/beach/vamp)

/datum/fish_source/river/darkpack
	fish_table = list(
		FISHING_DUD = 4,
		/obj/item/fish/darkpack/catfish = 20,
	)
	fish_counts = list()
	fish_count_regen = list()
	associated_safe_turfs = list(/turf/open/water/river)

/obj/item/fish/darkpack
	abstract_type = /obj/item/fish/darkpack
	desc = "marine life"
	icon = 'modular_darkpack/modules/deprecated/icons/48x32.dmi'
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')
	w_class = WEIGHT_CLASS_SMALL
	//eatsound = 'modular_darkpack/modules/food/sounds/eat.ogg'

/obj/item/fish/darkpack/shark
	name = "leopard shark"
	icon_state = "fish1"
	base_pixel_w = -16
	pixel_w = -16
	fish_id = "darkpack_shark"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER

	average_size = 60
	average_weight = 1400
	stable_population = 4

/obj/item/fish/darkpack/tuna
	name = "bluefin tuna"
	icon_state = "fish2"
	fish_id = "darkpack_tuna"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER
	num_fillets = 2

/obj/item/fish/darkpack/catfish
	name = "channel catfish"
	icon_state = "fish3"
	fish_id = "darkpack_catfish"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER

/obj/item/fish/darkpack/crab
	name = "dungeness crab"
	icon_state = "fish4"
	fillet_type = /obj/item/food/meat/slab/rawcrab
	fish_id = "darkpack_crab"
	required_fluid_type = AQUARIUM_FLUID_SALTWATER

	average_size = 50
	average_weight = 600

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
