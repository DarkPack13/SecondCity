#define COMBAT_COOLDOWN_LENGTH 15 SECONDS

/datum/discipline/potence
	name = "Potence"
	desc = "Boosts melee and unarmed damage."
	icon_state = "potence"
	power_type = /datum/discipline_power/potence

/datum/discipline_power/potence
	name = "Potence power name"
	desc = "Potence power description"
	abstract_type = /datum/discipline_power/potence

	activate_sound = 'modular_darkpack/modules/powers/sounds/potence_activate.ogg'
	deactivate_sound = 'modular_darkpack/modules/powers/sounds/potence_deactivate.ogg'

	check_flags = DISC_CHECK_CAPABLE

	toggled = TRUE
	vitae_cost = 0
	duration_length = 0

	var/static/list/attack_signals = list(
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_ATOM_ATTACKBY,
		COMSIG_MOB_ITEM_ATTACK,
		COMSIG_LIVING_GRAB
	)

/datum/discipline_power/potence/post_gain()
	owner.st_add_stat_mod(STAT_STRENGTH, level, "Potence")

/datum/discipline_power/potence/post_loss()
	owner.st_remove_stat_mod(STAT_STRENGTH, "Potence")

/datum/discipline_power/potence/pre_activation_checks()
	. = ..()
	if(owner.bloodpool <= 0)
		to_chat(owner, span_danger("You do not have enough BP to use Potence!"))

/datum/discipline_power/potence/activate()
	. = ..()

	RegisterSignals(owner, attack_signals, PROC_REF(on_attack_signal))

	if(level <= 5)
		var/max_level = min(discipline.level, 5)
		owner.apply_status_effect(/datum/status_effect/potence, max_level)

/datum/discipline_power/potence/deactivate()
	. = ..()

	UnregisterSignal(owner, attack_signals)

	if(level <= 5)
		owner.remove_status_effect(/datum/status_effect/potence)

/datum/discipline_power/potence/proc/on_attack_signal(datum/source)
	SIGNAL_HANDLER

	if(owner.bloodpool <= 0)
		to_chat(owner, span_warning("You don't have enough blood to keep [src] active!"))
		try_deactivate(direct = TRUE)

		deltimer(cooldown_timer)
		cooldown_timer = addtimer(CALLBACK(src, PROC_REF(cooldown_expire)), COMBAT_COOLDOWN_LENGTH, TIMER_STOPPABLE | TIMER_DELETE_ME)

	to_chat(owner, span_warning("[src] consumes your blood to stay active."))
	owner.adjust_blood_pool(-1)

//POTENCE 1
/datum/discipline_power/potence/one
	name = "Potence 1"
	desc = "Enhance your muscles. Never hit softly."

	level = 1

	grouped_powers = list(
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)


//POTENCE 2
/datum/discipline_power/potence/two
	name = "Potence 2"
	desc = "Become powerful beyond your muscles. Wreck people and things."

	level = 2

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)


//POTENCE 3
/datum/discipline_power/potence/three
	name = "Potence 3"
	desc = "Become a force of destruction. Lift and break the unliftable and the unbreakable."

	level = 3

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/four,
		/datum/discipline_power/potence/five
	)


//POTENCE 4
/datum/discipline_power/potence/four
	name = "Potence 4"
	desc = "Become an unyielding machine for as long as your Vitae lasts."

	level = 4

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/five
	)


//POTENCE 5
/datum/discipline_power/potence/five
	name = "Potence 5"
	desc = "The people could worship you as a god if you showed them this."

	level = 5

	grouped_powers = list(
		/datum/discipline_power/potence/one,
		/datum/discipline_power/potence/two,
		/datum/discipline_power/potence/three,
		/datum/discipline_power/potence/four
	)

#undef COMBAT_COOLDOWN_LENGTH
