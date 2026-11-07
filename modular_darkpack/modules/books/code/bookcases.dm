/obj/structure/bookcase/random/kindred
	name = "bookcase (Kindred)"
	random_category = BOOK_CATEGORY_KINDRED

/obj/structure/bookcase/random/lupine
	name = "bookcase (Lupine)"
	random_category = BOOK_CATEGORY_LUPINE

/obj/structure/bookcase/random/kueijin
	name = "bookcase (Kuei-Jin)"
	random_category = BOOK_CATEGORY_KUEIJIN

/obj/structure/bookcase/random/magi
	name = "bookcase (Magi)"
	random_category = BOOK_CATEGORY_MAGI

/obj/structure/bookcase/random/fae
	name = "bookcase (Fae)"
	random_category = BOOK_CATEGORY_FAE

/obj/structure/bookcase/random/shadowlands
	name = "bookcase (Shadowlands)"
	random_category = BOOK_CATEGORY_SHADOWLANDS

/obj/structure/bookcase/random/hunter
	name = "bookcase (Hunters)"
	random_category = BOOK_CATEGORY_HUNTERS

/obj/structure/bookcase/random/mummy
	name = "bookcase (Mummy)"
	random_category = BOOK_CATEGORY_MUMMY

/obj/structure/bookcase/random/infernal
	name = "bookcase (Infernal)"
	random_category = BOOK_CATEGORY_INFERNAL

/datum/controller/subsystem/library/New()
	. = ..()
	var/list/splat_categories = list(
		BOOK_CATEGORY_KINDRED,
		BOOK_CATEGORY_LUPINE,
		BOOK_CATEGORY_KUEIJIN,
		BOOK_CATEGORY_MAGI,
		BOOK_CATEGORY_FAE,
		BOOK_CATEGORY_SHADOWLANDS,
		BOOK_CATEGORY_HUNTERS,
		BOOK_CATEGORY_MUMMY,
		BOOK_CATEGORY_INFERNAL,
	)
	search_categories += splat_categories
	upload_categories += splat_categories
