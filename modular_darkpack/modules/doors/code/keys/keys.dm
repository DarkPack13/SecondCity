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
	accesslocks = list(LOCKACCESS_CAMARILLA)
	color = "#bd3327"

/obj/item/vamp/keys/prince
	name = "prince's keys"
	accesslocks = list(
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_PRINCE,
		LOCKACCESS_CLERK,
		LOCKACCESS_CHANTRY,
		"theatre",
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#bd3327"

/obj/item/vamp/keys/sheriff
	name = "sheriff's keys"
	accesslocks = list(
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_PRINCE,
		"theatre",
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_CLERK,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#bd3327"

/obj/item/vamp/keys/clerk
	name = "clerk's keys"
	accesslocks = list(
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_CLERK,
		"theatre",
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#bd3327"

/obj/item/vamp/keys/camarilla
	name = "\improper Millenium Tower keys"
	accesslocks = list(
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CLERK,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#bd3327"

/obj/item/vamp/keys/camarilla/ghoul
	name = "Millenium Tower Employee keys"
	accesslocks = list(
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CLERK,
		LOCKACCESS_CAMARILLA
	)
	color = "#bd3327"

/obj/item/vamp/keys/archive
	name = "archive keys"
	accesslocks = list(
		LOCKACCESS_CHANTRY
	)

/obj/item/vamp/keys/regent
	name = "very archival keys"
	accesslocks = list(
		LOCKACCESS_CHANTRY,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)

/obj/item/vamp/keys/anarch
	name = "anarch keys"
	accesslocks = list(
		LOCKACCESS_ANARCH,
		"bar_delivery",
	)
	color = "#434343"

/obj/item/vamp/keys/bar
	name = "barkeeper keys"
	accesslocks = list(
		LOCKACCESS_BAR,
		LOCKACCESS_ANARCH,
		"bar_delivery",
	)
	color = "#434343"

/obj/item/vamp/keys/giovanni
	name = "mafia keys"
	accesslocks = list(
		LOCKACCESS_GIOVANNI,
		"bianchiBank"
	)

/obj/item/vamp/keys/capo
	name = "capo keys"
	accesslocks = list(
		LOCKACCESS_BANKBOSS,
		"bianchiBank",
		LOCKACCESS_GIOVANNI
	)


/obj/item/vamp/keys/baali
	name = "satanic keys"
	accesslocks = list(
		LOCKACCESS_BAALI
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
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#2c92ff"

/obj/item/vamp/keys/toreador
	name = "sexy keys"
	accesslocks = list(
		LOCKACCESS_TOREADOR,
		"toreador1",
		"toreador2",
		"toreador3",
		"toreador4"
	)
	color = "#ffa7e6"

/obj/item/vamp/keys/banuhaqim
	name = "just keys"
	accesslocks = list(
		LOCKACCESS_BANU
	)
	color = "#06053d"

/obj/item/vamp/keys/toreador/primogen
	name = "really sexy keys"
	accesslocks = list(
		LOCKACCESS_PRIMOGEN_TOREADOR,
		LOCKACCESS_TOREADOR,
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#ff2fc4"

/obj/item/vamp/keys/nosferatu
	name = "ugly keys"
	accesslocks = list(
		LOCKACCESS_NOSFERATU
	)
	color = "#93bc8e"

/obj/item/vamp/keys/nosferatu/primogen
	name = "really ugly keys"
	accesslocks = list(
		LOCKACCESS_PRIMOGEN_NOSFERATU,
		LOCKACCESS_NOSFERATU,
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#367c31"

/obj/item/vamp/keys/brujah
	name = "punk keys"
	accesslocks = list(
		LOCKACCESS_BRUJAH
	)
	color = "#ecb586"

/obj/item/vamp/keys/brujah/primogen
	name = "really punk keys"
	accesslocks = list(
		LOCKACCESS_PRIMOGEN_BRUJAH,
		LOCKACCESS_BRUJAH,
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_CAMARILLA
	)
	color = "#ec8f3e"

/obj/item/vamp/keys/ventrue
	name = "businessy keys"
	accesslocks = list(
		LOCKACCESS_VENTRUE,
		LOCKACCESS_JAZZ_CLUB
	)
	color = "#f6ffa7"

/obj/item/vamp/keys/ventrue/primogen
	name = "really businessy keys"
	accesslocks = list(
		LOCKACCESS_PRIMOGEN_VENTRUE,
		LOCKACCESS_VENTRUE,
		LOCKACCESS_JAZZ_CLUB,
		LOCKACCESS_PRIOGEN,
		LOCKACCESS_CAMARILLA,
		LOCKACCESS_JAZZ_CLUB_DELIVERY,
	)
	color = "#e8ff29"

/obj/item/vamp/keys/cappadocian
	name = "Eroded keys"
	accesslocks = list(
		LOCKACCESS_CAPPADOCIAN
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
		LOCKACCESS_CLINIC
	)

/obj/item/vamp/keys/clinics_director
	name = "clinic director keys"
	accesslocks = list(
		LOCKACCESS_CLINIC,
		"director"
	)

//===========================POLICE KEYS===========================
/obj/item/vamp/keys/police
	name = "police keys"
	accesslocks = list(
		LOCKACCESS_POLICE
	)

/obj/item/vamp/keys/dispatch
	name = "dispatcher keys"
	accesslocks = list(
		LOCKACCESS_DISPATCH
	)

/obj/item/vamp/keys/police/secure
	name = "sergeant police keys"
	accesslocks = list(
		LOCKACCESS_POLICE,
		LOCKACCESS_POLICE_SECURE
	)

/obj/item/vamp/keys/police/secure/chief
	name = "\improper Chief of Police keys"
	accesslocks = list(
		LOCKACCESS_DISPATCH,
		LOCKACCESS_POLICE,
		LOCKACCESS_POLICE_SECURE,
		LOCKACCESS_POLICE_CHIEF
	)

//===========================MISC KEYS===========================

/obj/item/vamp/keys/axes
	name = "Rusty keys"
	accesslocks = list(
		LOCKACCESS_AXE_GANG,
		LOCKACCESS_LAUNDROMAT
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
		LOCKACCESS_WOLFTECH
	)
	color = "#466a72"

/obj/item/vamp/keys/pentex
	name = EVIL_OIL_COMPANY + "  Facility keys"
	accesslocks = list(
		LOCKACCESS_PENTEX
	)
	color = "#062e03"

/obj/item/vamp/keys/pentex/leader
	name = EVIL_OIL_COMPANY + " Management keys"
	accesslocks = list(
		LOCKACCESS_PENTEX,
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
		LOCKACCESS_TRAID,
		LOCKACCESS_LAUNDROMAT
	)

/obj/item/vamp/keys/graveyard
	name = "graveyard keys"
	accesslocks = list(
		LOCKACCESS_GRAVEYARD
	)

/obj/item/vamp/keys/cleaning
	name = "cleaning keys"
	accesslocks = list(
		LOCKACCESS_CLEANING
	)

/obj/item/vamp/keys/church
	name = "church keys"
	accesslocks = list(
		"church"
	)

/obj/item/vamp/keys/supply
	name = "supply keys"
	accesslocks = list(
		LOCKACCESS_SUPPLY
	)
	color = "#434343"

/obj/item/vamp/keys/strip
	name = "strip keys"
	accesslocks = list(
		LOCKACCESS_STRIP
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
		LOCKACCESS_BAR
	)
	color = "#434343"
