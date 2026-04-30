/datum/storyteller_roll/gift/hidden_killer
	bumper_text = "Hidden Killer"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_LARCENY)

/datum/action/cooldown/power/gift/hidden_killer
	name = "Hidden Killer"
	desc = "The Red Talons didn't survive for so long without learning ways to conceal themselves. This Gift allows a werewolf to leave behind no physical evidence that would betray her hand (or claws, or teeth) in a slaying."

	rank = 1

/datum/action/cooldown/power/gift/hidden_killer/Activate(atom/target)
	. = ..()

	var/mob/living/living_owner = astype(owner)
	var/mob/living/dead_guy = astype(target)
	if(!dead_guy || dead_guy.stat != DEAD)
		return FALSE
	// owner.visible_message("[src] presses a hand to [dead_guy]")


	var/datum/storyteller_roll/gift/hidden_killer/roll_datum = new()
	var/roll_result = roll_datum.st_roll(owner)

	if(roll_result != ROLL_SUCCESS)
		return FALSE

	var/list/owner_blood_dna = living_owner?.get_blood_dna_list()
	for(var/obj/effect/decal/cleanable/blood/blood_spot in range(12, owner))
		for(var/blood_dna in GET_ATOM_BLOOD_DNA(blood_spot))
			if(blood_dna in owner_blood_dna)
				qdel(blood_spot)
				break
