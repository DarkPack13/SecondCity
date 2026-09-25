/**soak probability chart
1 Die - 49.99 / 40.01 / 10 (1)
2 Die - 65 / 26 / 9 (1.4)
3 Die - 73.99 / 19.9 / 6.1 (1.7)
4 Die - 80.05 / 16.26 / 3.69 (2.1)
5 Die - 84.4 / 13.49 / 2.1 (2.4)
*/
/datum/status_effect/fortitude
	// All IDs are the same to prevent stacking multiple Fortitude statuses
	id = "fortitude"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null

	var/armor_type

/datum/status_effect/fortitude/on_apply()
	. = ..()
	if (!.)
		return

	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.physiology.armor = human_owner.physiology.armor.add_other_armor(armor_type)

/datum/status_effect/fortitude/on_remove()
	. = ..()

	if (ishuman(owner))
		var/mob/living/carbon/human/human_owner = owner
		human_owner.physiology.armor = human_owner.physiology.armor.subtract_other_armor(armor_type)

// Status effect ranks
/datum/status_effect/fortitude/one
	armor_type = /datum/armor/fortitude1

/datum/armor/fortitude1
	acid = 49.99
	bio = 49.99
	fire = 49.99

/datum/status_effect/fortitude/two
	armor_type = /datum/armor/fortitude2

/datum/armor/fortitude2
	acid = 65
	bio = 65
	fire = 65

/datum/status_effect/fortitude/three
	armor_type = /datum/armor/fortitude3

/datum/armor/fortitude3
	acid = 73.99
	bio = 73.99
	fire = 73.99

/datum/status_effect/fortitude/four
	armor_type = /datum/armor/fortitude4

/datum/armor/fortitude4
	acid = 80.05
	bio = 80.05
	fire = 80.05

/datum/status_effect/fortitude/five
	armor_type = /datum/armor/fortitude5

/datum/armor/fortitude5
	acid = 84.4
	bio = 84.4
	fire = 84.4
