/obj/effect/decal/rugs
	name = "rugs"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "rugs"

/obj/effect/decal/rugs/Initialize(mapload)
	. = ..()
	icon_state = "rugs[rand(1, 11)]"

/obj/structure/vampfence
	name = "\improper fence"
	desc = "Protects places from walking in."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "fence"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/vampfence/corner
	icon_state = "fence_corner"

/obj/structure/vampfence/rich
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'

/obj/structure/vampfence/corner/rich
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'

/obj/structure/vampfence/Initialize(mapload)
	.=..()
	AddElement(/datum/element/climbable)

/obj/structure/vampfence/rich/Initialize(mapload)
	.=..()
	RemoveElement(/datum/element/climbable)

/obj/structure/gargoyle
	name = "\improper gargoyle"
	desc = "Some kind of gothic architecture."
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "gargoyle"
	pixel_z = 8
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/lamppost
	name = "lamppost"
	desc = "Gives some light to the streets."
	icon = 'modular_darkpack/modules/deprecated/icons/lamppost.dmi'
	base_icon_state = "base"
	layer = SPACEVINE_LAYER
	var/number_of_lamps
	pixel_w = -32
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/effect/decal/lamplight
	alpha = 0

/obj/effect/decal/lamplight/Initialize(mapload)
	. = ..()
	set_light(4, 3, "#ffde9b")

/obj/structure/lamppost/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"
	switch(number_of_lamps)
		if(1)
			switch(dir)
				if(NORTH)
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
				if(SOUTH)
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
				if(EAST)
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
				if(WEST)
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
		if(2)
			switch(dir)
				if(NORTH)
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
				if(SOUTH)
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
				if(EAST)
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
				if(WEST)
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
		if(3)
			switch(dir)
				if(NORTH)
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
				if(SOUTH)
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
				if(EAST)
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
				if(WEST)
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
		if(4)
			new /obj/effect/decal/lamplight(get_step(loc, NORTH))
			new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
			new /obj/effect/decal/lamplight(get_step(loc, EAST))
			new /obj/effect/decal/lamplight(get_step(loc, WEST))
		else
			new /obj/effect/decal/lamplight(loc)

/obj/structure/lamppost/one
	icon_state = "one"
	number_of_lamps = 1

/obj/structure/lamppost/two
	icon_state = "two"
	number_of_lamps = 2

/obj/structure/lamppost/three
	icon_state = "three"
	number_of_lamps = 3

/obj/structure/lamppost/four
	icon_state = "four"
	number_of_lamps = 4

/obj/structure/lamppost/sidewalk
	icon_state = "civ"
	number_of_lamps = 5

/obj/structure/lamppost/sidewalk/chinese
	icon_state = "chinese"

/obj/structure/trafficlight
	name = "traffic light"
	desc = "Shows when road is free or not."
	icon = 'modular_darkpack/modules/deprecated/icons/lamppost.dmi'
	icon_state = "traffic"
	layer = SPACEVINE_LAYER
	pixel_w = -32
	anchored = TRUE

/obj/structure/trafficlight/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/clothingrack
	name = "clothing rack"
	desc = "Have some clothes."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "rack"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/clothingrack/rand
	icon_state = "rack2"

/obj/structure/clothingrack/rand/Initialize(mapload)
	. = ..()
	icon_state = "rack[rand(1, 5)]"

/obj/structure/clothinghanger
	name = "clothing hanger"
	desc = "Have some clothes."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "hanger1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/clothinghanger/Initialize(mapload)
	. = ..()
	icon_state = "hanger[rand(1, 4)]"

/obj/structure/foodrack
	name = "food rack"
	desc = "Have some food."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "rack2"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -16

/obj/structure/foodrack/Initialize(mapload)
	. = ..()
	icon_state = "rack[rand(1, 5)]"

//I should make these slow to move
/obj/structure/closet/crate/dumpster
	name = "dumpster"
	desc = "Holds garbage inside."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "garbage"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	var/internal_trash_chance = 75
	var/external_trash_chance = 10

