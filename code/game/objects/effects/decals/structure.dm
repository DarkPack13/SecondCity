/obj/effect/decal/fakelattice
	name = "lattice"
	desc = "A lightweight support lattice."
	icon = 'icons/obj/smooth_structures/lattice.dmi'
	icon_state = "lattice-255"
	density = TRUE

// DARKPACK EDIT ADD START
/obj/effect/decal/fakelattice/NeverShouldHaveComeHere(turf/here_turf)
	return isclosedturf(here_turf)
// DARKPACK EDIT ADD END
