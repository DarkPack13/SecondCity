/obj/item/vtm_artifact/galdjum
	true_name = "Galdjum"
	true_desc = "Increases disciplines duration."
	icon_state = "galdjum"
	research_value = 10

/obj/item/vtm_artifact/galdjum/bind(mob/user)
	. = ..()
	owner.discipline_time_plus = 25

/obj/item/vtm_artifact/galdjum/unbind(mob/user)
	. = ..()
	owner.discipline_time_plus = 0