/obj/structure/closet/crate/dumpster/Initialize(mapload)
	if(prob(25))
		icon_state = "garbageopen"
	. = ..()
	//Letting you clear the snow by opening and closing it is acctually pretty flavor
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/closet/crate/dumpster/PopulateContents()
	if(prob(internal_trash_chance))
		if(prob(95))
			new /obj/effect/spawner/random/trash/garbage(src)
		else //Pretty rare while the loot table is un-audited
			new /obj/effect/spawner/random/maintenance(src)
	if(prob(external_trash_chance))
		new /obj/effect/spawner/random/trash/grime(loc)

/obj/structure/closet/crate/dumpster/empty
	internal_trash_chance = 0
	external_trash_chance = 0

/obj/structure/trashbag
	name = "trash bags"
	desc = "Enough trashbags to block your way."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "garbage1"
	density = TRUE
	anchored = TRUE

/obj/structure/trashbag/Initialize(mapload)
	. = ..()
	icon_state = "garbage[rand(7, 9)]"

/obj/structure/trashbag/Destroy()
	new /obj/effect/spawner/random/trash/garbage(loc)
	return ..()

/obj/structure/hotelbanner
	name = "banner"
	desc = "It says H O T E L."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "banner"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/hotelbanner/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/arc
	name = "chinatown arc"
	desc = "Cool chinese architecture."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "ark1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/arc/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/arc/add
	icon_state = "ark2"

/obj/structure/trad
	name = "traditional lamp"
	desc = "Cool chinese lamp."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "trad"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/vampipe
	name = "pipes"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "piping1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/vamproofwall
	name = "wall"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "the_wall"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/hydrant
	name = "hydrant"
	desc = "Used for firefighting."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "hydrant"
	anchored = TRUE

/obj/structure/hydrant/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/* Dwarfs arent real
/obj/structure/hydrant/MouseDrop_T(atom/dropping, mob/user, params)
	. = ..()

	if(HAS_TRAIT(user, TRAIT_DWARF)) //Only lean on the fire hydrant if we are smol
		//Adds the component only once. We do it here & not in Initialize(mapload) because there are tons of windows & we don't want to add to their init times
		LoadComponent(/datum/component/leanable, dropping)
*/

/obj/structure/vampcar
	name = "car"
	desc = "It drives."
	icon = 'modular_darkpack/modules/deprecated/icons/cars.dmi'
	icon_state = "taxi"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -16

/obj/structure/vampcar/Initialize(mapload)
	. = ..()
	var/atom/movable/M = new(get_step(loc, EAST))
	M.density = TRUE
	M.anchored = TRUE
	dir = pick(NORTH, SOUTH, WEST, EAST)

/obj/structure/roadblock
	name = "\improper road block"
	desc = "Protects places from walking in."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "roadblock"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/roadblock/alt
	icon_state = "barrier"

/obj/machinery/light/prince
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'

/obj/machinery/light/prince/ghost

/obj/machinery/light/prince/ghost/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ENTERED, PROC_REF(jumpscare))

