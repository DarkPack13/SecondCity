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
