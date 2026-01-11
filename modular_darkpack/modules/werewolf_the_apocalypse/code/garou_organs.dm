/obj/item/organ/tongue/garou
	name = "exotic tongue"
	languages_native = list(/datum/language/garou_tongue)

// Garou tongues can speak all default + garou tongue
/obj/item/organ/tongue/garou/get_possible_languages()
	return ..() + /datum/language/garou_tongue