/obj/machinery/light/prince/ghost/proc/jumpscare(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(ishuman(arrived))
		var/mob/living/L = arrived
		if(L.client)
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(5, 1, get_turf(src))
			s.start()
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/explode.ogg', 100, TRUE)
			qdel(src)

/obj/machinery/light/prince/broken
	status = LIGHT_BROKEN
	icon_state = "tube-broken"

/obj/effect/decal/painting
	name = "painting"
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "painting1"
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/decal/painting/second
	icon_state = "painting2"

/obj/effect/decal/painting/third
	icon_state = "painting3"

/obj/structure/jesuscross
	name = "Jesus Christ on a cross"
	desc = "Jesus said, “Father, forgive them, for they do not know what they are doing.” And they divided up his clothes by casting lots (Luke 23:34)."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "cross"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -16
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/roadsign
	name = "road sign"
	desc = "Do not drive your car cluelessly."
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "stop"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/roadsign/stop
	name = "stop sign"
	icon_state = "stop"

/obj/structure/roadsign/noparking
	name = "no parking sign"
	icon_state = "noparking"

/obj/structure/roadsign/nopedestrian
	name = "no pedestrian sign"
	icon_state = "nopedestrian"

/obj/structure/roadsign/busstop
	name = "bus stop sign"
	icon_state = "busstop"

/obj/structure/roadsign/speedlimit
	name = "speed limit sign"
	icon_state = "speed50"

/obj/structure/roadsign/speedlimit40
	name = "speed limit sign"
	icon_state = "speed40"

/obj/structure/roadsign/speedlimit25
	name = "speed limit sign"
	icon_state = "speed25"

/obj/structure/roadsign/warningtrafficlight
	name = "traffic light warning sign"
	icon_state = "warningtrafficlight"

/obj/structure/roadsign/warningpedestrian
	name = "pedestrian warning sign"
	icon_state = "warningpedestrian"

/obj/structure/roadsign/parking
	name = "parking sign"
	icon_state = "parking"

/obj/structure/roadsign/crosswalk
	name = "crosswalk sign"
	icon_state = "crosswalk"

/obj/structure/barrels
	name = "barrel"
	desc = "Storage some liquids."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "barrel1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/barrels/rand
	icon_state = "barrel2"

/obj/structure/barrels/rand/Initialize(mapload)
	. = ..()
	icon_state = "barrel[rand(1, 12)]"

/obj/structure/bricks
	name = "bricks"
	desc = "Building material."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "bricks"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/effect/decal/pallet
	name = "pallet"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "under1"

/obj/effect/decal/pallet/Initialize(mapload)
	. = ..()
	icon_state = "under[rand(1, 2)]"

/obj/cargotrain
	name = "cargocrate"
	desc = "It delivers a lot of things."
	icon = 'modular_darkpack/modules/deprecated/icons/containers.dmi'
	icon_state = "1"
	anchored = TRUE
	density = FALSE
	pass_flags = PASSTABLE | PASSGRILLE | PASSMOB | PASSGLASS | PASSCLOSEDTURF
	movement_type = PHASING
	var/mob/living/starter

/obj/cargotrain/Initialize(mapload)
	. = ..()
	icon_state = "[rand(2, 5)]"

/obj/cargotrain/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	for(var/mob/living/L in get_step(src, movement_dir))
		if(isnpc(L))
			if(starter)
				if(ishuman(starter))
					var/mob/living/carbon/human/H = starter
					H.AdjustHumanity(-1, 0)
		L.gib()
	. = ..()

/obj/cargocrate
	name = "cargocrate"
	desc = "It delivers a lot of things."
	icon = 'modular_darkpack/modules/deprecated/icons/containers.dmi'
	icon_state = "1"
	anchored = TRUE


/obj/cargocrate/Initialize(mapload)
	. = ..()
	icon_state = "[rand(1, 5)]"
	if(icon_state != "1")
		opacity = TRUE
	density = TRUE
	var/atom/movable/M1 = new(get_step(loc, EAST))
	var/atom/movable/M2 = new(get_step(M1.loc, EAST))
	var/atom/movable/M3 = new(get_step(M2.loc, EAST))
	M1.density = TRUE
	if(icon_state != "1")
		M1.opacity = TRUE
	M1.anchored = TRUE
	M2.density = TRUE
	if(icon_state != "1")
		M2.opacity = TRUE
	M2.anchored = TRUE
	M3.density = TRUE
	if(icon_state != "1")
		M3.opacity = TRUE
	M3.anchored = TRUE

/proc/get_farthest_open_chain_turf(turf/start, dir = EAST, distance = 20)
	var/turf/current = start
	var/turf/last_open = null
	for(var/i = 1 to distance)
		current = get_step(current, dir)
		if(isopenturf(current))
			last_open = current
		else
			break
	return last_open || start

/obj/structure/marketplace
	name = "stock market"
	desc = "Recent stocks visualization."
	icon = 'modular_darkpack/modules/deprecated/icons/stonks.dmi'
	icon_state = "marketplace"
	anchored = TRUE
	density = TRUE
	pixel_w = -24
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/fuelstation
	name = "fuel station"
	desc = "Fuel your car here. 50 dollars per 1000 units."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "fuelstation"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/stored_money = 0

// TODO: [Rebase] - Refactor into signal handler
/*
/obj/structure/fuelstation/AltClick(mob/user)
	if(stored_money)
		say("Money refunded.")
		for(var/i in 1 to stored_money)
			new /obj/item/stack/dollar(loc)
		stored_money = 0
*/

/obj/structure/fuelstation/examine(mob/user)
	. = ..()
	. += "<b>Balance</b>: [stored_money] dollars"

// TODO: [Rebase] - Requires /obj/item/gas_can
/*
/obj/structure/fuelstation/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/dollar))
		var/obj/item/stack/dollar/dolla = I
		stored_money += dolla.get_item_credit_value()
		to_chat(user, "<span class='notice'>You insert [dolla.get_item_credit_value()] dollars into [src].</span>")
		qdel(I)
		say("Payment received.")
	if(istype(I, /obj/item/gas_can))
		var/obj/item/gas_can/G = I
		if(G.stored_gasoline < 1000 && stored_money)
			var/gas_to_dispense = min(stored_money*20, 1000-G.stored_gasoline)
			var/money_to_spend = round(gas_to_dispense/20)
			G.stored_gasoline = min(1000, G.stored_gasoline+gas_to_dispense)
			stored_money = max(0, stored_money-money_to_spend)
			playsound(loc, 'modular_darkpack/modules/deprecated/sounds/gas_fill.ogg', 50, TRUE)
			to_chat(user, "<span class='notice'>You fill [I].</span>")
			say("Gas filled.")
*/

/obj/structure/bloodextractor
	name = "blood extractor"
	desc = "Extract blood in packs."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "bloodextractor"
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/last_extracted = 0

/obj/structure/reagent_dispensers/cleaningfluid
	name = "cleaning fluid tank"
	desc = "A container filled with cleaning fluid."
	reagent_id = /datum/reagent/space_cleaner
	icon_state = "water"

/*
/mob/living/carbon/human/MouseDrop(atom/over_object)
	. = ..()
	if(istype(over_object, /obj/structure/bloodextractor))
		if(get_dist(src, over_object) < 2)
			var/obj/structure/bloodextractor/V = over_object
			if(!buckled)
				V.visible_message("<span class='warning'>Buckle [src] fist!</span>")
			if(bloodpool < 2)
				V.visible_message("<span class='warning'>[V] can't find enough blood in [src]!</span>")
				return
			if(iskindred(src))
				if(bloodpool < 4)
					V.visible_message("<span class='warning'>[V] can't find enough blood in [src]!</span>")
					return
			if(V.last_extracted+1200 > world.time)
				V.visible_message("<span class='warning'>[V] isn't ready!</span>")
				return
			V.last_extracted = world.time
			if(!iskindred(src))
				new /obj/item/drinkable_bloodpack(get_step(V, SOUTH))
				bloodpool = max(0, bloodpool-2)
			else
				new /obj/item/drinkable_bloodpack/vitae(get_step(V, SOUTH))
				bloodpool = max(0, bloodpool-4)
*/

/obj/structure/rack/tacobell
	name = "table"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "tacobell"

/obj/structure/rack/tacobell/attack_hand(mob/living/user)
	return

/obj/structure/rack/tacobell/horizontal
	icon_state = "tacobell1"

/obj/structure/rack/tacobell/vertical
	icon_state = "tacobell2"

/obj/structure/rack/tacobell/south
	icon_state = "tacobell3"

/obj/structure/rack/tacobell/north
	icon_state = "tacobell4"

/obj/structure/rack/tacobell/east
	icon_state = "tacobell5"

/obj/structure/rack/tacobell/west
	icon_state = "tacobell6"

/obj/structure/rack/bubway
	name = "table"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "bubway"

/obj/structure/rack/bubway/attack_hand(mob/living/user)
	return

/obj/structure/rack/bubway/horizontal
	icon_state = "bubway1"

/obj/structure/rack/bubway/vertical
	icon_state = "bubway2"

/obj/structure/rack/bubway/south
	icon_state = "bubway3"

/obj/structure/rack/bubway/north
	icon_state = "bubway4"

/obj/structure/rack/bubway/east
	icon_state = "bubway5"

/obj/structure/rack/bubway/west
	icon_state = "bubway6"

/obj/underplate
	name = "underplate"
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "underplate"
	layer = TABLE_LAYER
	anchored = TRUE

/obj/underplate/stuff
	icon_state = "stuff"

/obj/structure/billiard_table
	name = "billiard table"
	desc = "Come here, play some BALLS. I know you want it so much..."
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "billiard1"
	anchored = TRUE
	density = TRUE

/obj/structure/billiard_table/Initialize(mapload)
	. = ..()
	icon_state = "billiard[rand(1, 3)]"

/obj/structure/pole
	name = "stripper pole"
	desc = "A pole fastened to the ceiling and floor, used to show of ones goods to company."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "pole"
	density = TRUE
	anchored = TRUE
	var/icon_state_inuse
	layer = 4 //make it the same layer as players.
	density = 0 //easy to step up on
	/// Is the pole in use currently?
	var/pole_in_use

/obj/structure/pole/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(pole_in_use)
		to_chat(user, "It's already in use - wait a bit.")
		return
	if(user.dancing)
		return
	else
		pole_in_use = TRUE
		user.setDir(SOUTH)
		user.Stun(100)
		user.forceMove(src.loc)
		user.visible_message("<B>[user] dances on [src]!</B>")
		animatepole(user)
		user.layer = layer //set them to the poles layer
		pole_in_use = FALSE
		user.pixel_y = 0
		icon_state = initial(icon_state)

/obj/structure/pole/proc/animatepole(mob/living/user)
	return

/obj/structure/pole/animatepole(mob/living/user)

	if (user.loc != src.loc)
		return
	animate(user,pixel_x = -6, pixel_y = 0, time = 10)
	sleep(20)
	user.dir = 4
	animate(user,pixel_x = -6,pixel_y = 24, time = 10)
	sleep(12)
	src.layer = 4.01 //move the pole infront for now. better to move the pole, because the character moved behind people sitting above otherwise
	animate(user,pixel_x = 6,pixel_y = 12, time = 5)
	user.dir = 8
	sleep(6)
	animate(user,pixel_x = -6,pixel_y = 4, time = 5)
	user.dir = 4
	src.layer = 4 // move it back.
	sleep(6)
	user.dir = 1
	animate(user,pixel_x = 0, pixel_y = 0, time = 3)
	sleep(6)
	user.do_jitter_animation()
	sleep(6)
	user.dir = 2

/obj/structure/fire_barrel
	name = "barrel"
	desc = "Some kind of light and warm source..."
	icon = 'modular_darkpack/modules/deprecated/icons/icons.dmi'
	icon_state = "barrel"
	anchored = TRUE
	density = TRUE

/obj/structure/fire_barrel/Initialize(mapload)
	. = ..()
	set_light(3, 2, "#ffa800")

/obj/structure/fountain
	name = "fountain"
	desc = "Gothic water structure."
	icon = 'modular_darkpack/modules/deprecated/icons/fountain.dmi'
	icon_state = "fountain"
	anchored = TRUE
	density = TRUE
	pixel_w = -16
	pixel_z = -16

/obj/structure/coclock
	name = "clock"
	desc = "See the time."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "clock"
	anchored = TRUE
	pixel_z = 32

/obj/structure/coclock/examine(mob/user)
	. = ..()
	// TODO: [Rebase] - Port https://github.com/ApocryphaXIII/ApocryphaXIII/pull/51
	//to_chat(user, "<b>[SScity_time.timeofnight]</b>")

/obj/structure/coclock/grandpa
	icon = 'modular_darkpack/modules/deprecated/icons/grandpa_cock.dmi'
	icon_state = "cock"
	anchored = TRUE
	density = TRUE
	pixel_z = 0

/turf/open/floor/plating/bloodshit
	gender = PLURAL
	name = "blood"
	icon = 'modular_darkpack/modules/deprecated/icons/tiles.dmi'
	icon_state = "blood"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

/turf/open/floor/plating/bloodshit/Initialize(mapload)
	. = ..()
	for(var/mob/living/L in src)
		if(L)
			L.death()
	spawn(5)
		for(var/turf/T in range(1, src))
			if(T && !istype(T, /turf/open/floor/plating/bloodshit))
				new /turf/open/floor/plating/bloodshit(T)



/obj/effect/decal/graffiti
	name = "graffiti"
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "graffiti1"
	pixel_z = 32
	anchored = TRUE
	var/large = FALSE

/obj/effect/decal/graffiti/large
	pixel_w = -16
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	large = TRUE

/obj/effect/decal/graffiti/Initialize(mapload)
	. = ..()
	if(!large)
		icon_state = "graffiti[rand(1, 15)]"
	else
		icon_state = "graffiti[rand(1, 3)]"

/obj/structure/roofstuff
	name = "roof ventilation"
	desc = "Air to inside."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "roof1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/roofstuff/Initialize(mapload)
	. = ..()
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/roofstuff/alt1
	icon_state = "roof2"
	density = FALSE

/obj/structure/roofstuff/alt2
	icon_state = "roof3"

/obj/structure/roofstuff/alt3
	icon_state = "roof4"

/obj/effect/decal/kopatich
	name = "hide carpet"
	pixel_w = -16
	pixel_z = -16
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "kopatich"

/obj/effect/decal/baalirune
	name = "satanic rune"
	pixel_w = -16
	pixel_z = -16
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "baali"
	var/total_corpses = 0

// TODO: [Rebase] - Requires /mob/living/simple_animal/hostile/baali_guard
/*
/obj/effect/decal/baalirune/attack_hand(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/H = locate() in get_turf(src)
	if(H)
		if(H.stat == DEAD)
			H.gib()
			total_corpses += 1
			if(total_corpses >= 20)
				total_corpses = 0
				playsound(get_turf(src), 'sound/effects/magic/demon_dies.ogg', 100, TRUE)
				new /mob/living/simple_animal/hostile/baali_guard(get_turf(src))
//			var/datum/preferences/P = GLOB.preferences_datums[ckey(user.key)]
//			if(P)
//				P.exper = min(calculate_mob_max_exper(user), P.exper+15)
*/

/obj/structure/vamptree
	name = "tree"
	desc = "Cute and tall flora."
	icon = 'modular_darkpack/modules/deprecated/icons/trees.dmi'
	icon_state = "tree1"
	layer = SPACEVINE_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -32
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/burned = FALSE

/obj/structure/vamptree/Initialize(mapload)
	. = ..()
	icon_state = "tree[rand(1, 11)]"
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)][rand(1, 11)]-snow"

