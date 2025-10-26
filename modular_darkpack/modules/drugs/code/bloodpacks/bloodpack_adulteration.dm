/datum/crafting_recipe/methpack
	name = "Make Meth Adulterated Bloodpack"
	time = 25
	reqs = list(/datum/reagent/drug/methamphetamine = 30, /obj/item/reagent_containers/blood = 1)
	result = /obj/item/reagent_containers/drug/methpack
	always_available = TRUE
	category = CAT_DRUGS

/datum/crafting_recipe/morphpack_reagent
	name = "Make Morphine Adulterated Bloodpack"
	time = 25
	reqs = list(/datum/reagent/medicine/morphine = 15, /obj/item/reagent_containers/blood = 1)
	result = /obj/item/reagent_containers/drug/morphpack
	always_available = TRUE
	category = CAT_DRUGS

/datum/crafting_recipe/cokepack
	name = "Make Cocaine Adulterated Bloodpack"
	time = 25
	reqs = list(/datum/reagent/drug/methamphetamine/cocaine = 30, /obj/item/reagent_containers/blood = 1)
	result = /obj/item/reagent_containers/drug/cokepack
	always_available = TRUE
	category = CAT_DRUGS
