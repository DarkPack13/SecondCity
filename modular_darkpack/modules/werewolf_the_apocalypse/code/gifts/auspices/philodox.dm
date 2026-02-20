/*
/datum/action/cooldown/power/gift/resist_pain
	name = "Resist Pain"
	desc = "Through force of will, the Philodox is able to ignore the pain of his wounds and continue acting normally."
	button_icon_state = "resist_pain"
	rage_req = 2

/datum/action/cooldown/power/gift/resist_pain/Activate(atom/target)
	. = ..()
	if(allowed_to_proceed)
		if(ishuman(owner))
			playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/resist_pain.ogg', 75, FALSE)
			var/mob/living/carbon/human/H = owner
			H.physiology.armor.melee = 40
			H.physiology.armor.bullet = 25
			to_chat(owner, span_notice("You feel your skin thickering..."))
			spawn(15 SECONDS)
				H.physiology.armor.melee = initial(H.physiology.armor.melee)
				H.physiology.armor.bullet = initial(H.physiology.armor.bullet)
				to_chat(owner, span_warning("Your skin is thin again..."))
		else
			playsound(get_turf(owner), 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/resist_pain.ogg', 75, FALSE)
			var/mob/living/carbon/werewolf/H = owner
			H.werewolf_armor = 40
			to_chat(owner, span_notice("You feel your skin thickering..."))
			spawn(15 SECONDS)
				H.werewolf_armor = initial(H.werewolf_armor)
				to_chat(owner, span_warning("Your skin is thin again..."))
*/


/datum/action/cooldown/power/gift/scent_of_the_true_form
	name = "Scent Of The True Form"
	desc = "This Gift allows the Garou to determine the true nature of a person."
	button_icon_state = "scent_of_the_true_form"
	click_to_activate = TRUE
	rank = 1
	var/static/list/wyld_descriptors = list(
		"ozone",
		"euphoria",
		"flowers",
		"an unseen breeze",
		"petrichor",
		"the calm after a thunderstorm",
		"a primal ocean",
		"the anticipation of limitless possibility"
	)
	var/static/list/weaver_descriptors = list(
		"sound patterns",
		"cleaning fluid",
		"hand sanitizer",
		"a spider\'s web",
		"silken thread",
		"metal",
		"a sudden drain of energy",
		"flashing lights",
		"alarms and sirens"
	)
	var/static/list/wyrm_descriptors = list(
		"rot",
		"decay",
		"fear",
		"an animal that died in fear",
		"depression",
		"hopelessness",
		"pain",
		"lengethening shadows"
	)

/datum/action/cooldown/power/gift/scent_of_the_true_form/set_click_ability(mob/on_who)
	. = ..()
	SEND_SOUND(owner, 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/scent_of_the_true_form.ogg') // Vulture sound mixed with fleshtostone.ogg

/datum/action/cooldown/power/gift/scent_of_the_true_form/Activate(atom/target)
	if(!isliving(target))
		return
	if(!(target in range(3, owner)))
		to_chat(owner, span_warning("You can't smell [target] from here."))
		return

	. = ..()

	var/mob/living/victim = target
	var/mob/living/caster = owner
	var/datum/splat/werewolf/target_splat = iswerewolfsplat(victim)

	if(istype(target_splat))
		var/secondary_descriptor = "[pick(wyld_descriptors)]"
		switch(target_splat.tribe?.name)
			if(TRIBE_GLASS_WALKERS)
				secondary_descriptor = "[pick(weaver_descriptors)]"
			if(TRIBE_BONE_GNAWERS)
				secondary_descriptor = "[pick(weaver_descriptors)]"
			if(TRIBE_BLACK_SPIRAL_DANCERS)
				secondary_descriptor = "[pick(wyrm_descriptors)]"
		to_chat(owner, span_purple("[victim] smells like kin[secondary_descriptor ? "...<br>...and of [secondary_descriptor]." : "."]"))
	else
		var/successes = SSroll.storyteller_roll(caster.st_get_stat(STAT_PERCEPTION) + PRIMAL_URGE_PLACEHOLDER, 6, owner, numerical = TRUE)
		switch(successes)
			if(0)
				to_chat(owner, span_purple("You can't exactly tell what [victim] smells like."))
			if(1)
				to_chat(owner, span_purple("[victim] smells mundane."))
			if(2 to 3)
				if(iskindred(victim))
					to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
				if(isshifter(victim) && !isgarou(victim))
					to_chat(owner, span_purple("They smell of kin, but not Garou."))
//				if(ishungrydead(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
//				if(ischangeling(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyld_descriptors)]"))
//				if(isdemon(victim))
//					to_chat(owner, span_purple("[victim] smells of brimstone."))
//				if(ismummy(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyld_descriptors)]"))
			if(4)
				if(iskindred(victim))
					to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
				if(isghoul(victim))
					to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
				if(isshifter(victim) && !isgarou(victim))
					to_chat(owner, span_purple("They smell of kin, but not Garou."))
//				if(isfomor(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyrm_descriptors)]"))
//				if(ischangeling(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyld_descriptors)]"))
//				if(isdemon(victim))
//					to_chat(owner, span_purple("[victim] smells of brimstone."))
//				if(ismummy(victim))
//					to_chat(owner, span_purple("[victim] smells of [pick(wyld_descriptors)]"))
//				if(ismage(victim))
//					to_chat(owner, span_purple("[victim] smells of pure energy."))

	caster.emote("sniff")

	StartCooldown()
	return TRUE

/*
/datum/action/cooldown/power/gift/truth_of_gaia
	name = "Truth Of Gaia"
	desc = "As judges of the Litany, Philodox have the ability to sense whether others have spoken truth or falsehood."
	button_icon_state = "truth_of_gaia"
//	rage_req = 1
*/
