GLOBAL_LIST_INIT(all_brands, init_subtypes_w_path_keys(/datum/brand, list()))
GLOBAL_LIST_INIT(all_brandnames, brand_list_by_name())

/proc/brand_list_by_name()
	var/list/brand_list = GLOB.all_brands

	for(var/path in brand_list)
		var/datum/brand/this_brand = brand_list[path]
		brand_list[this_brand.manufacturer] = this_brand
	return brand_list

/datum/element/corp_label
	var/datum/brand/our_brand = /datum/brand
	element_flags = ELEMENT_BESPOKE
	argument_hash_start_idx = 1

/datum/element/corp_label/Attach(datum/target, datum/brand/my_brand)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	var/atom/product = target

	if(!product.brand)
		return ELEMENT_INCOMPATIBLE

	our_brand = my_brand

	if(isnull(my_brand))
		our_brand = /datum/brand

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))
	RegisterSignal(target, COMSIG_ATOM_EXAMINE_MORE, PROC_REF(on_examine_more))

/datum/element/corp_label/Detach(datum/target)
	UnregisterSignal(target, list(COMSIG_ATOM_EXAMINE))
	return ..()

/datum/element/corp_label/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	examine_list += span_notice("<br>This item is <span class='[our_brand.name_span ? our_brand.name_span : "info"]'>branded.</span>. [EXAMINE_HINT("Look closer")] for more information.")

