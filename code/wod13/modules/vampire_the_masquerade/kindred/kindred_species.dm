/**
 * This is the splat (supernatural type, game line in the World of Darkness) container
 * for all vampire-related code. I think this is stupid and I don't want any of this to
 * be the way it is, but if we're going to work with the code that's been written then
 * my advice is to centralise all stuff directly relating to vampires to here if it isn't
 * already in another organisational structure.
 *
 * The same applies to other splats, like /datum/species/garou or /datum/species/ghoul.
 * Halfsplats like ghouls are going to share some code with their fullsplats (vampires).
 * I dunno what to do about this except a reorganisation to make this stuff actually good.
 * The plan right now is to create a /datum/splat parent type and then have everything branch
 * from there, but that's for the future.
 */

/datum/species/human/kindred
	name = "Kindred"
	plural_form = "Kindred"
	id = SPECIES_KINDRED
	examine_limb_id = SPECIES_HUMAN
	inherent_traits = list(
		TRAIT_USES_SKINTONES,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NOBLOOD,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_NOCRITDAMAGE,
		TRAIT_RADIMMUNE,
		TRAIT_CAN_ENTER_TORPOR,
		TRAIT_VTM_MORALITY,
		TRAIT_VTM_CLANS,
		TRAIT_UNAGING
	)
	inherent_biotypes = MOB_UNDEAD | MOB_HUMANOID
	changesource_flags = MIRROR_BADMIN
	coldmod = 0.25
	heatmod = 2
	mutanttongue = /obj/item/organ/tongue/kindred
	var/datum/vampire_clan/clan
	var/list/datum/discipline/disciplines
	var/enlightenment
	COOLDOWN_DECLARE(torpor_timer)

/datum/species/human/kindred/on_species_gain(mob/living/carbon/human/new_kindred, datum/species/old_species, pref_load, regenerate_icons = TRUE)
	. = ..()

	var/datum/action/cooldown/blood_power/bloodpower = new()
	bloodpower.Grant(new_kindred)

	// TODO: [Lucia] reimplement these vars and the actions
	/*
	new_kindred.update_body(0)
	new_kindred.last_experience = world.time + 5 MINUTES

	var/datum/action/vampireinfo/infor = new()
	infor.host = new_kindred
	infor.Grant(new_kindred)

	//this needs to be adjusted to be more accurate for blood spending rates
	var/datum/discipline/bloodheal/giving_bloodheal = new(clamp(11 - new_kindred.generation, 1, 10))
	new_kindred.give_discipline(giving_bloodheal)

	var/datum/action/give_vitae/vitae = new()
	vitae.Grant(new_kindred)

	add_verb(new_kindred, TYPE_VERB_REF(/mob/living/carbon/human, teach_discipline))
	*/

	new_kindred.yang_chi = 0
	new_kindred.max_yang_chi = 0
	new_kindred.yin_chi = 6
	new_kindred.max_yin_chi = 6

	//vampires don't die while in crit, they just slip into torpor after 2 minutes of being critted
	RegisterSignal(new_kindred, SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION), PROC_REF(handle_enter_critical_condition))

	//vampires resist vampire bites better than mortals
	RegisterSignal(new_kindred, COMSIG_MOB_VAMPIRE_SUCKED, PROC_REF(on_vampire_bitten))

	// Apply bashing damage resistance
	RegisterSignal(new_kindred, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS, PROC_REF(damage_resistance))

	// TODO: [Lucia] reimplement choosing disciplines
	new_kindred.give_discipline(new /datum/discipline/celerity(5))

/datum/species/human/kindred/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()

	human.set_clan()

	//UnregisterSignal(human, COMSIG_CARBON_LOSE_ORGAN)
	UnregisterSignal(human, SIGNAL_ADDTRAIT(TRAIT_CRITICAL_CONDITION))
	UnregisterSignal(human, COMSIG_MOB_VAMPIRE_SUCKED)
	UnregisterSignal(human, COMSIG_MOB_APPLY_DAMAGE_MODIFIERS)

	// TODO: [Lucia] reimplement vampire actions
	/*
	for (var/datum/action/vampireinfo/VI in human.actions)
		VI.Remove(human)
	*/

	for (var/datum/action/A in human.actions)
		if (A.vampiric)
			A.Remove(human)

