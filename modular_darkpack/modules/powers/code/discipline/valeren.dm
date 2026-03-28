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

/datum/discipline/valeren
	name = "Valeren"
	desc = "The warrior's path of Valeren, used by the Salubri antitribu to read and exploit weakness in their enemies."
	icon_state = "valeren"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/valeren

// Assets for the UI
/datum/asset/simple/valeren_assets
	legacy = TRUE
	assets = list(
		"da_vinci_vitruve_luc_viatour.webp" = 'modular_darkpack/modules/powers/icons/images/da_vinci_vitruve_luc_viatour.webp',
	)

/datum/discipline_power/valeren
	name = "Valeren power name"
	desc = "Valeren power description"

/datum/discipline_power/valeren/sense_vitality
	name = "Sense Vitality"
	desc = "Allows you to determine the vitality of a target."
	level = 1
	check_flags = DISC_CHECK_CAPABLE
	target_type = TARGET_HUMAN | TARGET_SELF
	range = 1
	cooldown_length = 3 TURNS
	duration_length = 1 TURNS
	activate_sound = null
	vitae_cost = 0
	var/successes = 0

	var/msg_creature = "" // what kinda phreak they is
	var/msg_damage = ""
	var/msg_blood = ""
	var/msg_disease = ""
	var/msg_mental = ""

/datum/discipline_power/valeren/sense_vitality/pre_activation_checks(mob/living/target)
	. = ..()
	successes = SSroll.storyteller_roll(owner.st_get_stat(STAT_PERCEPTION) + owner.st_get_stat(STAT_EMPATHY), 7, owner, TRUE)
	if(successes >= 1)
		return TRUE
	else
		return FALSE

/datum/discipline_power/valeren/sense_vitality/proc/blood_read(mob/living/carbon/human/target)
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

/datum/discipline_power/valeren/sense_vitality/proc/damage_severity(damage)
	if(damage < 30)
		return "some"
	if(damage < 50)
		return "moderate"
	return "heavy"

/datum/discipline_power/valeren/sense_vitality/ui_state(mob/user)
	return GLOB.always_state

/datum/discipline_power/valeren/sense_vitality/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	var/datum/asset/valeren_files = get_asset_datum(/datum/asset/simple/valeren_assets)
	if(user.client)
		valeren_files.send(user.client)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new /datum/tgui(user, src, "Valeren")
		ui.open()

/datum/discipline_power/valeren/sense_vitality/ui_data(mob/living/user)
	var/list/data = list()
	data["creature"] = msg_creature
	data["damage"] = msg_damage
	data["blood"] = msg_blood
	data["disease"] = msg_disease
	data["mental"] = msg_mental
	return data

/datum/discipline_power/valeren/sense_vitality/activate(mob/living/target)
	. = ..()
	msg_creature = ""
	msg_damage = ""
	msg_blood = ""
	msg_disease = ""
	msg_mental = ""

	// on one success, identify their splat
	var/creature_type = "a mortal"
	if(get_kindred_splat(target))
		creature_type = "kindred"
	else if(get_ghoul_splat(target))
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
		msg_blood = "[blood_read(target)] [round(target.bloodpool / target.maxbloodpool * 100)]% of Blood Pool remaining."

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
	to_chat(owner, span_notice("[msg_creature] \n[msg_damage] \n[msg_blood] \n[msg_disease] \n[msg_mental]"))

/datum/discipline_power/valeren/sense_vitality/deactivate()
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
/datum/discipline_power/valeren/anesthetic_touch
	name = "Anesthetic Touch"
	desc = "Soothe your patient's pain, or place a mortal into peaceful slumber."
	level = 2
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_LIVING
	range = 1
	cooldown_length = 3 TURNS
	var/sleep_duration_length = 10 TURNS
	var/soothe_duration_length = 1 SCENES
	var/successes = 0

/datum/discipline_power/valeren/anesthetic_touch/pre_activation_checks(mob/living/target)
	. = ..()
	successes = SSroll.storyteller_roll(owner.st_get_stat(STAT_TEMPORARY_WILLPOWER), (target.combat_mode ? 8 : 6), owner, TRUE)
	if(successes >= 1)
		return TRUE
	else
		return FALSE

