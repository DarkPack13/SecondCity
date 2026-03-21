// VAMPIRE THE MASQUERADE 20th ANNIVERSARY EDITION - VALEREN (WARRIOR)
/* A healer learns a subject's illnesses to cure them. The
Salubri antitribu, however, learn how close to death a
target is so that they may hasten the process.
System: This power works identically to the Obeah
power of the same name (p. 457):

"With a touch, the Salubri can instantaneously read
a target's injuries. She may learn how much damage a
target has incurred, and therefore make a guess at what
must be done to save him. This power can also be used
for diagnostic purposes - useful for a victim who can
no longer speak.

System: The Salubri must touch the target to see how
close to death she is. He must then make a Perception
+ Empathy roll (difficulty 7). One success on this roll
identifies a subject as a mortal, vampire, ghoul, or other creature.

Two successes reveal how many health levels
of damage the subject has suffered. Three successes tell
how full the subject's blood pool is (if a vampire) or
how many blood points she has left in her system (if a
mortal or other blood-bearing form of life). Four suc-
cesses reveal any diseases in the subject's bloodstream.
A player may opt to learn the information yielded by
a lesser degree of success - for example, a player who
accumulates three successes may learn whether or not
a subject is a vampire as well as the contents of his
blood pool.
*/

/datum/discipline/warrior_valeren
	name = "Valeren"
	desc = "The warrior's path of Valeren, used by the Salubri antitribu to read and exploit weakness in their enemies."
	icon_state = "valeren"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/warrior_valeren

// Assets for the UI
/datum/asset/simple/valeren_assets
	legacy = TRUE
	assets = list(
		"da_vinci_vitruve_luc_viatour.webp" = 'modular_darkpack/modules/powers/icons/images/da_vinci_vitruve_luc_viatour.webp',
	)

/datum/discipline_power/warrior_valeren
	name = "Valeren power name"
	desc = "Valeren power description"

/datum/discipline_power/warrior_valeren/sense_vitality
	name = "Sense Vitality"
	desc = "Allows you to determine the vitality of a target."
	level = 1
	check_flags = DISC_CHECK_CAPABLE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 1
	activate_sound = 'modular_darkpack/modules/deprecated/sounds/valeren.ogg'
	cooldown_length = 1 TURNS
	duration_length = 1 TURNS
	activate_sound = null
	vitae_cost = 0

	var/msg_creature = "" // what kinda phreak they is
	var/msg_damage = ""
	var/msg_blood = ""
	var/msg_disease = ""
	var/msg_mental = ""

/datum/discipline_power/warrior_valeren/sense_vitality/pre_activation_checks(mob/living/target)
	. = ..()
	successes = SSroll.storyteller_roll(owner.st_get_stat(STAT_PERCEPTION) + owner.st_get_stat(STAT_EMPATHY), 7, owner, TRUE)
	if(successes > 1)
		return TRUE
	else
		return FALSE

/datum/discipline_power/warrior_valeren/sense_vitality/proc/blood_read(mob/living/carbon/human/target)
	var/blood_volume = target.get_blood_volume(apply_modifiers = TRUE)
	switch(blood_volume)
		if(BLOOD_VOLUME_EXCESS to INFINITY)
			return "Their veins are engorged to the point of rupture."
		if(BLOOD_VOLUME_MAXIMUM to BLOOD_VOLUME_EXCESS)
			return "They are heavily overloaded with blood."
		if(BLOOD_VOLUME_SAFE to BLOOD_VOLUME_MAXIMUM)
			return "Their blood volume is healthy."
		if(BLOOD_VOLUME_OKAY to BLOOD_VOLUME_SAFE)
			return "Their blood is lower than normal."
		if(BLOOD_VOLUME_RISKY to BLOOD_VOLUME_OKAY)
			return "Their blood volume is dangerously low."
		if(BLOOD_VOLUME_BAD to BLOOD_VOLUME_RISKY)
			return "Dangerously low blood."
		if(BLOOD_VOLUME_SURVIVE to BLOOD_VOLUME_BAD)
			return "They are nearly void of blood altogether. Death comes for them soon without immediate intervention."
		else
			return "They are completely exsanguinated."

/datum/discipline_power/warrior_valeren/sense_vitality/proc/damage_severity(damage)
	if(damage < 30)
		return "some"
	if(damage < 50)
		return "moderate"
	return "heavy"

/datum/discipline_power/warrior_valeren/sense_vitality/ui_state(mob/user)
	return GLOB.always_state

/datum/discipline_power/warrior_valeren/sense_vitality/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	var/datum/asset/valeren_files = get_asset_datum(/datum/asset/simple/discipline_assets)
	if(user.client)
		valeren_files.send(user.client)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new /datum/tgui(user, src, "Valeren")
		ui.open()

/datum/discipline_power/warrior_valeren/sense_vitality/ui_data(mob/living/user)
	var/list/data = list()
	data["creature"] = msg_creature
	data["damage"] = msg_damage
	data["blood"] = msg_blood
	data["disease"] = msg_disease
	data["mental"] = msg_mental
	return data

