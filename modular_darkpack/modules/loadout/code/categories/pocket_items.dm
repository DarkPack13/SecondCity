/datum/loadout_category/general
	category_name = "General"
	category_ui_icon = FA_ICON_VEST
	type_to_generate = /datum/loadout_item/general
	tab_order = /datum/loadout_category/head::tab_order + 1

/datum/loadout_item/general
	abstract_type = /datum/loadout_item/general

// Dice
/datum/loadout_item/general/d20
	name = "d20"
	item_path = /obj/item/dice/d20

// Lipsticks
/datum/loadout_item/general/lipstick_black
	name = "Lipstick (Black)"
	item_path = /obj/item/lipstick/black

/datum/loadout_item/general/lipstick_red
	name = "Lipstick (Red)"
	item_path = /obj/item/lipstick

// Lighters
/datum/loadout_item/general/cheap_lighter
	name = "Lighter (Cheap)"
	item_path = /obj/item/lighter/greyscale

/datum/loadout_item/general/zippo_lighter
	name = "Lighter (Zippo)"
	item_path = /obj/item/lighter

// Pens
/datum/loadout_item/general/pen
	name = "Pen (Black)"
	item_path = /obj/item/pen

/datum/loadout_item/general/pen_fourcolor
	name = "Pen (Four Color)"
	item_path = /obj/item/pen/fourcolor

/datum/loadout_item/general/pen_fountain
	name = "Pen (Fountain)"
	item_path = /obj/item/pen/fountain

// Cards
/datum/loadout_item/general/card_playing
	name = "Deck of Cards (Playing)"
	item_path = /obj/item/toy/cards/deck

/datum/loadout_item/general/card_tarot
	name = "Deck of Cards (Tarot)"
	item_path = /obj/item/toy/cards/deck/tarot

/datum/loadout_item/general/card_kotahi
	name = "Deck of Cards (Kotahi)"
	item_path = /obj/item/toy/cards/deck/kotahi

// Misc
/datum/loadout_item/general/spray_can
	name = "Spray Can"
	item_path = /obj/item/toy/crayon/spraycan

/datum/loadout_item/general/hair_spray
	name = "Hair Spray"
	item_path = /obj/item/dyespray

/datum/loadout_item/general/pride
	name = "Pride Pin"
	item_path = /obj/item/clothing/accessory/pride
	can_be_reskinned = TRUE

/datum/loadout_item/general/flashlight
    name = "Flashlight"
    item_path = /obj/item/flashlight

/*
/datum/loadout_item/general/phone
    name = "Phone"
    item_path = /obj/item/vamp/phone

/datum/loadout_item/general/wristwatch
    name = "Wrist watch"
    item_path = /obj/item/watch
*/
