/datum/discipline/potence
	name = "Potence"
	desc = "Boosts melee and unarmed damage."
	icon_state = "potence"
	power_type = /datum/discipline_power/potence

/datum/discipline_power/potence
	name = "Potence power name"
	desc = "Potence power description"

	activate_sound = 'modular_darkpack/modules/powers/sounds/potence_activate.ogg'
	deactivate_sound = 'modular_darkpack/modules/powers/sounds/potence_deactivate.ogg'

/datum/discipline_power/potence/proc/apply_passive_strength_bonus(bonus)
	if (owner.st_get_stat_mod(STAT_STRENGTH, "potence") >= bonus)
		return

	owner.st_add_stat_mod(STAT_STRENGTH, bonus, "potence")

//POTENCE 1
/datum/discipline_power/potence/one
	name = "Potence 1"
	desc = "Enhance your muscles. Never hit softly."

	level = 1

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)

/datum/discipline_power/potence/one/activate()
	. = ..()

	owner.apply_status_effect(/datum/status_effect/potence/one)

/datum/discipline_power/potence/one/deactivate()
	. = ..()

	owner.remove_status_effect(/datum/status_effect/potence/one)

/datum/discipline_power/potence/one/post_gain()
	apply_passive_strength_bonus(1)

//POTENCE 2
/datum/discipline_power/potence/two
	name = "Potence 2"
	desc = "Become powerful beyond your muscles. Wreck people and things."

	level = 2

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)

/datum/discipline_power/potence/two/activate()
	. = ..()

	owner.apply_status_effect(/datum/status_effect/potence/two)

/datum/discipline_power/potence/two/deactivate()
	. = ..()

	owner.remove_status_effect(/datum/status_effect/potence/two)

/datum/discipline_power/potence/two/post_gain()
	apply_passive_strength_bonus(2)

//POTENCE 3
/datum/discipline_power/potence/three
	name = "Potence 3"
	desc = "Become a force of destruction. Lift and break the unliftable and the unbreakable."

	level = 3

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)

/datum/discipline_power/potence/three/activate()
	. = ..()

	owner.apply_status_effect(/datum/status_effect/potence/three)

/datum/discipline_power/potence/three/deactivate()
	. = ..()

	owner.remove_status_effect(/datum/status_effect/potence/three)

/datum/discipline_power/potence/three/post_gain()
	apply_passive_strength_bonus(3)

//POTENCE 4
/datum/discipline_power/potence/four
	name = "Potence 4"
	desc = "Become an unyielding machine for as long as your Vitae lasts."

	level = 4

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/five
	)

/datum/discipline_power/potence/four/activate()
	. = ..()

	owner.apply_status_effect(/datum/status_effect/potence/four)

/datum/discipline_power/potence/four/deactivate()
	. = ..()

	owner.remove_status_effect(/datum/status_effect/potence/four)

/datum/discipline_power/potence/four/post_gain()
	apply_passive_strength_bonus(4)

//POTENCE 5
/datum/discipline_power/potence/five
	name = "Potence 5"
	desc = "The people could worship you as a god if you showed them this."

	level = 5

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four
	)

/datum/discipline_power/potence/five/activate()
	. = ..()

	owner.apply_status_effect(/datum/status_effect/potence/five)

/datum/discipline_power/potence/five/deactivate()
	. = ..()

	owner.remove_status_effect(/datum/status_effect/potence/five)

/datum/discipline_power/potence/five/post_gain()
	apply_passive_strength_bonus(5)
