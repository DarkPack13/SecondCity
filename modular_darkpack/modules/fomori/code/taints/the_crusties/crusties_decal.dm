/obj/effect/decal/cleanable/crustie
	name = "dead skin flakes"
	desc = "Disgusting."
	beauty = -50
	icon = 'modular_darkpack/modules/fomori/icons/the_crusties.dmi'
	icon_state = "crustie"
	/// The mob we use for DNA
	var/mob/living/living_source

/obj/effect/decal/cleanable/crustie/Initialize(mapload)
	. = ..()
	var/matrix/M = matrix()
	M.Turn(rand(0, 360))
	transform = M
	if(living_source)
		add_blood_DNA(living_source.get_blood_dna_list())

/obj/effect/decal/cleanable/crustie/over_window // special layer/plane set to appear on windows
	layer = ABOVE_WINDOW_LAYER
	plane = GAME_PLANE
	vis_flags = VIS_INHERIT_PLANE
	alpha = 180
	is_mopped = FALSE

/obj/effect/decal/cleanable/crustie/over_window/NeverShouldHaveComeHere(turf/here_turf)
	return isgroundlessturf(here_turf)