/datum/discipline_power/valeren/anesthetic_touch/activate(mob/living/target)
	. = ..()
	var/list/choices = list(
		"Soothe Pain" = icon('icons/mob/actions/actions_spells.dmi', "statue"),
		"Put To Sleep" = icon('icons/mob/actions/actions_spells.dmi', "blind"),
	)
	var/chosen_option = show_radial_menu(owner, target, choices, radius = 38, require_near = TRUE)
	switch(chosen_option)
		if("Soothe Pain")
			ADD_TRAIT(target, TRAIT_IGNORESLOWDOWN, type)
			addtimer(CALLBACK(src, PROC_REF(end_soothe_pain), target), (successes TURNS) + soothe_duration_length)
		if("Put To Sleep")
			if(get_kindred_splat(target))
				to_chat(owner, span_warning("You can't put a Kindred to sleep with this power!"))
				return TRUE
			target.SetSleeping(sleep_duration_length + (successes TURNS)) // 50 seconds + successes in turns
			target.adjust_blood_pool(1) // restores a BP to the target, but if this gets abused, maybe make this depend on successes
	return TRUE

/datum/discipline_power/valeren/anesthetic_touch/proc/end_soothe_pain(mob/living/target)
	REMOVE_TRAIT(target, TRAIT_IGNORESLOWDOWN, type)

//BURNING TOUCH
/*
Burning Touch
The character’s hands bring searing pain, as though
the target is being burnt with red-hot metal. Although
the power does not inflict actual damage, prolonged
or repeated exposure can be enough to traumatize a
victim. This power works extremely well as a torture
method.

System: The vampire must touch his subject for this
power to take effect, and the effects diminish rapidly
after he removes his hand. The player spends at least
one blood point to activate this power, and each blood
point spent reduces the victim’s dice pools by two while
the Fury is in contact with the victim. This power is
often used for interrogation or torture, wearing down
the subject’s resistance and rendering him much more
tractable.
*/
/datum/discipline_power/valeren/burning_touch
	name = "Burning Touch"
	desc = "Channel supernatural fire through your hands, inflicting searing pain on anyone you grab, lasting 30 seconds. The burning does not cause damage but overwhelms the senses, disrupts concentration, and makes using Disciplines extremely difficult."
	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_FREE_HAND
	target_type = TARGET_LIVING
	range = 1
	vitae_cost = 1
	hostile = TRUE
	violates_masquerade = FALSE

/datum/discipline_power/valeren/burning_touch/activate(mob/living/target)
	. = ..()
	target.apply_status_effect(/datum/status_effect/burning_touch)
	if(owner.grab_state <= GRAB_AGGRESSIVE)
		target.grabbedby(owner)
		target.grippedby(owner, instant = TRUE)
		owner.do_attack_animation(target, ATTACK_EFFECT_MECHFIRE)

/datum/status_effect/burning_touch
	id = "burning_touch"
	status_type = STATUS_EFFECT_REFRESH
	duration = 6 TURNS // 30 second debuff duration, so it will still affect them for a few seconds even if they escape their captors grip, as per v20
	alert_type = /atom/movable/screen/alert/status_effect/burning_touch
	tick_interval = 2 TURNS // how frequently the pain messages will tick
	var/list/pain_messages = list(
		"It burns!",
		"It hurts!",
		"Dear god, make it stop!",
		"FIRE! FIRE!",
		"Stop, please, STOP!",
		"My skin is on fire!",
		"I can't think! It hurts so much!",
		"Let go, let GO!",
		"It's in my bones!",
		"I can't breathe through the pain!",
		"Why won't it stop?!",
	)

