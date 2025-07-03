/datum/loadout_category/hands
	category_name = "Hands"
	category_ui_icon = FA_ICON_HANDS
	type_to_generate = /datum/loadout_item/hands
	tab_order = 1

/datum/loadout_item/hands
	abstract_type = /datum/loadout_item/hands

/datum/loadout_item/hands/insert_path_into_outfit(datum/outfit/outfit, mob/living/carbon/human/equipper, visuals_only = FALSE)
	if(outfit.gloves)
		LAZYADD(outfit.backpack_contents, outfit.gloves)
	outfit.gloves = item_path

/datum/loadout_item/hands/leather_gloves
	name = "Gloves (Leather)"
	item_path = /obj/item/clothing/gloves/vampire/leather

/datum/loadout_item/hands/work_gloves
	name = "Gloves (Work)"
	item_path = /obj/item/clothing/gloves/vampire/work

/datum/loadout_item/hands/cleaning_gloves
	name = "Gloves (Cleaning)"
	item_path = /obj/item/clothing/gloves/vampire/cleaning

/datum/loadout_item/hands/latex_gloves
	name = "Gloves (Latex)"
	item_path = /obj/item/clothing/gloves/vampire/latex
