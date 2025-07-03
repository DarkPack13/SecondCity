/obj/effect/landmark/latejoin_masquerade
	name = "JoinLate"

/obj/effect/landmark/latejoin_masquerade/Initialize(mapload)
	. = ..()

	GLOB.masquerade_latejoin += src

/obj/effect/landmark/latejoin_masquerade/Destroy()
	. = ..()

	GLOB.masquerade_latejoin -= src