/datum/element/corp_label/proc/on_examine_more(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/logo
	if(our_brand.render_logo)
		logo = "[icon2html(our_brand.logo_icon, user, our_brand.manufacturer, extra_classes = "corplogo")]"

	examine_list += span_info("[logo ? "[logo]<br>" : ""]Brought to you by <span class='[our_brand.name_span ? our_brand.name_span : "info"]'>[our_brand.full_name].</span>")

	if(our_brand.slogan)
		examine_list += span_notice("<I>\"[our_brand.slogan]\"</I>")

/datum/brand
	abstract_type = /datum/brand

	// Used to index the brand and reference the icon_state
	var/manufacturer = "badcode"
	// The full, plain-text name of the company.
	var/full_name = "Bad Code Inc."
	// Company slogan. Displayed alongside the logo in most cases.
	var/slogan = "Bad Code Inc.: Telling America's Coders they screwed up since 1970."
	// Formatting applied to the name in item descriptions
	var/name_span = "hypnophrase"
	// The icon file we're grabbing our icon_state from. Default dimensions in this file are 300x110.
	var/logo_icon = 'modular_darkpack/modules/company_logos/icons/corp_logos.dmi'
	// If FALSE, skip rendering the logo in examine text.
	var/render_logo = TRUE
	// Company color used for coloring certain items that change depending on brand
	var/company_color = COLOR_ADMIN_PINK

/datum/brand/pentex
	manufacturer = "pentex"
	full_name = EVIL_COMPANY
	slogan = "Pentex: Making All The Really Tough Decisions For You!"
	name_span = "corp_label_pentex"
	company_color = COLOR_CORP_PENTEX

/datum/brand/pentex/ardus
	manufacturer = "ardus"
	full_name = EVIL_TRASH_COMPANY
	slogan = "Keeping America's wilderness clean!"
	name_span = "corp_label_ardus"
	company_color = COLOR_CORP_ARDUS

/datum/brand/pentex/avalon
	manufacturer = "avalon"
	full_name = EVIL_TOY_COMPANY
	slogan = "Blast off to Fun!"
	name_span = "corp_label_avalon"
	company_color = COLOR_CORP_AVALON

/datum/brand/pentex/circinus
	manufacturer = "circinus"
	full_name = EVIL_CIGARETTE_COMPANY
	slogan = "The best taste in the tent."
	name_span = "corp_label_circinus"
	company_color = COLOR_CORP_CIRCINUS

/datum/brand/pentex/consolidex
	manufacturer = "consolidex"
	full_name = EVIL_INVESTMENT_COMPANY
	slogan = "Portfolio simplified."
	name_span = "corp_label_consolidex"
	company_color = COLOR_CORP_CONSOLIDEX

/datum/brand/pentex/endron
	manufacturer = "endron"
	full_name = EVIL_OIL_COMPANY
	slogan = "For a greener tomorrow!"
	name_span = "corp_label_endron"
	company_color = COLOR_CORP_ENDRON

/datum/brand/pentex/endron/atlas
	manufacturer = "atlas"
	full_name = EVIL_NUCLEAR_COMPANY
	slogan = "Atlas: Providers for Our Future."
	render_logo = FALSE

/datum/brand/pentex/harold_and_harold
	manufacturer = "harold_and_harold"
	full_name = EVIL_MINING_COMPANY
	slogan = "Finding what makes the world work, underground."
	name_span = "corp_label_harold_harold"
	company_color = COLOR_CORP_HAROLD_HAROLD

/datum/brand/pentex/good_house
	manufacturer = "good_house"
	full_name = EVIL_PAPER_COMPANY
	slogan = "Sustainable stationary for a sustainable future."
	name_span = "corp_label_good_house"
	company_color = COLOR_CORP_GOOD_HOUSE

/datum/brand/pentex/hallahan
	manufacturer = "hallahan"
	full_name = EVIL_FISHING_COMPANY
	slogan = "Bounty of the sea straight to your plate."
	name_span = "corp_label_hallahan"
	company_color = COLOR_CORP_HALLAHAN

/datum/brand/pentex/herculean
	manufacturer = "herculean"
	full_name = EVIL_HANDGUN_COMPANY
	slogan = "No labour too great for a Herculean."
	name_span = "corp_label_herculean"
	company_color = COLOR_CORP_HERCULEAN

/datum/brand/pentex/herricks
	manufacturer = "herricks"
	full_name = EVIL_GROCERY_COMPANY
	slogan = "A full pantry without costing a full wallet."
	name_span = "corp_label_herricks"
	company_color = COLOR_CORP_HERRICKS

/datum/brand/pentex/king
	manufacturer = "king"
	full_name = EVIL_LIQUOR_COMPANY
	slogan = "Nobody is better at brewing than the King."
	name_span = "corp_label_king"
	company_color = COLOR_CORP_KING

/datum/brand/pentex/magadon
	manufacturer = "magadon"
	full_name = EVIL_PHARMA_COMPANY
	slogan = "Magadon: building a better you."
	name_span = "corp_label_magadon"
	company_color = COLOR_CORP_MAGADON

/datum/brand/pentex/magadon/aesop
	manufacturer = "aesop"
	full_name = EVIL_COSMETICS_COMPANY
	slogan = "Humane testing for Human needs."
	render_logo = FALSE

/datum/brand/pentex/magadon/autumn
	manufacturer = "autumn"
	full_name = EVIL_HOSPITAL_COMPANY
	slogan = "Let our family care for your family."
	render_logo = FALSE

/datum/brand/pentex/nastrum
	manufacturer = "nastrum"
	full_name = EVIL_AVIATION_COMPANY
	slogan = "Safety in efficiency."
	name_span = "corp_label_nastrum"
	company_color = COLOR_CORP_NASTRUM

/datum/brand/pentex/omni
	manufacturer = "omni"
	full_name = EVIL_TELEVISION_COMPANY
	slogan = "Omni: Entertainment at your fingertips."
	name_span = "corp_label_omni_tv"
	company_color = COLOR_CORP_OMNI_TV
#warn O'TOLLEY'S LOGO NEEDED
/datum/brand/pentex/otolleys
	manufacturer = "otolleys"
	full_name = EVIL_FAST_FOOD_COMPANY
	slogan = "The family place."
	name_span = "corp_label_otolleys"
	company_color = COLOR_CORP_OTOLLEYS

#warn BLACK DOG LOGO NEEDED
/datum/brand/pentex/black_dog
	manufacturer = "black_dog"
	full_name = EVIL_TTRPG_COMPANY
	slogan = "Bring some Shadow to your table."
	name_span = "corp_label_black_dog"
	company_color = COLOR_CORP_BLACK_DOG

/datum/brand/pentex/rainbow
	manufacturer = "rainbow"
	full_name = EVIL_PLASTIC_COMPANY
	slogan = "Materials for the whole spectrum of products."
	name_span = "corp_label_rainbow"
	company_color = COLOR_CORP_RAINBOW_INC

/datum/brand/pentex/tellus
	manufacturer = "tellus"
	full_name = EVIL_COMPUTER_COMPANY
	slogan = "Tellus: Virtual worlds you could fall into."
	name_span = "corp_label_tellus"
	company_color = COLOR_CORP_TELLUS

/datum/brand/pentex/tellus/sunburst
	manufacturer = "sunburst"
	full_name = EVIL_COMPUTER_COMPANY_2
	slogan = "Computer parts should be sustainable. At Sunburst, they are."
	render_logo = FALSE

/datum/brand/pentex/vesuvius
	manufacturer = "vesuvius"
	full_name = EVIL_PUBLISHING_COMPANY
	slogan = "Nobody tells a story like Vesuvius."
	name_span = "corp_label_vesuvius"
	company_color = COLOR_CORP_VESUVIUS

/datum/brand/pentex/young_and_smith
	manufacturer = "young_and_smith"
	full_name = EVIL_FOOD_COMPANY
	slogan = "Make your grocery trips simpler. Ask for Young and Smith."
	name_span = "corp_label_young_smith"
	company_color = COLOR_CORP_YOUNG_SMITH
