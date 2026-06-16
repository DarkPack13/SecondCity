/datum/storyteller_roll/gift/hidden_killer
	bumper_text = "Hidden Killer"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_LARCENY)

/datum/action/cooldown/power/gift/hidden_killer
	name = "Hidden Killer"
	desc = "The Red Talons didn't survive for so long without learning ways to conceal themselves. This Gift allows a werewolf to leave behind no physical evidence that would betray her hand (or claws, or teeth) in a slaying."
	button_icon_state = "hidden_killer"

	click_to_activate = TRUE

	rank = 1

/datum/action/cooldown/power/gift/hidden_killer/Activate(atom/target)
	var/mob/living/carbon/human/human_owner = astype(owner)
	var/mob/living/dead_guy = astype(target)
	if(!dead_guy || dead_guy.stat != DEAD)
		return FALSE
	if(!(target in range(1, owner)))
		return FALSE

	. = ..()

	owner.visible_message("[src] presses a hand to [dead_guy]")

	var/datum/storyteller_roll/gift/hidden_killer/roll_datum = new()
	var/roll_result = roll_datum.st_roll(owner)

	if(roll_result != ROLL_SUCCESS)
		return TRUE

	var/list/owner_blood_dna = human_owner?.get_blood_dna_list()
	var/full_print = md5(human_owner.dna.unique_identity)

	for(var/obj/effect/decal/cleanable/blood/blood_spot in range(12, owner))
		for(var/blood_dna in GET_ATOM_BLOOD_DNA(blood_spot))
			if(blood_dna in owner_blood_dna)
				qdel(blood_spot)
				break

	for(var/atom/nearby_atom in range(8, owner))
		var/datum/forensics/atom_forensics = nearby_atom.forensics
		if(!atom_forensics)
			continue

		for(var/fingerprint in atom_forensics.fingerprints)
			if(fingerprint == full_print)
				atom_forensics.fingerprints -= fingerprint

		for(var/bloodprint in atom_forensics.blood_DNA)
			if(bloodprint in owner_blood_dna)
				atom_forensics.blood_DNA -= bloodprint

	return TRUE
