/obj/item/organ/lungs/Initialize()
	. = ..()
	AddComponent(/datum/component/selling/organ, 250, "organ", TRUE, -1, 0)
