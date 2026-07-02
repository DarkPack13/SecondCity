/obj/item/coin/iron/obolus
	name = "obolus"
	desc = "A grayish and pale blue coin which emits a soft dusk-like light. When you touch it, it appears to groan and wail in sorrow quietly..."

/obj/item/coin/iron/obolus/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/selling, 700, "artifact", FALSE, 0, 10, TRUE)
