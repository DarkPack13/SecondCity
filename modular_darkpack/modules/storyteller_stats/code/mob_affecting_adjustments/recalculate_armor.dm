/**Stamina soak probability chart
1 Die - 49.99 / 40.01 / 10 (1)
2 Die - 65 / 26 / 9 (1.4)
3 Die - 73.99 / 19.9 / 6.1 (1.7)
4 Die - 80.05 / 16.26 / 3.69 (2.1)
5 Die - 84.4 / 13.49 / 2.1 (2.4)
6 Die - 87.65 / 11.2 / 1.15 (2.8)
7 Die - 90.13 / 9.25 / 0.62 (3.2)
8 Die - 92.06 / 7.61 / 0.33 (3.5)
9 Die - 93.58 / 6.25 / 0.17 (3.9)
10 Die - 94.78 / 5.13 / 0.09 (4.2)
** */

//Function for updating a player's armor based on their current stats.
/mob/living/carbon/human/proc/recalculate_max_armor(initial = FALSE)
	apply_status_effect(stam_armor_type())

/mob/living/carbon/human/proc/stam_armor_type()
	var/stam = st_get_stat(STAT_STAMINA)
	switch(stam)
		if(1)
			return /datum/status_effect/stamina/one
		if(2)
			return /datum/status_effect/stamina/two
		if(3)
			return /datum/status_effect/stamina/three
		if(4)
			return /datum/status_effect/stamina/four
		if(5)
			return /datum/status_effect/stamina/five
		if(6)
			return /datum/status_effect/stamina/six
		if(7)
			return /datum/status_effect/stamina/seven
		if(8)
			return /datum/status_effect/stamina/eight
		if(9)
			return /datum/status_effect/stamina/nine
		if(10)
			return /datum/status_effect/stamina/ten

/datum/status_effect/stamina
	// All IDs are the same to prevent stacking multiple Fortitude statuses
	id = "stamina"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null

	var/armor_type

/datum/status_effect/stamina/on_apply()
	. = ..()
	if (!.)
		return

	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.physiology.armor = human_owner.physiology.armor.add_other_armor(armor_type)

/datum/status_effect/stamina/on_remove()
	. = ..()

	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.physiology.armor = human_owner.physiology.armor.subtract_other_armor(armor_type)

// Status effect ranks
/datum/status_effect/stamina/one
	armor_type = /datum/armor/stamina1

/datum/armor/stamina1
	bomb = 49.99
	bullet = 49.99
	consume = 49.99
	energy = 49.99
	laser = 49.99
	melee = 49.99
	wound = 49.99

/datum/status_effect/stamina/two
	armor_type = /datum/armor/stamina2

/datum/armor/stamina2
	bomb = 65
	bullet = 65
	consume = 65
	energy = 65
	laser = 65
	melee = 65
	wound = 65

/datum/status_effect/stamina/three
	armor_type = /datum/armor/stamina3

/datum/armor/stamina3
	bomb = 73.99
	bullet = 73.99
	consume = 73.99
	energy = 73.99
	laser = 73.99
	melee = 73.99
	wound = 73.99

/datum/status_effect/stamina/four
	armor_type = /datum/armor/stamina4

/datum/armor/stamina4
	bomb = 80.05
	bullet = 80.05
	consume = 80.05
	energy = 80.05
	laser = 80.05
	melee = 80.05
	wound = 80.05

/datum/status_effect/stamina/five
	armor_type = /datum/armor/stamina5

/datum/armor/stamina5
	bomb = 84.4
	bullet = 84.4
	consume = 84.4
	energy = 84.4
	laser = 84.4
	melee = 84.4
	wound = 84.4

/datum/armor/stamina6
	bomb = 87.65
	bullet = 87.65
	consume = 87.65
	energy = 87.65
	laser = 87.65
	melee = 87.65
	wound = 87.65

/datum/status_effect/stamina/six
	armor_type = /datum/armor/stamina6

/datum/armor/stamina7
	bomb = 90.13
	bullet = 90.13
	consume = 90.13
	energy = 90.13
	laser = 90.13
	melee = 90.13
	wound = 90.13

/datum/status_effect/stamina/seven
	armor_type = /datum/armor/stamina7

/datum/armor/stamina8
	bomb = 92.06
	bullet = 92.06
	consume = 92.06
	energy = 92.06
	laser = 92.06
	melee = 92.06
	wound = 92.06

/datum/status_effect/stamina/eight
	armor_type = /datum/armor/stamina8

/datum/armor/stamina9
	bomb = 93.58
	bullet = 93.58
	consume = 93.58
	energy = 93.58
	laser = 93.58
	melee = 93.58
	wound = 93.58

/datum/status_effect/stamina/nine
	armor_type = /datum/armor/stamina9

/datum/armor/stamina10
	bomb = 94.78
	bullet = 94.78
	consume = 94.78
	energy = 94.78
	laser = 94.78
	melee = 94.78
	wound = 94.78

/datum/status_effect/stamina/ten
	armor_type = /datum/armor/stamina10