/datum/species/human/kindred/proc/damage_resistance(datum/source, list/damage_mods, damage_amount, damagetype, def_zone, sharpness, attack_direction, obj/item/attacking_item)
	SIGNAL_HANDLER

	// Kindred take half "bashing" damage, which is normally blunt damage but includes pointy things like bullets because they're undead
	if ((damagetype == BRUTE) && (sharpness != SHARP_EDGED))
		damage_mods += 0.5

/**
 * Accesses a certain Discipline that a Kindred has. Null if not found.
 *
 * Arguments:
 * * searched_discipline - Name or typepath of the Discipline being searched for.
 */
/datum/species/human/kindred/proc/get_discipline(searched_discipline)
	for (var/datum/discipline/discipline in disciplines)
		if (istype(discipline, searched_discipline))
			return discipline

/datum/species/human/kindred/proc/handle_enter_critical_condition(mob/living/carbon/human/source)
	SIGNAL_HANDLER

	to_chat(source, span_warning("You can feel yourself slipping into Torpor. You can use succumb to immediately sleep..."))
	addtimer(CALLBACK(source, TYPE_PROC_REF(/mob/living/carbon/human, torpor), "damage"), 2 MINUTES)

/datum/species/human/kindred/proc/slip_into_torpor(mob/living/carbon/human/kindred)
	if (!kindred || (kindred.stat == DEAD))
		return
	if (kindred.stat < SOFT_CRIT)
		return

	kindred.torpor("damage")

/**
 * On being bit by a vampire
 *
 * This handles vampire bite sleep immunity and any future special interactions.
 */
/datum/species/human/kindred/proc/on_vampire_bitten(datum/source, mob/living/carbon/being_bitten)
	SIGNAL_HANDLER

	return COMPONENT_RESIST_VAMPIRE_KISS

