/datum/outfit/job/vampire/swat_rifleman
	name = "Swat Rifleman"
	ears = /obj/item/radio/headset/darkpack/police
	uniform = /obj/item/clothing/under/vampire/police/utility
	gloves = /obj/item/clothing/gloves/fingerless
	l_pocket = /obj/item/vamp/keys/police
	suit_store = /obj/item/flashlight/seclite
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	belt = /obj/item/storage/belt/police/swat/full
	suit = /obj/item/clothing/suit/vampire/vest
	head = /obj/item/clothing/head/vampire/helmet
	id = /obj/item/card/police
	r_hand = /obj/item/gun/ballistic/automatic/darkpack/ar15
	backpack_contents = list(
		/obj/item/ammo_box/magazine/darkpack556 = 3,
		/obj/item/grenade/frag = 3,
		/obj/item/grenade/flashbang = 2,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/storage/medkit/darkpack/ifak = 1,
		/obj/item/restraints/handcuffs = 1,
		)

/datum/outfit/job/vampire/swat_lieutenant
	name = "Swat Lieutenant"
	ears = /obj/item/radio/headset/darkpack/police
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/police/utility
	gloves = /obj/item/clothing/gloves/fingerless
	l_pocket = /obj/item/vamp/keys/police/secure/chief
	suit_store = /obj/item/flashlight/seclite
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	belt = /obj/item/storage/belt/police/swat/full
	suit = /obj/item/clothing/suit/vampire/trench/armored
	head = /obj/item/clothing/head/hats/hos/beret
	id = /obj/item/card/police/sergeant
	r_hand = /obj/item/gun/ballistic/automatic/pistol/darkpack/deagle/c50
	backpack_contents = list(
		/obj/item/ammo_box/magazine/m50 = 4,
		/obj/item/grenade/frag = 1,
		/obj/item/grenade/flashbang = 1,
		/obj/item/grenade/smokebomb = 1,
		/obj/item/storage/medkit/darkpack/ifak = 1,
		/obj/item/storage/box/handcuffs = 1,
		)

/datum/outfit/job/vampire/swat_medic
	name = "Swat Field Medic"
	ears = /obj/item/radio/headset/darkpack/police
	glasses = /obj/item/clothing/glasses/vampire/perception
	uniform = /obj/item/clothing/under/vampire/police/utility
	gloves = /obj/item/clothing/gloves/vampire/latex
	l_pocket = /obj/item/vamp/keys/police
	suit_store = /obj/item/flashlight/seclite
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	belt = /obj/item/defibrillator/compact/loaded
	suit = /obj/item/clothing/suit/vampire/labcoat
	head = /obj/item/clothing/head/vampire/helmet
	id = /obj/item/card/police
	r_hand = /obj/item/gun/ballistic/automatic/darkpack/mp5
	backpack_contents = list(
		/obj/item/ammo_box/magazine/darkpack9mp5 = 2,
		/obj/item/storage/medkit/darkpack/doctor = 1,
		/obj/item/storage/medkit/darkpack/combat = 1,
		/obj/item/storage/medkit/darkpack/burn = 1,
		/obj/item/storage/medkit/darkpack/brute = 1,
		)

/datum/outfit/job/vampire/swat_negotiator
	name = "SWAT Negotiations Expert"
	ears = /obj/item/radio/headset/darkpack/police
	uniform = /obj/item/clothing/under/vampire/suit
	l_pocket = /obj/item/vamp/keys/police
	suit_store = /obj/item/flashlight/seclite
	shoes = /obj/item/clothing/shoes/vampire
	belt = /obj/item/megaphone
	id = /obj/item/card/police
	r_hand = /obj/item/gun/ballistic/automatic/darkpack/sniper // for when negotiations go south.
	backpack_contents = list(
		/obj/item/clothing/under/vampire/suit/female = 1,
		/obj/item/clothing/accessory/lawyers_badge = 1,
		/obj/item/stack/dollar/thousand = 7,
		/obj/item/ammo_box/darkpack/c50 = 1,
		/obj/item/reagent_containers/cup/glass/coffee/vampire = 5,
		/obj/item/food/cookie = 5, // cookies but no milk. these are gonna be some hard negotiations.
		)