/obj/structure/vamptree/proc/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead[rand(1, 3)]"

/obj/structure/vamptree/pine
	name = "pine"
	desc = "Cute and tall flora."
	icon = 'modular_darkpack/modules/deprecated/icons/pines.dmi'
	icon_state = "pine1"
	layer = SPACEVINE_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -24
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/vamptree/pine/Initialize(mapload)
	. = ..()
	icon_state = "pine[rand(1, 4)]"
	if(check_holidays(CHRISTMAS))
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "pine[rand(1, 4)]-snow"
	if(prob(2))
		burned = TRUE
		icon_state = "dead[rand(1, 5)]"

/obj/structure/vamptree/pine/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead[rand(1, 5)]"

/obj/structure/vampstatue
	name = "statue"
	desc = "A cloaked figure forgotten to the ages."
	icon = 'modular_darkpack/modules/deprecated/icons/32x64.dmi'
	icon_state = "statue"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/vampstatue/angel
	name = "angel statue"
	desc = "An angel stands before you. You're glad it's only stone."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "angelstatue"

/obj/structure/vampstatue/cloaked
	name = "cloaked figure"
	desc = "He appears to be sitting."
	icon = 'modular_darkpack/modules/deprecated/icons/32x48.dmi'
	icon_state = "cloakedstatue"

