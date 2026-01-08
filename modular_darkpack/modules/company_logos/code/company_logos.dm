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

/datum/element/corp_label/Attach(datum/target)
	. = ..()
	if(!isatom(target))
		return ELEMENT_INCOMPATIBLE

	var/atom/product = target

	if(!product.brand)
		return ELEMENT_INCOMPATIBLE

	our_brand = GLOB.all_brandnames[product.brand]

	RegisterSignal(target, COMSIG_ATOM_EXAMINE, PROC_REF(on_examine))

/datum/element/corp_label/Detach(datum/target)
	UnregisterSignal(target, list(COMSIG_ATOM_EXAMINE))
	return ..()

/datum/element/corp_label/proc/on_examine(datum/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/logo = "[icon2html(our_brand.logo_icon, user, our_brand.manufacturer, extra_classes = "corplogo")]"
	examine_list += span_info("<br>[logo]<br>Brought to you by <span class='[our_brand.name_span ? our_brand.name_span : "info"]'>[our_brand.full_name].</span>")

	if(our_brand.slogan)
		examine_list += span_notice("<I>\"[our_brand.slogan]\"</I>")

/datum/brand
	var/manufacturer = "badcode"
	var/full_name = "Bad Code Inc."
	var/slogan = "Bad Code Inc.: Telling America's Coders they screwed up since 1970."
	var/name_span = "hypnophrase"
	var/logo_icon = 'modular_darkpack/modules/company_logos/icons/corp_logos.dmi'
	abstract_type = /datum/brand

/datum/brand/pentex
	manufacturer = "pentex"
	full_name = EVIL_COMPANY
	slogan = "Pentex: Making All The Really Tough Decisions For You!"
	name_span = "corp_label_pentex"

/datum/brand/pentex/ardus
	manufacturer = "ardus"
	full_name = EVIL_TRASH_COMPANY
	slogan = "Keeping America's wilderness clean!"
	name_span = "corp_label_ardus"

/datum/brand/pentex/avalon
	manufacturer = "avalon"
	full_name = EVIL_TOY_COMPANY
	slogan = "Blast off to to Fun!"
	name_span = "corp_label_avalon"

/datum/brand/pentex/circinus
	manufacturer = "circinus"
	full_name = EVIL_CIGARETTE_COMPANY
	slogan = "The best taste in the tent."
	name_span = "corp_label_circinus"

/datum/brand/pentex/consolidex
	manufacturer = "consolidex"
	full_name = EVIL_INVESTMENT_COMPANY
	slogan = "Portfolio simplified."
	name_span = "corp_label_consolidex"

/datum/brand/pentex/endron
	manufacturer = "endron"
	full_name = EVIL_OIL_COMPANY
	slogan = "For a greener tomorrow!"
	name_span = "corp_label_endron"

/datum/brand/pentex/endron/atlas
	manufacturer = "atlas"
	full_name = EVIL_NUCLEAR_COMPANY
	slogan = "Atlas: Providers for Our Future."

/datum/brand/pentex/harold_and_harold
	manufacturer = "harold_and_harold"
	full_name = EVIL_MINING_COMPANY
	slogan = "Finding what makes the world work, underground."
	name_span = "corp_label_harold"

/datum/brand/pentex/good_house
	manufacturer = "good_house"
	full_name = EVIL_PAPER_COMPANY
	slogan = "Sustainable stationary for a sustainable future."
	name_span = "corp_label_goodhouse"

/datum/brand/pentex/hallahan
	manufacturer = "hallahan"
	full_name = EVIL_FISHING_COMPANY
	slogan = "Bounty of the sea straight to your plate."
	name_span = "corp_label_hallahan"

/datum/brand/pentex/herculean
	manufacturer = "herculean"
	full_name = EVIL_HANDGUN_COMPANY
	slogan = "No labour too great for a Herculean."
	name_span = "corp_label_herculean"

/datum/brand/pentex/herricks
	manufacturer = "herricks"
	full_name = EVIL_GROCERY_COMPANY
	slogan = "A full pantry without costing a full wallet."
	name_span = "corp_label_herricks"

/datum/brand/pentex/king
	manufacturer = "king"
	full_name = EVIL_LIQUOR_COMPANY
	slogan = "Nobody is better at brewing than the King."
	name_span = "corp_label_king"

/datum/brand/pentex/magadon
	manufacturer = "magadon"
	full_name = EVIL_PHARMA_COMPANY
	slogan = "Magadon: building a better you."
	name_span = "corp_label_magadon"

/datum/brand/pentex/magadon/aesop
	manufacturer = "aesop"
	full_name = EVIL_COSMETICS_COMPANY
	slogan = "Humane testing for Human needs."

/datum/brand/pentex/magadon/autumn
	manufacturer = "autumn"
	full_name = EVIL_HOSPITAL_COMPANY
	slogan = "Let our family care for your family."

/datum/brand/pentex/nastrum
	manufacturer = "nastrum"
	full_name = EVIL_AVIATION_COMPANY
	slogan = "Safety in efficiency."
	name_span = "corp_label_nastrum"

/datum/brand/pentex/omni
	manufacturer = "omni"
	full_name = EVIL_TELEVISION_COMPANY
	slogan = "Omni: Entertainment at your fingertips."
	name_span = "corp_label_omni"

/datum/brand/pentex/otolleys
	manufacturer = "otolleys"
	full_name = EVIL_FAST_FOOD_COMPANY
	slogan = "The family place."
	name_span = "corp_label_otolleys"

/datum/brand/pentex/black_dog
	manufacturer = "black_dog"
	full_name = EVIL_TTRPG_COMPANY
	slogan = "Bring some Shadow to your table."
	name_span = "corp_label_blackdog"

/datum/brand/pentex/rainbow
	manufacturer = "rainbow"
	full_name = EVIL_PLASTIC_COMPANY
	slogan = "Materials for the whole spectrum of products."
	name_span = "corp_label_rainbow"

/datum/brand/pentex/tellus
	manufacturer = "tellus"
	full_name = EVIL_COMPUTER_COMPANY
	slogan = "Tellus: Virtual worlds you could fall into."
	name_span = "corp_label_tellus"

/datum/brand/pentex/tellus/sunburst
	manufacturer = "sunburst"
	full_name = EVIL_COMPUTER_COMPANY_2
	slogan = "Computer parts should be sustainable. At Sunburst, they are."

/datum/brand/pentex/vesuvius
	manufacturer = "vesuvius"
	full_name = EVIL_PUBLISHING_COMPANY
	slogan = "Nobody tells a story like Vesuvius."
	name_span = "corp_label_vesuvius"

/datum/brand/pentex/young_and_smith
	manufacturer = "young_and_smith"
	full_name = EVIL_FOOD_COMPANY
	slogan = "Make your grocery trips simpler. Ask for Young and Smith."
	name_span = "corp_label_young"