/datum/status_effect/burning_touch/on_apply()
	. = ..()
	if(!.)
		return
	owner.st_add_stat_mod(STAT_DEXTERITY, -2, "burning_touch") // you're in searing pain, so you're a little less dextrous
	owner.st_add_stat_mod(STAT_TEMPORARY_WILLPOWER, -2, "burning_touch")
	var/resist_scream = SSroll.storyteller_roll(owner.st_get_stat(STAT_TEMPORARY_WILLPOWER), 6, owner, FALSE)
	if(!resist_scream)
		owner.emote("scream")
	RegisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE, PROC_REF(on_discipline_activate))

/datum/status_effect/burning_touch/on_remove()
	. = ..()
	owner.st_remove_stat_mod(STAT_DEXTERITY, "burning_touch")
	owner.st_remove_stat_mod(STAT_TEMPORARY_WILLPOWER, "burning_touch")
	UnregisterSignal(owner, COMSIG_POWER_TRY_ACTIVATE)

// crispy victims must roll willpower at difficulty 6 to focus through the burning pain
/datum/status_effect/burning_touch/proc/on_discipline_activate(mob/living/source, datum/discipline_power/power, atom/target)
	SIGNAL_HANDLER
	var/success = SSroll.storyteller_roll(source.st_get_stat(STAT_TEMPORARY_WILLPOWER), 6, source, FALSE)
	if(!success)
		to_chat(source, span_userdanger("Burning agony overwhelms your concentration. You cannot focus enough to use your Disciplines!"))
		return POWER_PREVENT_ACTIVATE

/datum/status_effect/burning_touch/tick(seconds_between_ticks)
	to_chat(owner, span_userdanger(pick(pain_messages)))
	playsound(get_turf(owner), SFX_SIZZLE, 80, TRUE)

/atom/movable/screen/alert/status_effect/burning_touch
	name = "Burning Touch"
	desc = "Your body burns with supernatural fire! Using Disciplines requires a Willpower roll at difficulty 6 to focus through the pain."
	icon_state = "fire"

// Armor of Caine’s Fury
/*
The Salubri antitribu is surrounded by a shining,
crimson halo. This phantom armor protects the vampire
against most physical injury, as well as against Rötschreck.

System: The player spends one blood point and rolls
Stamina + Melee (difficulty 7). For each success, the
character gains one point of armor protection against
bashing and lethal damage, to a maximum of five points
of protection.

Additionally, for every two successes rolled,
she gains an additional die to resist Rötschreck
from the effects of battle (but not fire or sunlight). This
power works for one scene.
*/
/datum/discipline_power/valeren/armor_of_caines_fury
	name = "Armor of Caine's Fury"
	desc = "The Salubri antitribu is surrounded by a shining, crimson halo. This phantom armor protects the vampire against most physical injury, as well as against Rötschreck."
	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	cooldown_length = 1 SCENES
	toggled = TRUE
	duration_length = 2 TURNS
	vitae_cost = 1
	var/successes = 0
	violates_masquerade = TRUE

/datum/discipline_power/valeren/armor_of_caines_fury/pre_activation_checks(mob/living/target)
	. = ..()
	successes = SSroll.storyteller_roll(owner.st_get_stat(STAT_STAMINA) + owner.st_get_stat(STAT_MELEE), 7, owner, TRUE)
	if(successes >= 1)
		return TRUE
	else
		return FALSE

/datum/discipline_power/valeren/armor_of_caines_fury/activate(mob/living/target)
	. = ..()
	// TODO: once frenzy is in, add a status effect to reduce frenzy difficulty as per the book's 'resist Rötschreck'
	owner.apply_status_effect(/datum/status_effect/armor_of_caines_fury, clamp(successes, 1, 5))
	return TRUE

/datum/discipline_power/valeren/armor_of_caines_fury/deactivate()
	. = ..()
	owner.remove_status_effect(/datum/status_effect/armor_of_caines_fury)

#define CAINES_FURY_PROTECTION 15 // borrowed from fortitude

/datum/status_effect/armor_of_caines_fury
	id = "armor_of_caines_fury"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null
	var/successes = 1

/datum/status_effect/armor_of_caines_fury/on_creation(mob/living/new_owner, successes_count = 1)
	successes = successes_count
	. = ..()

