// Basically example items for the different brands but can be used as set-dressing

/obj/item/product
	name = "product"
	desc = "You feel an overwhelming urge to consume it."
	icon = 'modular_darkpack/modules/company_logos/icons/generic_product.dmi'
	brand = "badcode"
	abstract_type = /obj/item/product

/obj/item/product/Initialize(mapload)

	var/datum/brand/parent_brand = GLOB.all_brandnames[brand]
	name = "\improper" + parent_brand.full_name + " " + name
	icon_state = brand

	if(!isnull(parent_brand))
		color = parent_brand.company_color

	. = ..()

/obj/item/product/pentex
	brand = "pentex"

/obj/item/product/pentex/ardus
	brand = "ardus"

/obj/item/product/pentex/avalon
	brand = "avalon"

/obj/item/product/pentex/circinus
	brand = "circinus"

/obj/item/product/pentex/consolidex
	brand = "consolidex"

/obj/item/product/pentex/endron
	brand = "endron"

/obj/item/product/pentex/endron/atlas
	brand = "atlas"

/obj/item/product/pentex/harold_and_harold
	brand = "harold_and_harold"

/obj/item/product/pentex/good_house
	brand = "good_house"

/obj/item/product/pentex/hallahan
	brand = "hallahan"

/obj/item/product/pentex/herculean
	brand = "herculean"

/obj/item/product/pentex/herricks
	brand = "herricks"

/obj/item/product/pentex/king
	brand = "king"

/obj/item/product/pentex/magadon
	brand = "magadon"

/obj/item/product/pentex/magadon/aesop
	brand = "aesop"

/obj/item/product/pentex/magadon/autumn
	brand = "autumn"

/obj/item/product/pentex/nastrum
	brand = "nastrum"

/obj/item/product/pentex/omni
	brand = "omni"

/obj/item/product/pentex/otolleys
	brand = "otolleys"

/obj/item/product/pentex/black_dog
	brand = "black_dog"

/obj/item/product/pentex/rainbow
	brand = "rainbow"

/obj/item/product/pentex/tellus
	brand = "tellus"

/obj/item/product/pentex/tellus/sunburst
	brand = "sunburst"

/obj/item/product/pentex/vesuvius
	brand = "vesuvius"

/obj/item/product/pentex/young_and_smith
	brand = "young_and_smith"
