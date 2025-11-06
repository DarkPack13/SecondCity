/obj/item/vamp/keys
	name = "\improper keys"
	desc = "Those can open some doors."
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	icon_state = "keys"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	armor_type = /datum/armor/keys
	resistance_flags = FIRE_PROOF | ACID_PROOF
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')

	var/list/accesslocks = list(
		"nothing"
	)
	var/roundstart_fix = FALSE

/datum/armor/keys
	fire = 100
	acid = 100

//===========================VAMPIRE KEYS===========================
/obj/item/vamp/keys/camarilla
	name = "\improper Camarilla keys"
	accesslocks = list("camarilla")
	color = "#bd3327"

/obj/item/vamp/keys/prince
	name = "prince's keys"
	accesslocks = list(
		"camarilla",
		"prince",
		"clerk",
		"chantry",
		"theatre",
		"milleniumCommon",
		"primogen",
		"millenium_delivery",
	)
	color = "#bd3327"

/obj/item/vamp/keys/sheriff
	name = "sheriff's keys"
	accesslocks = list(
		"camarilla",
		"prince",
		"theatre",
		"milleniumCommon",
		"primogen",
		"clerk",
		"millenium_delivery",
	)
	color = "#bd3327"

/obj/item/vamp/keys/clerk
	name = "clerk's keys"
	accesslocks = list(
		"camarilla",
		"clerk",
		"theatre",
		"milleniumCommon",
		"primogen",
		"millenium_delivery",
	)
	color = "#bd3327"

/obj/item/vamp/keys/camarilla
	name = "\improper Millenium Tower keys"
	accesslocks = list(
		"milleniumCommon",
		"clerk",
		"camarilla",
		"millenium_delivery",
	)
	color = "#bd3327"

/obj/item/vamp/keys/camarilla/ghoul
	name = "Millenium Tower Employee keys"
	accesslocks = list(
		"milleniumCommon",
		"clerk",
		"camarilla"
	)
	color = "#bd3327"

/obj/item/vamp/keys/archive
	name = "archive keys"
	accesslocks = list(
		"chantry"
	)

/obj/item/vamp/keys/regent
	name = "very archival keys"
	accesslocks = list(
		"chantry",
		"milleniumCommon",
		"primogen",
		"camarilla",
		"millenium_delivery",
	)

/obj/item/vamp/keys/anarch
	name = "anarch keys"
	accesslocks = list(
		"anarch",
		"bar_delivery",
	)
	color = "#434343"

/obj/item/vamp/keys/bar
	name = "barkeeper keys"
	accesslocks = list(
		"bar",
		"anarch",
		"bar_delivery",
	)
	color = "#434343"

/obj/item/vamp/keys/giovanni
	name = "mafia keys"
	accesslocks = list(
		"giovanni",
		"bianchiBank"
	)

/obj/item/vamp/keys/capo
	name = "capo keys"
	accesslocks = list(
		"bankboss",
		"bianchiBank",
		"giovanni"
	)


/obj/item/vamp/keys/baali
	name = "satanic keys"
	accesslocks = list(
		"baali"
	)

/obj/item/vamp/keys/daughters
	name = "eclectic keys"
	accesslocks = list(
		"daughters"
	)

/obj/item/vamp/keys/salubri
	name = "conspiracy keys"
	accesslocks = list(
		"salubri"
	)

/obj/item/vamp/keys/old_clan_tzimisce
	name = "regal keys"
	accesslocks = list(
		"old_clan_tzimisce"
	)

/obj/item/vamp/keys/malkav
	name = "insane keys"
	accesslocks = list(
		"malkav"
	)
	color = "#8cc4ff"

/obj/item/vamp/keys/malkav/primogen
	name = "really insane keys"
	accesslocks = list(
		"primMalkav",
		"malkav",
		"primogen",
		"milleniumCommon",
		"camarilla",
		"millenium_delivery",
	)
	color = "#2c92ff"

/obj/item/vamp/keys/toreador
	name = "sexy keys"
	accesslocks = list(
		"toreador",
		"toreador1",
		"toreador2",
		"toreador3",
		"toreador4"
	)
	color = "#ffa7e6"

/obj/item/vamp/keys/banuhaqim
	name = "just keys"
	accesslocks = list(
		"banuhaqim"
	)
	color = "#06053d"

/obj/item/vamp/keys/toreador/primogen
	name = "really sexy keys"
	accesslocks = list(
		"primToreador",
		"toreador",
		"primogen",
		"milleniumCommon",
		"camarilla",
		"millenium_delivery",
	)
	color = "#ff2fc4"

