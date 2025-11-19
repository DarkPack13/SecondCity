/obj/abyssrune/identification
	name = "Occult Items Identification"
	desc = "Identifies a single occult item"
	icon_state = "rune4"
	word = "WUS'ZAT"
	cost = 1

/obj/abyssrune/identification/complete()
	for(var/obj/item/vtm_artifact/VA in loc)
		if(VA)
			VA.identify()
			playsound(loc, 'sound/effects/magic/voidblink.ogg', 50, FALSE)
			qdel(src)
			return
