/datum/crafting_recipe/weedpack
	name = "Sort Weed"
	time = 10
	reqs = list(/obj/item/food/vampire/weed = 1)
	result = /obj/item/weedpack
	always_available = TRUE
	category = CAT_DRUGS

/datum/crafting_recipe/weed_blunt
	name = "Roll Blunt"
	time = 10
	reqs = list(/obj/item/weedpack = 1, /obj/item/paper = 1)
	result = /obj/item/clothing/mask/cigarette/rollie/cannabis
	always_available = TRUE
	category = CAT_DRUGS