// TODO: [Lucia] reimplement the godforsaken stuff in here
/*
/datum/species/human/kindred/spec_life(mob/living/carbon/human/H)
	. = ..()

	//FIRE FEAR
	if(!H.antifrenzy && !HAS_TRAIT(H, TRAIT_KNOCKEDOUT))
		var/fearstack = 0
		for(var/obj/effect/fire/F in GLOB.fires_list)
			if(get_dist(F, H) < 8 && F.z == H.z)
				fearstack += F.stage
		for(var/mob/living/carbon/human/U in viewers(7, H))
			if(U.on_fire)
				fearstack += 1

		fearstack = min(fearstack, 10)

		if(fearstack)
			if(prob(fearstack*5))
				H.do_jitter_animation(10)
				if(fearstack > 20)
					if(prob(fearstack))
						if(!H.in_frenzy)
							H.rollfrenzy()
			if(!H.has_status_effect(STATUS_EFFECT_FEAR))
				H.apply_status_effect(STATUS_EFFECT_FEAR)
		else
			H.remove_status_effect(STATUS_EFFECT_FEAR)

	// Masquerade violations due to unnatural appearances
	if (H.is_face_visible())
		// Gargoyles, nosferatu, skeletons, that kind of thing
		if (HAS_TRAIT(H, TRAIT_MASQUERADE_VIOLATING_FACE))
			if (H.CheckEyewitness(H, H, 7, FALSE))
				H.adjust_masquerade(-1)
		// Masquerade breach if eyes are uncovered, short range
		else if (HAS_TRAIT(H, TRAIT_MASQUERADE_VIOLATING_EYES))
			if (!H.is_eyes_covered())
				if (H.CheckEyewitness(H, H, 3, FALSE))
					H.adjust_masquerade(-1)

	if (HAS_TRAIT(H, TRAIT_UNMASQUERADE))
		if(H.CheckEyewitness(H, H, 7, FALSE))
			H.adjust_masquerade(-1)

	if(istype(get_area(H), /area/vtm))
		var/area/vtm/V = get_area(H)
		if(V.zone_type == ZONE_MASQUERADE && V.upper)
			if(H.pulling)
				if(ishuman(H.pulling))
					var/mob/living/carbon/human/pull = H.pulling
					if(pull.stat == DEAD)
						var/obj/item/card/id/id_card = H.get_idcard(FALSE)
						if(!istype(id_card, /obj/item/card/id/clinic))
							if(H.CheckEyewitness(H, H, 7, FALSE))
								if(H.last_loot_check+50 <= world.time)
									H.last_loot_check = world.time
									H.last_nonraid = world.time
									H.killed_count = H.killed_count+1
									if(!H.warrant && !H.ignores_warrant)
										if(H.killed_count >= 5)
											H.warrant = TRUE
											SEND_SOUND(H, sound('sound/wod13/suspect.ogg', 0, 0, 75))
											to_chat(H, "<span class='userdanger'><b>POLICE ASSAULT IN PROGRESS</b></span>")
										else
											SEND_SOUND(H, sound('sound/wod13/sus.ogg', 0, 0, 75))
											to_chat(H, "<span class='userdanger'><b>SUSPICIOUS ACTION (corpse)</b></span>")
			for (var/obj/item/I in H.contents)
				if (!I.masquerade_violating || (I.loc != H))
					continue

				var/obj/item/card/id/id_card = H.get_idcard(FALSE)
				if (istype(id_card, /obj/item/card/id/clinic))
					continue

				if (H.warrant || H.ignores_warrant)
					continue

				if (H.last_loot_check + 5 SECONDS > world.time)
					continue

				if (!H.CheckEyewitness(H, H, 7, FALSE))
					continue

				H.last_loot_check = world.time
				H.last_nonraid = world.time
				H.killed_count++

				if (H.killed_count >= 5)
					H.warrant = TRUE
					SEND_SOUND(H, sound('sound/wod13/suspect.ogg', 0, 0, 75))
					to_chat(H, span_userdanger("<b>POLICE ASSAULT IN PROGRESS</b>"))
				else
					SEND_SOUND(H, sound('sound/wod13/sus.ogg', 0, 0, 75))
					to_chat(H, span_userdanger("<b>SUSPICIOUS ACTION (equipment)</b>"))

	if(H.key && (H.stat <= HARD_CRIT))
		var/datum/preferences/P = GLOB.preferences_datums[ckey(H.key)]
		if(P)
			if(P.humanity != H.humanity)
				P.humanity = H.humanity
				P.save_preferences()
				P.save_character()
			if(P.masquerade != H.masquerade)
				P.masquerade = H.masquerade
				P.save_preferences()
				P.save_character()

			if(!H.antifrenzy)
				if(P.humanity < 1)
					H.enter_frenzymod()
					to_chat(H, "<span class='userdanger'>You have lost control of the Beast within you, and it has taken your body. Be more [H.client.prefs.enlightenment ? "Enlightened" : "humane"] next time.</span>")
					H.ghostize(FALSE)
					P.reason_of_death = "Lost control to the Beast ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."

	// TODO: [Lucia] this needs to be a component
	if(H.clan && !H.antifrenzy && !HAS_TRAIT(H, TRAIT_KNOCKEDOUT))
		if(HAS_TRAIT(H, TRAIT_VITAE_ADDICTION))
			if(H.mind)
				if(H.mind.enslaved_to)
					if(get_dist(H, H.mind.enslaved_to) > 10)
						if((H.last_frenzy_check + 40 SECONDS) <= world.time)
							to_chat(H, "<span class='warning'><b>As you are far from [H.mind.enslaved_to], you feel the desire to drink more vitae!<b></span>")
							H.last_frenzy_check = world.time
							H.rollfrenzy()
					else if(H.bloodpool > 1 || H.in_frenzy)
						H.last_frenzy_check = world.time
		else
			if(H.bloodpool > 1 || H.in_frenzy)
				H.last_frenzy_check = world.time

	if(!H.antifrenzy && !HAS_TRAIT(H, TRAIT_KNOCKEDOUT))
		if(H.bloodpool <= 1 && !H.in_frenzy)
			if((H.last_frenzy_check + 40 SECONDS) <= world.time)
				H.last_frenzy_check = world.time
				H.rollfrenzy()
				if (H.client?.prefs?.enlightenment)
					if(!H.CheckFrenzyMove())
						H.AdjustHumanity(1, 10)
*/

/obj/item/organ/tongue/kindred
	liked_foodtypes = NONE
	disliked_foodtypes = NONE
	// All food except raw meat is disgusting to Kindred
	toxic_foodtypes = ~(GORE | MEAT | RAW)

/proc/get_vamp_skin_color(value = "albino")
	switch(value)
		if("caucasian1")
			return "vamp1"
		if("caucasian2")
			return "vamp2"
		if("caucasian3")
			return "vamp3"
		if("latino")
			return "vamp4"
		if("mediterranean")
			return "vamp5"
		if("asian1")
			return "vamp6"
		if("asian2")
			return "vamp7"
		if("arab")
			return "vamp8"
		if("indian")
			return "vamp9"
		if("african1")
			return "vamp10"
		if("african2")
			return "vamp11"
		else
			return value
