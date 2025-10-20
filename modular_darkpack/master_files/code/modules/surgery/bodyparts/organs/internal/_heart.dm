/obj/item/organ/heart/Initialize()
	. = ..()
	AddComponent(/datum/component/selling/organ, 400, "organ", TRUE, -1, 0)
