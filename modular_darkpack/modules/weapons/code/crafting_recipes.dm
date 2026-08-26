/datum/crafting_recipe/stake
	name = "Stake"
	time = 50
	reqs = list(/obj/item/stack/sheet/mineral/wood = 2)
	result = /obj/item/vampire_stake
	category = CAT_WEAPON_MELEE

/datum/crafting_recipe/remington
	name = "Remington Supressor Attachment"
	time = 50
	reqs = list(/obj/item/suppressor/darkpack_oil = 1, /obj/item/gun/ballistic/shotgun/vampire/remington = 1)
	result = /obj/item/gun/ballistic/shotgun/vampire/remington/silenced
	category = CAT_WEAPON_RANGED

/datum/crafting_recipe/remington_sawn
	name = "Sawn-Off Remington Supressor Attachment"
	time = 50
	reqs = list(/obj/item/suppressor/darkpack_oil = 1, /obj/item/gun/ballistic/shotgun/vampire/remington/sawnoff = 1)
	result = /obj/item/gun/ballistic/shotgun/vampire/remington/silenced/sawnoff
	category = CAT_WEAPON_RANGED
