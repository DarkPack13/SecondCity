/obj/Initialize(mapload)
	. = ..()
	if(brand) // DARKPACK module - company_logos - If we don't have a brand, disregard.
		AddElement(/datum/element/corp_label)
