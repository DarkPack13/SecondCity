/obj/item/storage/pill_bottle/ephedrine
	name = "ephedrine pill bottle"
	desc = "There is opium attention sign on the top."
	spawn_count = 10
	spawn_type = /obj/item/reagent_containers/applicator/pill/ephedrine

/obj/item/reagent_containers/applicator/pill/ephedrine
	name = "ephedrine pill"
	desc = "Used to stabilize patients."
	icon_state = "pill5"
	list_reagents = list(/datum/reagent/medicine/ephedrine = 15)
	rename_with_volume = TRUE

//Sugar pills

/datum/reagent/drug/placebatol
	name = "Placebatol"
	description = "An odorless, colorless, powdery substance that's sometimes prescribed. May not actually do anything...?"
	//reagent_state = SOLID
	color = "#f5f5f0"
	metabolization_rate = REAGENTS_METABOLISM * 0.25
	taste_description = "sugar" //effectively a sugar pill, but sugar actually has a use

/obj/item/reagent_containers/applicator/pill/placebatol
	name = "prescription pill"
	desc = "A pill composed of a white, powdery substance. Take as prescribed."
	icon_state = "pill9"
	list_reagents = list(/datum/reagent/drug/placebatol = 10)

/obj/item/storage/pill_bottle/estrogen
	name = "estrogen pill bottle"
	desc = "There are boobs on the top."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/placebatol

/obj/item/storage/pill_bottle/unknown
	name = "unknown pill bottle"
	desc = "Its unlabeled and its unclear what they would acctually treat."
	spawn_count = 5
	spawn_type = /obj/item/reagent_containers/applicator/pill/placebatol
