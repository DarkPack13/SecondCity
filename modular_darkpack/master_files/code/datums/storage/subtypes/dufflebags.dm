/// DARKPACK - Duffle bag subtype; exemptions for unique VTM items
/datum/storage/duffel/darkpack
	exception_max = 2	//We don't allow for more than 2 exemptions in the bag at one time.

/datum/storage/duffel/darkpack/New(
	atom/parent,
	max_slots,
	max_specific_storage,
	max_total_storage,
)
	. = ..()
	var/static/list/exception_type_list = list(
		// Darkpack Guns - All bulky ones we allow as exemptions (i.e not allowing .50s)
		/obj/item/gun/ballistic/automatic/darkpack/ar15,
		/obj/item/gun/ballistic/automatic/darkpack/ak74,
		/obj/item/gun/ballistic/automatic/darkpack/huntrifle,
		/obj/item/gun/ballistic/automatic/darkpack/aug,
		/obj/item/gun/ballistic/rifle/darkpack/lever,
		/obj/item/gun/ballistic/automatic/darkpack/autosniper,
		/obj/item/gun/ballistic/shotgun/vampire,
		/obj/item/gun/ballistic/shotgun/vampire/doublebarrel,
		/obj/item/gun/ballistic/automatic/darkpack/autoshotgun,
		// Darkpack Melee - Allows basically all besides chainsaw and spear
		/obj/item/melee/vamp,	//Covers a small group of items/weapons
		/obj/item/fireaxe/vamp,
		/obj/item/katana/vamp,
		/obj/item/melee/sabre/rapier,
		/obj/item/claymore/machete,
		/obj/item/melee/sabre/vamp,
		/obj/item/claymore/longsword,
		/obj/item/melee/baseball_bat/vamp,
		/obj/item/shovel/vamp,
		/obj/item/instrument/eguitar/vamp,
		// Darkpack Armor - National guard and EOD armor; they're big
		/obj/item/clothing/suit/vampire/vest/army,
		/obj/item/clothing/suit/vampire/eod,
		// Deployables
		/obj/item/cardboard_cutout,
		// Storage
		/obj/item/storage/bag/money,
		// Skub
		/obj/item/skub,
		// Fish
		/obj/item/fish,
		/obj/item/fish_tank,
	)

	set_holdable(exception_hold_list = exception_type_list)

	var/list/desc = list()
	for(var/obj/item/valid_item as anything in exception_type_list)
		desc += "\a [initial(valid_item.name)]"
	can_hold_description = "\n\t[span_notice("[desc.Join("\n\t")]")]"
