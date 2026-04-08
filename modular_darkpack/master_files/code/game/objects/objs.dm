/obj
	// DARKPACK Module - company_logos - If matching a /datum/brand's manufacturer, append a logo to the examine text. Element only added by default on /obj/
	var/brand


/obj/Initialize(mapload)
	. = ..()
	if(brand) // DARKPACK module - company_logos - If we don't have a brand, disregard.
		AddElement(/datum/element/corp_label, GLOB.all_brandnames[brand])