/datum/discipline_power/warrior_valeren/sense_vitality/activate(mob/living/target)
	. = ..()
	msg_creature = ""
	msg_damage = ""
	msg_blood = ""
	msg_disease = ""
	msg_mental = ""

	// on one success, identify their splat
	var/creature_type = "a mortal"
	if(iskindred(target))
		creature_type = "kindred"
	else if(isghoul(target))
		creature_type = "a ghoul"
	else if(isavatar(target) || isobserver(target)) // because salubri spend all their time in the clinic anyway. they'll use this on ghosts
		creature_type = "a wraith"
	msg_creature = "[target] is [creature_type]."

	// on two successes, identify their damage
	if(successes >= 2)
		var/brute = target.get_brute_loss()
		var/burn = target.get_fire_loss()
		var/tox = target.get_tox_loss()
		var/oxy = target.get_oxy_loss()
		var/agg = target.get_agg_loss()
		var/list/damage_parts = list()
		if(brute > 0)
			damage_parts += "[damage_severity(brute)] bruising"
		if(burn > 0)
			damage_parts += "[damage_severity(burn)] burns"
		if(tox > 0)
			damage_parts += "[damage_severity(tox)] toxin damage"
		if(oxy > 0)
			damage_parts += "[damage_severity(oxy)] oxygen deprivation"
		if(agg > 0)
			damage_parts += "[damage_severity(agg)] supernatural wounds"
		msg_damage = length(damage_parts) ? "They bear [english_list(damage_parts)]." : "They appear uninjured."

	// on three successes, detect their bloodpool, if any exists
	if(successes >= 3)
		msg_blood = "[blood_read(target)] Blood pool of [round(target.bloodpool / target.maxbloodpool * 100)]%"

	// on four, display any diseases they might have
	if(successes >= 4)
		var/list/datum/disease/diseases = target.get_static_viruses()
		if(LAZYLEN(diseases))
			var/list/disease_names = list()
			for(var/datum/disease/D in diseases)
				disease_names += D.name
			msg_disease = "Detected [english_list(disease_names)] in their blood."
		else
			msg_disease = "Found no diseases in their blood."
		var/list/mental_conditions = list()
		if(target.has_quirk(/datum/quirk/insanity))
			mental_conditions += "insanity"
		if(target.has_quirk(/datum/quirk/derangement))
			mental_conditions += "an incurable derangement"
		if(length(mental_conditions))
			msg_mental = "[english_list(mental_conditions)] clouds their mind."

	ui_interact(owner)

/datum/discipline_power/warrior_valeren/sense_vitality/deactivate()
	. = ..()

//ANESTHETIC TOUCH
//
/*
The vampire can ease a target’s pain or place him
into a deep, soothing sleep with nothing but a touch.
This power is intended to heal the pain or succor the
mind of willing targets, but the character can, with
some effort, employ the power against someone who
does not wish it.

System: If the subject is willing to undergo this
process, the player spends a blood point and makes a
Willpower roll (difficulty 6) to block the subject’s pain.
This allows the subject to ignore all wound penalties
for one turn per success. A second application of this
power may be made once the first one has expired, at
the cost of another blood point and another Willpow
er roll. If the subject is unwilling for some reason, the
player must make a contested Willpower roll against
the subject (difficulty 8).

To put a mortal to sleep, the same system applies.
The mortal sleeps for five to 10 hours — whatever his
normal sleep cycle is — and regains one temporary
Willpower point upon awakening. He sleeps peace
fully and does not suffer nightmares or the effects of
any derangements while asleep. He may be awakened
normally (or violently).

Kindred, including the Salubri herself, are unaffected
by this power — their corpselike bodies are too tied to
death.
*/
/datum/discipline_power/warrior_valeren/anesthetic_touch
	name = "Anesthetic Touch"
	desc = "Soothe your patient's pain, or place a mortal into peaceful slumber."
	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_LIVING
	range = 1
	cooldown_length = 1 TURNS
	var/sleep_duration_length = 10 SCENES
	var/soothe_duration_length = 1 SCENES

/datum/discipline_power/warrior_valeren/anesthetic_touch/pre_activation_checks(mob/living/target)
	. = ..()
	var/successes = SSroll.storyteller_roll(owner.st_get_stat(STAT_TEMPORARY_WILLPOWER), ((target.combat_mode || !iskindred(target)) ? 8 : 6), owner, TRUE)
	if(successes > 1)
		return TRUE
	else
		return FALSE

/datum/discipline_power/warrior_valeren/anesthetic_touch/activate(mob/living/target)
	. = ..()
	var/chosen_option = show_radial_menu(owner, target, list("Soothe Pain", "Put To Sleep"), radius = 38, require_near = TRUE)
	switch(chosen_option)
		if("Soothe Pain")
			ADD_TRAIT(target, TRAIT_IGNORESLOWDOWN, DISCIPLINE_TRAIT)
			addtimer(CALLBACK(src, PROC_REF(end_soothe_pain), target), soothe_duration_length)
		if("Put To Sleep")
			if(iskindred(target))
				to_chat(owner, span_warning("You can't put a Kindred to sleep with this power!"))
				return TRUE
			target.SetSleeping(sleep_duration_length) // 30 minutes if left alone
			target.adjust_blood_pool(1) // Mortal regains a blood point.
	return TRUE

/datum/discipline_power/warrior_valeren/anesthetic_touch/proc/end_soothe_pain(mob/living/target)
	REMOVE_TRAIT(target, TRAIT_IGNORESLOWDOWN, DISCIPLINE_TRAIT)