/obj/item/vamp/keys/nosferatu
	name = "ugly keys"
	accesslocks = list(
		"nosferatu"
	)
	color = "#93bc8e"

/obj/item/vamp/keys/nosferatu/primogen
	name = "really ugly keys"
	accesslocks = list(
		"primNosferatu",
		"nosferatu",
		"primogen",
		"milleniumCommon",
		"camarilla",
		"millenium_delivery",
	)
	color = "#367c31"

/obj/item/vamp/keys/brujah
	name = "punk keys"
	accesslocks = list(
		"brujah"
	)
	color = "#ecb586"

/obj/item/vamp/keys/brujah/primogen
	name = "really punk keys"
	accesslocks = list(
		"primBrujah",
		"brujah",
		"primogen",
		"milleniumCommon",
		"camarilla"
	)
	color = "#ec8f3e"

/obj/item/vamp/keys/ventrue
	name = "businessy keys"
	accesslocks = list(
		"ventrue",
		"milleniumCommon"
	)
	color = "#f6ffa7"

/obj/item/vamp/keys/ventrue/primogen
	name = "really businessy keys"
	accesslocks = list(
		"primVentrue",
		"ventrue",
		"milleniumCommon",
		"primogen",
		"camarilla",
		"millenium_delivery",
	)
	color = "#e8ff29"

/obj/item/vamp/keys/cappadocian
	name = "Eroded keys"
	accesslocks = list(
		"cappadocian"
	)
	color = "#99620e"

/obj/item/vamp/keys/sabbat
	name = "Dirty keys"
	accesslocks = list(
		"sabbat"
	)
	color = "#6a2e1d"

//===========================CLINIC KEYS===========================
/obj/item/vamp/keys/clinic
	name = "clinic keys"
	accesslocks = list(
		"clinic"
	)

/obj/item/vamp/keys/clinics_director
	name = "clinic director keys"
	accesslocks = list(
		"clinic",
		"director"
	)

//===========================POLICE KEYS===========================
/obj/item/vamp/keys/police
	name = "police keys"
	accesslocks = list(
		"police"
	)

/obj/item/vamp/keys/dispatch
	name = "dispatcher keys"
	accesslocks = list(
		"dispatch"
	)

/obj/item/vamp/keys/police/secure
	name = "sergeant police keys"
	accesslocks = list(
		"police",
		"police_secure"
	)

/obj/item/vamp/keys/police/secure/chief
	name = "\improper Chief of Police keys"
	accesslocks = list(
		"dispatch",
		"police",
		"police_secure",
		"police_chief"
	)

//===========================MISC KEYS===========================

/obj/item/vamp/keys/axes
	name = "Rusty keys"
	accesslocks = list(
		"axes",
		"laundromat"
	)

//===========================GAROU KEYS===========================

/obj/item/vamp/keys/nps
	name = "Park Service keys"
	accesslocks = list(
		"nps"
	)
	color = "#1e7531"

/obj/item/vamp/keys/techstore
	name = "Tech Store keys"
	accesslocks = list(
		"wolftech"
	)
	color = "#466a72"

/obj/item/vamp/keys/pentex
	name = "Endron Facility keys"
	accesslocks = list(
		"pentex"
	)
	color = "#062e03"

/obj/item/vamp/keys/pentex/leader
	name = "Endron Management keys"
	accesslocks = list(
		"pentex",
		"pentexleader"
	)
	color = "#062e03"

/obj/item/vamp/keys/children_of_gaia
	name = "Food Pantry keys"
	accesslocks = list(
		"coggie"
	)
	color = "#339933"

//===========================MISC KEYS===========================

/obj/item/vamp/keys/triads
	name = "rusty keys"
	accesslocks = list(
		"triad",
		"laundromat"
	)

/obj/item/vamp/keys/graveyard
	name = "graveyard keys"
	accesslocks = list(
		"graveyard"
	)

/obj/item/vamp/keys/cleaning
	name = "cleaning keys"
	accesslocks = list(
		"cleaning"
	)

/obj/item/vamp/keys/church
	name = "church keys"
	accesslocks = list(
		"church"
	)

/obj/item/vamp/keys/supply
	name = "supply keys"
	accesslocks = list(
		"supply"
	)
	color = "#434343"

/obj/item/vamp/keys/strip
	name = "strip keys"
	accesslocks = list(
		"strip"
	)

/obj/item/vamp/keys/taxi
	name = "taxi keys"
	accesslocks = list(
		"taxi"
	)
	color = "#fffb8b"


/obj/item/vamp/keys/anarch_limited
	name = "Barkeeper keys"
	accesslocks = list(
		"biker_bar"
	)
	color = "#434343"
