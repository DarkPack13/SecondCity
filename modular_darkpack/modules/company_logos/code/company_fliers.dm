// Basically example items for the different brands but can be used as set-dressing

/obj/item/paper/flier
	name = "flier"
	desc = "It's an advertisement of some sort."
	brand = "badcode"
	abstract_type = /obj/item/paper/flier
	// What the paper says after the logo
	var/blurb = "Bad Code Inc. helps thousands of coders every year, but we're facing a never-before-seen coder surge! \
		We're looking for consultants to help locate and assist the next mistake-maker before they push to master on a friday or forget to change\
		the blurb var on /obj/item/paper/flier in modular_darkpack/modules/company_logos/code/company_fliers.dm!<br><br>\
		Call 514-BAD-CODE for more information on careers."

/obj/item/paper/flier/Initialize(mapload)
	. = ..()
	var/datum/brand/parent_brand = GLOB.all_brandnames[brand]
	if(!isnull(parent_brand))
		color = parent_brand.company_color
		add_raw_text(span_info("<span class='[parent_brand.name_span ? parent_brand.name_span : "info"]'>[parent_brand.full_name].</span><br>\
			<I>\"[parent_brand.slogan]\"</I><br><br>\
				[blurb]"))


/obj/item/paper/flier/pentex
	brand = "pentex"

/obj/item/paper/flier/pentex/ardus
	brand = "ardus"

/obj/item/paper/flier/pentex/avalon
	brand = "avalon"

/obj/item/paper/flier/pentex/circinus
	brand = "circinus"

/obj/item/paper/flier/pentex/consolidex
	brand = "consolidex"

/obj/item/paper/flier/pentex/endron
	brand = "endron"

/obj/item/paper/flier/pentex/endron/atlas
	brand = "atlas"

/obj/item/paper/flier/pentex/harold_and_harold
	brand = "harold_and_harold"

/obj/item/paper/flier/pentex/good_house
	brand = "good_house"

/obj/item/paper/flier/pentex/hallahan
	brand = "hallahan"

/obj/item/paper/flier/pentex/herculean
	brand = "herculean"

/obj/item/paper/flier/pentex/herricks
	brand = "herricks"

/obj/item/paper/flier/pentex/king
	brand = "king"

/obj/item/paper/flier/pentex/magadon
	brand = "magadon"

/obj/item/paper/flier/pentex/magadon/aesop
	brand = "aesop"

/obj/item/paper/flier/pentex/magadon/autumn
	brand = "autumn"

/obj/item/paper/flier/pentex/nastrum
	brand = "nastrum"

/obj/item/paper/flier/pentex/omni
	brand = "omni"

/obj/item/paper/flier/pentex/otolleys
	brand = "otolleys"

/obj/item/paper/flier/pentex/black_dog
	brand = "black_dog"

/obj/item/paper/flier/pentex/rainbow
	brand = "rainbow"

/obj/item/paper/flier/pentex/tellus
	brand = "tellus"

/obj/item/paper/flier/pentex/tellus/sunburst
	brand = "sunburst"

/obj/item/paper/flier/pentex/vesuvius
	brand = "vesuvius"

/obj/item/paper/flier/pentex/young_and_smith
	brand = "young_and_smith"
