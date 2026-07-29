/obj/structure/retail/police_equipment
	product_types = list(
		/obj/item/clothing/under/vampire/police,
		/obj/item/clothing/under/vampire/police/long,
		/obj/item/clothing/under/vampire/police/turtleneck,
		/obj/item/clothing/under/vampire/police/pants,
		/obj/item/clothing/under/vampire/police/utility,
		/obj/item/clothing/gloves/tackler/combat/insulated,
		/obj/item/clothing/head/vampire/police,
		/obj/item/clothing/head/vampire/helmet,
		/obj/item/clothing/suit/vampire/vest/police,
		/obj/item/clothing/suit/vampire/coat/police,
		/obj/item/storage/belt/holster/detective/darkpack,
		/obj/item/storage/belt/security/police,
		/obj/item/camera/detective,
		/obj/item/taperecorder,
		/obj/item/toy/crayon/white,
		/obj/item/storage/box/evidence,
		/obj/item/flashlight/seclite,
		/obj/item/detective_scanner/darkpack,
		/obj/item/binoculars,
		/obj/item/storage/box/bodybags,
		/obj/item/restraints/handcuffs,
		/obj/item/storage/medkit/darkpack/ifak,
		/obj/item/radio/headset/darkpack/police,
		/obj/item/gun/energy/taser/darkpack,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/melee/baton/vamp,
		/obj/item/gun/ballistic/automatic/pistol/darkpack/glock19,
		/obj/item/ammo_box/magazine/glock9mm,
		/obj/item/gun/ballistic/shotgun/vampire,
		/obj/item/gun/ballistic/automatic/darkpack/mp5,
		/obj/item/ammo_box/magazine/darkpack9mp5,
		/obj/item/gun/ballistic/automatic/darkpack/mp7,
		/obj/item/ammo_box/magazine/darkpack/c46pdw/ext,
		/obj/item/gun/ballistic/automatic/darkpack/ar15,
		/obj/item/ammo_box/magazine/darkpack556,
		/obj/item/gun/ballistic/automatic/darkpack/autoshotgun,
		/obj/item/ammo_box/magazine/darkpackautoshot,
		/obj/item/gun/ballistic/automatic/darkpack/autosniper,
		/obj/item/ammo_box/magazine/vamp762x51PSG1,
		/obj/item/gun/ballistic/automatic/darkpack/sniper,
		/obj/item/ammo_box/darkpack/c50,
		/obj/item/ammo_box/darkpack/c762x51mm,
		/obj/item/ammo_box/darkpack/c12g,
		/obj/item/ammo_box/darkpack/c12g/buck,
		/obj/item/ammo_box/darkpack/c12g/incap,
		/obj/item/ammo_box/darkpack/c12g/rubber,
		/obj/item/ammo_box/darkpack/c9mm,
		/obj/item/ammo_box/darkpack/c556,
		/obj/item/ammo_box/darkpack/c46pdw,
	)
	products_list = list(

		// Investigation tools
		new /datum/data/vending_product("detective camera", /obj/item/camera/detective, 10),
		new /datum/data/vending_product("tape recorder", /obj/item/taperecorder, 10),
		new /datum/data/vending_product("white crayon", /obj/item/toy/crayon/white, 10),
		new /datum/data/vending_product("detective scanner", /obj/item/detective_scanner/darkpack, 10),
		new /datum/data/vending_product("binoculars", /obj/item/binoculars, 20),
		new /datum/data/vending_product("seclite flashlight", /obj/item/flashlight/seclite, 10),

		// Restraints & headset
		new /datum/data/vending_product("handcuffs", /obj/item/restraints/handcuffs, 10),
		new /datum/data/vending_product("police headset", /obj/item/radio/headset/darkpack/police, 20),

		// Less-lethal / non-gun tools
		new /datum/data/vending_product("pepper spray", /obj/item/reagent_containers/spray/pepper, 20),
		new /datum/data/vending_product("stun baton", /obj/item/melee/baton/vamp, 20),
		new /datum/data/vending_product("taser", /obj/item/gun/energy/taser/darkpack, 50),

		// Sidearms
		new /datum/data/vending_product("glock 19", /obj/item/gun/ballistic/automatic/pistol/darkpack/glock19, 50),
		new /datum/data/vending_product("9mm glock magazine", /obj/item/ammo_box/magazine/glock9mm, 10),

		// Long guns
		new /datum/data/vending_product("pump shotgun", /obj/item/gun/ballistic/shotgun/vampire, 200),
		new /datum/data/vending_product("MP5", /obj/item/gun/ballistic/automatic/darkpack/mp5, 200),
		new /datum/data/vending_product("MP5 magazine", /obj/item/ammo_box/magazine/darkpack9mp5, 20),
		new /datum/data/vending_product("MP7", /obj/item/gun/ballistic/automatic/darkpack/mp7, 200),
		new /datum/data/vending_product("MP7 extended magazine", /obj/item/ammo_box/magazine/darkpack/c46pdw/ext, 20),
		new /datum/data/vending_product("AR-15", /obj/item/gun/ballistic/automatic/darkpack/ar15, 200),
		new /datum/data/vending_product("5.56 magazine", /obj/item/ammo_box/magazine/darkpack556, 20),
		new /datum/data/vending_product("auto shotgun", /obj/item/gun/ballistic/automatic/darkpack/autoshotgun, 200),
		new /datum/data/vending_product("auto shotgun magazine", /obj/item/ammo_box/magazine/darkpackautoshot, 20),
		new /datum/data/vending_product("auto sniper", /obj/item/gun/ballistic/automatic/darkpack/autosniper, 200),
		new /datum/data/vending_product("PSG1 7.62 magazine", /obj/item/ammo_box/magazine/vamp762x51PSG1, 20),
		new /datum/data/vending_product("sniper rifle", /obj/item/gun/ballistic/automatic/darkpack/sniper, 200),

		// Ammo boxes (bulk reloads)
		new /datum/data/vending_product(".50 cal ammo box", /obj/item/ammo_box/darkpack/c50, 80),
		new /datum/data/vending_product("7.62x51mm ammo box", /obj/item/ammo_box/darkpack/c762x51mm, 80),
		new /datum/data/vending_product("12 gauge ammo box", /obj/item/ammo_box/darkpack/c12g, 80),
		new /datum/data/vending_product("12 gauge buckshot box", /obj/item/ammo_box/darkpack/c12g/buck, 80),
		new /datum/data/vending_product("12 gauge incap box", /obj/item/ammo_box/darkpack/c12g/incap, 80),
		new /datum/data/vending_product("12 gauge rubber slug box", /obj/item/ammo_box/darkpack/c12g/rubber, 80),
		new /datum/data/vending_product("9mm ammo box", /obj/item/ammo_box/darkpack/c9mm, 80),
		new /datum/data/vending_product("5.56 ammo box", /obj/item/ammo_box/darkpack/c556, 80),
		new /datum/data/vending_product("PDW ammo box", /obj/item/ammo_box/darkpack/c46pdw, 80),
	)

/obj/structure/retail/police_equipment/can_shop(mob/user)
	var/datum/job/vampire/assigned_role = user.mind?.assigned_role
	if(istype(assigned_role, /datum/job/vampire/police_officer) \
		|| istype(assigned_role, /datum/job/vampire/police_sergeant) \
		|| istype(assigned_role, /datum/job/vampire/fbi) \
		|| istype(assigned_role, /datum/job/vampire/police_captain))
		return TRUE