/obj/structure/bath
	name = "bath"
	desc = "Not big enough for hiding in."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "tub"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/weapon_showcase
	name = "weapon showcase"
	desc = "Look, a gun."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "showcase"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_ALL_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/weapon_showcase/Initialize(mapload)
	. = ..()
	icon_state = "showcase[rand(1, 7)]"

/obj/effect/decal/carpet
	name = "carpet"
	pixel_w = -16
	pixel_z = -16
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "kover"

/obj/structure/vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "rock1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/vamprocks/Initialize(mapload)
	. = ..()
	icon_state = "rock[rand(1, 9)]"

/obj/structure/small_vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "smallrock1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/small_vamprocks/Initialize(mapload)
	. = ..()
	icon_state = "smallrock[rand(1, 6)]"

/obj/structure/big_vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "rock1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_w = -16

/obj/structure/big_vamprocks/Initialize(mapload)
	. = ..()
	icon_state = "rock[rand(1, 4)]"

/obj/structure/stalagmite
	name = "stalagmite"
	desc = "Rokk."
	icon = 'modular_darkpack/modules/deprecated/icons/64x64.dmi'
	icon_state = "stalagmite1"
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_w = -16

/obj/structure/stalagmite/Initialize(mapload)
	. = ..()
	icon_state = "stalagmite[rand(1, 5)]"

