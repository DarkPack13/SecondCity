/obj/structure/retail/leopoldite
	products_list = list(
		new /datum/data/vending_product("binoculars", /obj/item/binoculars, 20),

		//Sidearms
		new /datum/data/vending_product("magnum revolver", /obj/item/gun/ballistic/revolver/darkpack/magnum, 200),
		new /datum/data/vending_product("Colt M1911", /obj/item/gun/ballistic/automatic/pistol/darkpack/m1911, 250),
		new /datum/data/vending_product("Elite 92G", /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta, 500),
		new /datum/data/vending_product("desert eagle", /obj/item/gun/ballistic/automatic/pistol/darkpack/deagle, 600),

		//Long guns
		new /datum/data/vending_product("lever action rifle", /obj/item/gun/ballistic/rifle/darkpack/lever, 160),
		new /datum/data/vending_product("hunting rifle", /obj/item/gun/ballistic/automatic/darkpack/huntrifle, 200),
		new /datum/data/vending_product("shotgun", /obj/item/gun/ballistic/shotgun/vampire, 90),
		new /datum/data/vending_product("double barrel shotgun", /obj/item/gun/ballistic/shotgun/vampire/doublebarrel, 110),
		new /datum/data/vending_product("Braddock .45 submachine gun", /obj/item/gun/ballistic/automatic/darkpack/mac10, 120),

		//Ammo
		new	/datum/data/vending_product("5.45 ammo", /obj/item/ammo_box/darkpack/c545, 1000),
		new	/datum/data/vending_product(".45 ammo", /obj/item/ammo_box/darkpack/c45acp, 700),
		new /datum/data/vending_product("9mm ammo", /obj/item/ammo_box/darkpack/c9mm, 600),
		new /datum/data/vending_product(".44 ammo", /obj/item/ammo_box/darkpack/c44, 800),

		//Armor
			/obj/item/clothing/suit/armor/hos/trenchcoat
			//Would add plate armor but don't know typepath.
	)

/obj/structure/retail/leopoldite/can_shop(mob/user)
	var/datum/job/vampire/assigned_role = user.mind?.assigned_role
	if(assigned_role && (/datum/job_department/society_of_leopold in assigned_role.departments_list))
		return TRUE
