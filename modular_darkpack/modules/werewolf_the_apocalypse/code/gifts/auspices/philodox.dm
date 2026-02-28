/datum/action/cooldown/power/gift/scent_of_the_true_form
	name = "Scent Of The True Form"
	desc = "This Gift allows the Garou to determine the true nature of a person."
	button_icon_state = "scent_of_the_true_form"
	click_to_activate = TRUE
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