/obj/were_ice
	name = "ice block"
	desc = "Stores some precious organs..."
	icon = 'modular_darkpack/modules/deprecated/icons/werewolf_lupus.dmi'
	icon_state = "ice_man"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/were_ice/lupus
	icon_state = "ice_wolf"

/obj/were_ice/crinos
	icon = 'modular_darkpack/modules/deprecated/icons/werewolf.dmi'
	icon_state = "ice"
	pixel_w = -8

/obj/structure/bury_pit
	name = "bury pit"
	desc = "You can bury someone here."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "pit0"
	layer = ABOVE_OPEN_TURF_LAYER
	anchored = TRUE
	density = FALSE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	var/burying = FALSE

// TODO: [Rebase]
/*
/obj/structure/bury_pit/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/melee/vampirearms/shovel))
		if(!burying)
			burying = TRUE
			user.visible_message("<span class='warning'>[user] starts to dig [src]</span>", "<span class='warning'>You start to dig [src].</span>")
			if(do_mob(user, src, 10 SECONDS))
				burying = FALSE
				if(icon_state == "pit0")
					var/dead_amongst = FALSE
					for(var/mob/living/L in get_turf(src))
						L.forceMove(src)
						if(L.stat == DEAD)
							dead_amongst = TRUE
						icon_state = "pit1"
						user.visible_message("<span class='warning'>[user] digs a hole in [src].</span>", "<span class='warning'>You dig a hole in [src].</span>")
						if(dead_amongst)
							call_dharma("respect", user)
				else
					var/dead_amongst = FALSE
					for(var/mob/living/L in src)
						L.forceMove(get_turf(src))
						if(L.stat == DEAD)
							dead_amongst = TRUE
					icon_state = "pit0"
					user.visible_message("<span class='warning'>[user] digs a hole in [src].</span>", "<span class='warning'>You dig a hole in [src].</span>")
					if(dead_amongst)
						call_dharma("disrespect", user)
			else
				burying = FALSE

/obj/structure/bury_pit/container_resist_act(mob/living/user)
	if(!burying)
		burying = TRUE
		if(do_mob(user, src, 30 SECONDS))
			for(var/mob/living/L in src)
				L.forceMove(get_turf(src))
			icon_state = "pit0"
			burying = FALSE
		else
			burying = FALSE
*/

/obj/structure/fluff/tv
	name = "\improper TV"
	desc = "A slightly battered looking TV. Various infomercials play on a loop, accompanied by a jaunty tune."
	icon = 'modular_darkpack/modules/deprecated/icons/props.dmi'
	icon_state = "tv_news"

/obj/structure/fluff/tv/order
	name = "order screen"
	desc = "A slightly battered looking TV. It shows a menu to order from."
	icon_state = "order1"

/obj/structure/fluff/tv/order/one
	icon_state = "order1"

/obj/structure/fluff/tv/order/two
	icon_state = "order2"

/obj/structure/fluff/tv/order/three
	icon_state = "order3"

/obj/structure/fluff/tv/order/four
	icon_state = "order4"

/obj/structure/fluff/tv/order/random

/obj/structure/fluff/tv/order/random/Initialize(mapload)
	. = ..()
	icon_state = "order[rand(1,4)]"