/datum/status_effect/armor_of_caines_fury/on_apply()
	. = ..()
	if (!.)
		return

	if (ishuman(owner))
		var/mob/living/carbon/human/H = owner
		RegisterSignal(H, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(reduce_damage))
		H.AddElement(/datum/element/armor_of_caines_fury_halo, initial_delay = 0 SECONDS)
		ADD_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, DISCIPLINE_TRAIT(type))

/datum/status_effect/armor_of_caines_fury/on_remove()
	. = ..()

	if (ishuman(owner))
		var/mob/living/carbon/human/H = owner
		UnregisterSignal(H, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS)
		H.RemoveElement(/datum/element/armor_of_caines_fury_halo)
		REMOVE_TRAIT(owner, TRAIT_MASQUERADE_VIOLATING_FACE, DISCIPLINE_TRAIT(type))

/datum/status_effect/armor_of_caines_fury/proc/reduce_damage(datum/source, list/damage_mods, damage_amount, damagetype, def_zone, sharpness, attack_direction, obj/item/attacking_item)
	SIGNAL_HANDLER
	if (damagetype != BRUTE)
		return

	var/protection = clamp(successes * CAINES_FURY_PROTECTION, 0, 90) // we don't yet have a comparison for what 1 point of armor means in v20 vs ingame, so this is just a percent reduction for now
	damage_mods += (100 - protection) / 100

#undef CAINES_FURY_PROTECTION

// Halo stuff for Armor of Caine's Fury
/datum/element/armor_of_caines_fury_halo

/datum/element/armor_of_caines_fury_halo/Attach(datum/target, initial_delay = 20 SECONDS)
	. = ..()
	if (!isliving(target))
		return ELEMENT_INCOMPATIBLE

	addtimer(CALLBACK(src, PROC_REF(set_halo), target), initial_delay)

/datum/element/armor_of_caines_fury_halo/proc/set_halo(mob/living/target)
	SIGNAL_HANDLER
	var/mutable_appearance/new_halo_overlay = mutable_appearance('icons/mob/effects/halo.dmi', "halo[rand(1, 6)]", -HALO_LAYER)
	if (ishuman(target))
		var/mob/living/carbon/human/human_parent = target
		new /obj/effect/temp_visual/cult/sparks(get_turf(human_parent), human_parent.dir)
		human_parent.overlays_standing[HALO_LAYER] = new_halo_overlay
		human_parent.apply_overlay(HALO_LAYER)
	else
		target.add_overlay(new_halo_overlay)

/datum/element/armor_of_caines_fury_halo/Detach(mob/living/target, ...)
	if (ishuman(target))
		var/mob/living/carbon/human/human_parent = target
		human_parent.remove_overlay(HALO_LAYER)
		human_parent.update_body()
	else
		target.cut_overlay(HALO_LAYER)
	return ..()

//VENGEANCE OF SAMIEL
/*
The Salubri antitribu strikes his foe with superhu-
man accuracy and strength, as his third eye opens and
changes to a furious, icy blue. Some Furies invoke the
names of ancient Salubri warriors, while others sim-
ply close their normal eyes and let Samiel guide their
hands.

System: This power costs three blood points. Any
single attack made by the vampire automatically hits
the target as mystic forces guide the blow. Attacks
made in this manner may not be dodged, though they
may be blocked, parried, and soaked as normal. The
blow strikes as if the Salubri antitribu had succeeded
with all of his Dexterity + Melee or Brawling dice pool
(which makes for significant damage).

This power maybe used only once per turn, and only then the Salubri
antitribu’s sole action is the attack. Additionally, this
power does not work for ranged weapons; only bare
hands or melee weapons.
*/
// this is basically just potence 5 with stat bonuses, used potence as a baseline because of the 'makes for significant damage' wording in v20 above
/datum/discipline_power/valeren/vengeance_of_samiel
	name = "Vengeance of Samiel"
	desc = "The Salubri antitribu strikes his foe with superhu-man accuracy and strength, as his third eye opens and changes to a furious, icy blue. Some Furies invoke the names of ancient Salubri warriors, while others simply close their normal eyes and let Samiel guide their hands."
	level = 5
	check_flags = DISC_CHECK_CAPABLE
	toggled = TRUE
	duration_length = 1 TURNS

