/obj/item/vtm_artifact/galdjum
	true_name = "Galdjum"
	true_desc = "Increases disciplines duration."
	icon_state = "galdjum"
	research_value = 10

/obj/item/vtm_artifact/galdjum/get_powers()
	. = ..()
	owner.discipline_time_plus = 25

/obj/item/vtm_artifact/galdjum/remove_powers()
	. = ..()
	owner.discipline_time_plus = 0
