/obj/structure/retail/leopoldite
	owner_needed = FALSE //Don't want a single obfuscating vampire to cut off all leopoldite weaponry acquisition.
	//Design philosphophy behind which weaponry to include, is to focus on weapons originating from catholic countries.
	//For example, the AUG is an Austrian weapon, and therefore may be included, but the AK74 is a Russian weapon, and will not be included on this list.
	//I'm tolerating some non-catholic weaponry, for example the hunting rifle, because if I didn't include that, the leopoldites would only have crossbows at full masquerade.
	products_list = list(
		new /datum/data/vending_product("binoculars", /obj/item/binoculars, 20),
		new /datum/data/vending_product("stake", /obj/item/vampire_stake, 10),
		new /datum/data/vending_product("full gas can", /obj/item/gas_can/full, 50),
		new /datum/data/vending_product("zippo lighter", /obj/item/lighter, 20),
		new /datum/data/vending_product("bible", /obj/item/vampirebook/bible, 20),
		new /datum/data/vending_product("cross (gold)", /obj/item/card/hunter, 20),
		new /datum/data/vending_product("cross (silver)", /obj/item/card/hunter/silver, 20),
		new /datum/data/vending_product("cross (gothic)", /obj/item/card/hunter/gothic, 20),

		//Sidearms
		new /datum/data/vending_product("elite 92G", /obj/item/gun/ballistic/automatic/pistol/darkpack/beretta, 50),
		new /datum/data/vending_product("pistol magazine (9mm)", /obj/item/ammo_box/magazine/semi9mm, 10),
		new /datum/data/vending_product("brokk 19", /obj/item/gun/ballistic/automatic/pistol/darkpack/glock19, 50),
		new /datum/data/vending_product("brokk magazine (9mm)", /obj/item/ammo_box/magazine/glock9mm, 10),
		new /datum/data/vending_product("brokk 21", /obj/item/gun/ballistic/automatic/pistol/darkpack/glock21, 80, -1, 20),
		new /datum/data/vending_product("automatic pistol magazine (.45 ACP)", /obj/item/ammo_box/magazine/glock45acp, 20, -1, 20),

		//Long guns
		//Full masq
		new /datum/data/vending_product("lever action rifle", /obj/item/gun/ballistic/rifle/darkpack/lever, 160),	//I would have removed the American weaponry here, but then there'd be no long arms at full masq.
		new /datum/data/vending_product("hunting rifle", /obj/item/gun/ballistic/automatic/darkpack/huntrifle, 200),
		new /datum/data/vending_product("rifle magazine (5.45mm)", /obj/item/ammo_box/magazine/darkpack545, 20),
		new /datum/data/vending_product("shotgun", /obj/item/gun/ballistic/shotgun/vampire, 90),
		new /datum/data/vending_product("double barrel shotgun", /obj/item/gun/ballistic/shotgun/vampire/doublebarrel, 110),
		new /datum/data/vending_product("braddock .45 submachine gun", /obj/item/gun/ballistic/automatic/darkpack/mac10, 120),
		new /datum/data/vending_product("braddock SMG magazine (.45)", /obj/item/ammo_box/magazine/darkpack45smg, 25),
		new /datum/data/vending_product("crossbow", /obj/item/gun/ballistic/shotgun/toy/crossbow/vampire, 50),

		new /datum/data/vending_product("battle Rifle", /obj/item/gun/ballistic/automatic/darkpack/fal, 200, -1, 20),
		new /datum/data/vending_product("military Battle Rifle", /obj/item/gun/ballistic/automatic/darkpack/fal/automatic, 250, -1, 14),
		new /datum/data/vending_product("battle rifle magazine (7.62x51mm)", /obj/item/ammo_box/magazine/darkpack762x51fal, 50, -1, 20),
		new /datum/data/vending_product("musket", /obj/item/gun/ballistic/automatic/darkpack/musket, 250, -1, 20),
		new /datum/data/vending_product("steyr AUG-77", /obj/item/gun/ballistic/automatic/darkpack/aug, 200, -1, 14),
		new /datum/data/vending_product("AUG magazine (5.56mm)", /obj/item/ammo_box/magazine/darkpackaug, 200, -1, 14),
		new /datum/data/vending_product("auto Sniper", /obj/item/gun/ballistic/automatic/darkpack/autosniper, 250, -1, 14),
		new /datum/data/vending_product("auto-sniper magazine (7.62 NATO)", /obj/item/ammo_box/magazine/vamp762x51PSG1, 50, -1, 14),
		new /datum/data/vending_product("HK MP5", /obj/item/gun/ballistic/automatic/darkpack/mp5, 200, -1, 14),
		new /datum/data/vending_product("MP5 magazine (9mm)", /obj/item/ammo_box/magazine/darkpack9mp5, 20, -1, 14),
		new /datum/data/vending_product("HK MP7", /obj/item/gun/ballistic/automatic/darkpack/mp7, 200, -1, 14),
		new /datum/data/vending_product("sniper", /obj/item/gun/ballistic/automatic/darkpack/sniper, 50, -1, 14),
		new /datum/data/vending_product("MP7 extended magazine (4.6mm)", /obj/item/ammo_box/magazine/darkpack/c46pdw/ext, 20, -1, 14),
		new /datum/data/vending_product("jaegerspas-XV", /obj/item/gun/ballistic/automatic/darkpack/autoshotgun, 250, -1, 9),
		new /datum/data/vending_product("flamethrower", /obj/item/liquid_flamethrower, 50, -1, 9),
		new /datum/data/vending_product("rocket launcher", /obj/item/gun/ballistic/rocketlauncher/unrestricted, 300, -1, 9),	//Might need to be at a lower masq level.
		new /datum/data/vending_product("HE rocket", /obj/item/ammo_casing/rocket, 50, -1, 9),
		new /datum/data/vending_product("HEAP rocket", /obj/item/ammo_casing/rocket/heap, 50, -1, 9),


		//Blades
		new /datum/data/vending_product("rapier", /obj/item/storage/belt/sheath/vamp/rapier, 100),
		new /datum/data/vending_product("spear", /obj/item/darkpack/spear, 100),
		new /datum/data/vending_product("silver spear", /obj/item/darkpack/spear/silver, 200, -1, 20),
		new /datum/data/vending_product("sabre", /obj/item/storage/belt/sheath/vamp/sabre, 100),
		new /datum/data/vending_product("longsword", /obj/item/storage/belt/sheath/vamp/sword, 100),
		//Silver swords would be too weak and heavy most likely if you weren't using magic. Maybe a silver dagger if you really want a new weapon for them.
		//An iron longsword would also fit well, as that would be a good weapon to fight fae with.

		//Ammo

		new	/datum/data/vending_product("5.45 ammo", /obj/item/ammo_box/darkpack/c545, 100),
		new	/datum/data/vending_product(".45 ammo", /obj/item/ammo_box/darkpack/c45acp, 70),
		new	/datum/data/vending_product(".45 silver ammo", /obj/item/ammo_box/darkpack/c45acp/silver, 80, -1, 24),
		new	/datum/data/vending_product(".45 HP ammo", /obj/item/ammo_box/darkpack/c45acp/hp, 80, -1, 14),
		new /datum/data/vending_product("9mm ammo", /obj/item/ammo_box/darkpack/c9mm, 60),
		new /datum/data/vending_product("9mm silver ammo", /obj/item/ammo_box/darkpack/c9mm/silver, 70, -1, 24),
		new /datum/data/vending_product("9mm HV ammo", /obj/item/ammo_box/darkpack/c9mm/plus, 100, -1, 9),
		new /datum/data/vending_product(".44 ammo", /obj/item/ammo_box/darkpack/c44, 80),
		new /datum/data/vending_product(".44 silver ammo", /obj/item/ammo_box/darkpack/c44/silver, 100, -1, 24),

		new /datum/data/vending_product(".50 AE ammo", /obj/item/ammo_box/darkpack/c50ae, 100, -1, 14),
		new /datum/data/vending_product(".50 BMG ammo", /obj/item/ammo_box/darkpack/c50, 100, -1, 14),
		new /datum/data/vending_product("5.56 ammo", /obj/item/ammo_box/darkpack/c556, 60, -1, 14),
		new /datum/data/vending_product("5.56 incendiary ammo", /obj/item/ammo_box/darkpack/c556/incendiary, 80, -1, 14),
		new /datum/data/vending_product("5.56 silver ammo", /obj/item/ammo_box/darkpack/c556/silver, 60, -1, 14),
		new /datum/data/vending_product("4.6mm ammo", /obj/item/ammo_box/darkpack/c46pdw, 80, -1, 14),
		new /datum/data/vending_product("12g ammo", /obj/item/ammo_box/darkpack/c12g, 60),
		new /datum/data/vending_product("12g buckshot ammo", /obj/item/ammo_box/darkpack/c12g/buck, 60),
		new /datum/data/vending_product("12g silver ammo", /obj/item/ammo_box/darkpack/c12g/silver, 80, -1, 24),
		new /datum/data/vending_product("12g dragons breath", /obj/item/ammo_box/darkpack/c12g/buck/incendiary, 100, -1, 14),
		new /datum/data/vending_product("crossbow bolts", /obj/item/ammo_box/darkpack/arrows, 10),
		new /datum/data/vending_product("7.62x51mm ammo", /obj/item/ammo_box/darkpack/c762x51mm, 80, -1, 14),
		new /datum/data/vending_product("7.62x51mm silver ammo", /obj/item/ammo_box/darkpack/c762x51mm/silver, 100, -1, 14),
		new /datum/data/vending_product("7.62x51mm incendiary ammo", /obj/item/ammo_box/darkpack/c762x51mm/incendiary, 100, -1, 14),
		new /datum/data/vending_product("musket cartridges", /obj/item/ammo_box/darkpack/c75, 60, -1, 20),
		new /datum/data/vending_product("silver musket cartridges", /obj/item/ammo_box/darkpack/c75/silver, 80, -1, 20),

		//Armor
		new /datum/data/vending_product("armored trenchcoat", /obj/item/clothing/suit/armor/hos/trenchcoat, 50),
		//Would add plate armor but don't know typepath.

		//Spanish inquisition larp
		new /datum/data/vending_product("cuirass", /obj/item/clothing/suit/vampire/vest/medieval, 50),
		new /datum/data/vending_product("medieval helmet", /obj/item/clothing/head/vampire/helmet/spain, 50),

		new /datum/data/vending_product("vest", /obj/item/clothing/suit/vampire/vest, 50, -1, 20),
		new /datum/data/vending_product("helmet", /obj/item/clothing/head/vampire/helmet, 50, -1, 20),

		new /datum/data/vending_product("army vest", /obj/item/clothing/suit/vampire/vest/army, 100, -1, 14),
		new /datum/data/vending_product("army helmet", /obj/item/clothing/head/vampire/army, 100, -1, 14),

		new /datum/data/vending_product("EOD suit", /obj/item/clothing/suit/vampire/eod, 150, -1, 9),
		new /datum/data/vending_product("EOD helmet", /obj/item/clothing/head/vampire/eod, 150, -1, 9),
	)

/obj/structure/retail/leopoldite/can_shop(mob/user)
	var/datum/job/vampire/assigned_role = user.mind?.assigned_role
	if(assigned_role && (/datum/job_department/society_of_leopold in assigned_role.departments_list))
		return TRUE
