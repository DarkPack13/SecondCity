/datum/discipline/bloodheal
	name = "Bloodheal"
	desc = "Use the power of your Vitae to mend your flesh."
	icon_state = "bloodheal"
	power_type = /datum/discipline_power/bloodheal
	selectable = FALSE

/datum/storyteller_roll/bloodheal
	bumper_text = "Bloodheal"
	difficulty = 8
	applicable_stats = list(STAT_STAMINA, STAT_SURVIVAL)
	roll_output_type = ROLL_PRIVATE

/datum/discipline_power/bloodheal
	name = "Bloodheal power name"
	desc = "Bloodheal power description"

	activate_sound = 'modular_darkpack/modules/vampire_the_masquerade/sounds/bloodhealing.ogg'

	level = 1
	check_flags = DISC_CHECK_TORPORED
	vitae_cost = 1

	violates_masquerade = FALSE

	cooldown_length = 1 TURNS

	grouped_powers = list(
		/datum/discipline_power/bloodheal/one,
		/datum/discipline_power/bloodheal/two,
		/datum/discipline_power/bloodheal/three,
		/datum/discipline_power/bloodheal/four,
		/datum/discipline_power/bloodheal/five,
		/datum/discipline_power/bloodheal/six,
		/datum/discipline_power/bloodheal/seven,
		/datum/discipline_power/bloodheal/eight,
		/datum/discipline_power/bloodheal/nine,
		/datum/discipline_power/bloodheal/ten
	)

	var/datum/storyteller_roll/bloodheal/bloodheal_roll

/datum/discipline_power/bloodheal/pre_activation_checks(atom/target)
	. = ..()
	if(do_after(owner, 1 TURNS, timed_action_flags = DO_AFTER_CHECK_NEXT_MOVE | IGNORE_INCAPACITATED))
		return TRUE
	if(!bloodheal_roll)
		bloodheal_roll = new()
	var/roll_result = bloodheal_roll.st_roll(owner, src)
	to_chat(owner, span_warning("You break your concentration..."))
	switch(roll_result)
		if(ROLL_SUCCESS)
			to_chat(owner, span_notice("But you succeed in mending your wounds."))
			return TRUE
		if(ROLL_FAILURE)
			to_chat(owner, span_warning("And fail to harness your blood."))
			return FALSE
		if(ROLL_BOTCH)
			to_chat(owner, span_danger("And worsen your wounds."))
			owner.adjust_blood_pool(-1)
			owner.apply_damage(1 TTRPG_DAMAGE, BRUTE)
			return FALSE

/datum/discipline_power/bloodheal/activate()
	. = ..()

	// 2 to represent leathal***
	owner.heal_storyteller_health(vitae_cost * 2, heal_scars = TRUE)

	//healing too quickly attracts attention
	if (violates_masquerade)
		owner.visible_message(
			span_warning("[owner]'s wounds heal with unnatural speed!"),
			span_warning("Your wounds visibly heal with unnatural speed!")
		)

/datum/discipline_power/bloodheal/spend_resources()
	adjust_vitae_cost()

	. = ..()

/datum/discipline_power/bloodheal/proc/adjust_vitae_cost()
	vitae_cost = initial(vitae_cost)

	var/vitae_needed = owner.get_storyteller_damage(heal_scars = TRUE)

	//vitae used to heal is the smaller of max vitae expenditure and what's needed to heal the damage
	vitae_cost = max(min(vitae_cost, vitae_needed), 1)

	//healing is a masquerade breach if it's done at level 3 and above
	if (vitae_cost > 2)
		violates_masquerade = TRUE
	else
		violates_masquerade = FALSE

//BLOODHEAL 1
/datum/discipline_power/bloodheal/one
	name = "Minor Bloodheal"
	desc = "Slowly mend your undead flesh."

	level = 1
	vitae_cost = 1

	violates_masquerade = FALSE

//BLOODHEAL 2
/datum/discipline_power/bloodheal/two
	name = "Bloodheal"
	desc = "Mend your undead flesh."

	level = 2
	vitae_cost = 2

	violates_masquerade = FALSE

//BLOODHEAL 3
/datum/discipline_power/bloodheal/three
	name = "Quick Bloodheal"
	desc = "Mend your undead flesh with unnatural speed."

	level = 3
	vitae_cost = 3

	violates_masquerade = TRUE

//BLOODHEAL 4
/datum/discipline_power/bloodheal/four
	name = "Major Bloodheal"
	desc = "Heal even the most grievous wounds in short order."

	level = 4
	vitae_cost = 4

	violates_masquerade = TRUE

//BLOODHEAL 5
/datum/discipline_power/bloodheal/five
	name = "Greater Bloodheal"
	desc = "Regrow entire bodyparts without breaking a sweat."

	level = 5
	vitae_cost = 5

	violates_masquerade = TRUE

//BLOODHEAL 6
/datum/discipline_power/bloodheal/six
	name = "Grand Bloodheal"
	desc = "Regrow entire bodyparts without breaking a sweat."

	level = 6
	vitae_cost = 6

	violates_masquerade = TRUE

//BLOODHEAL 7
/datum/discipline_power/bloodheal/seven
	name = "Grand Bloodheal"
	desc = "Reconstitute your body from near nothing."

	level = 7
	vitae_cost = 7

	violates_masquerade = TRUE

//BLOODHEAL 8
/datum/discipline_power/bloodheal/eight
	name = "Godlike Bloodheal"
	desc = "On the edge of Final Death, let your blood explode outwards and recreate you."

	level = 8
	vitae_cost = 8

	violates_masquerade = TRUE

//BLOODHEAL 9
/datum/discipline_power/bloodheal/nine
	name = "Surpassing Bloodheal"
	desc = "Even as a titanic beast, you could restore your physical form in short order."

	level = 9
	vitae_cost = 9

	violates_masquerade = TRUE

//BLOODHEAL 10
/datum/discipline_power/bloodheal/ten
	name = "Ascended Bloodheal"
	desc = "So long as you have access to blood, you cannot die. Your curse will not allow it."

	level = 10
	vitae_cost = 10

	violates_masquerade = TRUE