/datum/discipline_power/valeren/vengeance_of_samiel/activate()
	. = ..()
	owner.apply_status_effect(/datum/status_effect/vengeance_of_samiel)

/datum/discipline_power/valeren/vengeance_of_samiel/deactivate()
	. = ..()
	owner.remove_status_effect(/datum/status_effect/vengeance_of_samiel)

/datum/status_effect/vengeance_of_samiel
	id = "vengeance_of_samiel"
	status_type = STATUS_EFFECT_REPLACE
	alert_type = null

	var/bonus = 5
	var/datum/component/tackler/tackler
	var/list/obj/item/bodypart/affected_bodyparts

/datum/status_effect/vengeance_of_samiel/on_apply()
	. = ..()
	if (!.)
		return
	owner.st_add_stat_mod(STAT_DEXTERITY, bonus, "vengeance_of_samiel")
	owner.st_add_stat_mod(STAT_MELEE, bonus, "vengeance_of_samiel")
	owner.st_add_stat_mod(STAT_BRAWL, bonus, "vengeance_of_samiel")
	if (iscarbon(owner))
		var/mob/living/carbon/carbon_owner = owner
		for (var/obj/item/bodypart/limb as anything in carbon_owner.bodyparts)
			if (!istype(limb, /obj/item/bodypart/arm) && !istype(limb, /obj/item/bodypart/leg))
				continue
			LAZYADD(affected_bodyparts, limb)
			limb.unarmed_damage_low += 8 * bonus
			limb.unarmed_damage_high += 8 * bonus
			limb.unarmed_attack_sound = pick(list('sound/items/weapons/cqchit2.ogg', 'sound/items/weapons/cqchit1.ogg')) // i know kung fu
	else if (isbasicmob(owner))
		var/mob/living/basic/basic_owner = owner
		basic_owner.melee_damage_lower += 8 * bonus
		basic_owner.melee_damage_upper += 8 * bonus
		basic_owner.attack_sound = pick(list('sound/items/weapons/cqchit2.ogg', 'sound/items/weapons/cqchit1.ogg'))
	RegisterSignal(owner, COMSIG_MOB_ITEM_ATTACK, PROC_REF(apply_melee_modifier))
	tackler = owner.AddComponent(/datum/component/tackler, stamina_cost=0, base_knockdown = 1 SECONDS, range = 2 + bonus, speed = 1, skill_mod = 0, min_distance = 0)

/datum/status_effect/vengeance_of_samiel/on_remove()
	. = ..()
	owner.st_remove_stat_mod(STAT_DEXTERITY, bonus, "vengeance_of_samiel")
	owner.st_remove_stat_mod(STAT_MELEE, bonus, "vengeance_of_samiel")
	owner.st_remove_stat_mod(STAT_BRAWL, bonus, "vengeance_of_samiel")
	if (iscarbon(owner))
		for (var/obj/item/bodypart/limb in affected_bodyparts)
			limb.unarmed_damage_low -= 8 * bonus
			limb.unarmed_damage_high -= 8 * bonus
			limb.unarmed_attack_sound = initial(limb.unarmed_attack_sound)
	else if (isbasicmob(owner))
		var/mob/living/basic/basic_owner = owner
		basic_owner.melee_damage_lower -= 8 * bonus
		basic_owner.melee_damage_upper -= 8 * bonus
		basic_owner.attack_sound = initial(basic_owner.attack_sound)
	LAZYCLEARLIST(affected_bodyparts)
	UnregisterSignal(owner, COMSIG_MOB_ITEM_ATTACK)
	qdel(tackler)

/datum/status_effect/vengeance_of_samiel/proc/apply_melee_modifier(mob/source, mob/M, mob/user, list/modifiers, list/attack_modifiers)
	SIGNAL_HANDLER
	attack_modifiers[FORCE_MULTIPLIER] += 0.4 * bonus
