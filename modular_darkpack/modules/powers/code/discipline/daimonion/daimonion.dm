/datum/discipline/daimonion
	name = "Daimonion"
	desc = "Draw power from the demons and infernal nature of Hell. Use subtle power to manipulate people and when you must, draw upon fire itself and protect yourself."
	icon_state = "daimonion"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/daimonion

/datum/discipline_power/daimonion
	name = "Daimonion power name"
	desc = "Daimonion power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/protean_activate.ogg'
	deactivate_sound = 'modular_darkpack/modules/deprecated/sounds/protean_deactivate.ogg'

//SENSE THE SIN
/datum/discipline_power/daimonion/sense_the_sin
	name = "Sense the Sin"
	desc = "Sense the sins and cruelties of your victim."

	target_type = TARGET_HUMAN
	range = 7
	level = 1

	cancelable = TRUE
	var/datum/storyteller_roll/sense_the_sin/sense_the_sin_roll

/datum/storyteller_roll/sense_the_sin
	bumper_text = "sense the sin"
	applicable_stats = list(STAT_PERCEPTION, STAT_EMPATHY)
	roll_output_type = ROLL_PRIVATE

/datum/discipline_power/daimonion/sense_the_sin/pre_activation_checks(mob/living/target)
	if(!sense_the_sin_roll)
		sense_the_sin_roll = new()
	sense_the_sin_roll.difficulty = max(target.st_get_stat(STAT_SELF_CONTROL), target.st_get_stat(STAT_INSTINCT)) + 4
	var/roll = sense_the_sin_roll.st_roll(owner, target)
	if(roll != ROLL_SUCCESS)
		return FALSE
	else
		return TRUE

/datum/discipline_power/daimonion/sense_the_sin/activate(mob/living/carbon/human/target)
	. = ..()
	if(target.st_get_stat(STAT_CHARISMA) <= 2)
		to_chat(owner, span_notice("they are not social or influencing."))
	if(target.st_get_stat(STAT_PERMANENT_WILLPOWER) <= 2)
		to_chat(owner, span_notice("they lack appropiate willpower."))
	if(target.st_get_stat(STAT_STRENGTH) <= 2)
		to_chat(owner, span_notice("their body is weak and feeble."))
	if(target.st_get_stat(STAT_DEXTERITY) <= 2)
		to_chat(owner, span_notice("they lack coordination."))
	if(isgarou(target))
		to_chat(owner, span_notice("their natural banishment is silver..."))
	if(iskindred(target))
		baali_get_moral_failings(target, owner)
		baali_get_stolen_disciplines(target, owner)
	/* DARKPACK TODO - bloodbonds
	if(isghoul(target))
		var/mob/living/carbon/human/ghoul = target

		if(ghoul.mind.enslaved_to)
			to_chat(owner, span_notice("Victim is addicted to vampiric vitae and its true master is [ghoul.mind.enslaved_to]"))
		else
			to_chat(owner, span_notice("Victim is addicted to vampiric vitae, but is independent and free."))
	*/
	/* DARKPACK TODO : Kuei-Jin
	if(iscathayan(target))
		if(target.mind.dharma?.Po == "Legalist")
			to_chat(owner, span_notice("[target] hates to be controlled!"))
		if(target.mind.dharma?.Po == "Rebel")
			to_chat(owner, span_notice("[target] doesn't like to be touched."))
		if(target.mind.dharma?.Po == "Monkey")
			to_chat(owner, span_notice("[target] is too focused on money, toys and other sources of easy pleasure."))
		if(target.mind.dharma?.Po == "Demon")
			to_chat(owner, span_notice("[target] is addicted to pain, as well as to inflicting it to others."))
		if(target.mind.dharma?.Po == "Fool")
			to_chat(owner, span_notice("[target] doesn't like to be pointed at!"))
	*/
	if(!iskindred(target) && !isghoul(target) && !isshifter(target) /*&& !iscathayan(target)*/)
		to_chat(owner, span_notice("[target] is a feeble worm with no strengths or visible weaknesses, a mere human."))

/datum/discipline_power/daimonion/sense_the_sin/proc/baali_get_moral_failings(target, owner)
	if(!owner || !target)
		return
	var/datum/splat/vampire/kindred/vampire = iskindred(target)
	if(vampire)
		switch(vampire.clan.id)
			if(VAMPIRE_CLAN_VENTRUE)
				to_chat(owner, span_notice("[target] finds no pleasure in poor's blood."))
				return
			if(VAMPIRE_CLAN_LASOMBRA)
				to_chat(owner, span_notice("[target] fears change itself evermore."))
				return
			if(VAMPIRE_CLAN_TZIMISCE)
				to_chat(owner, span_notice("[target] is consumed by a singular desire."))
				return
			if(VAMPIRE_CLAN_GANGREL)
				to_chat(owner, span_notice("[target] is unable to control their impulses."))
				return
			if(VAMPIRE_CLAN_MALKAVIAN)
				to_chat(owner, span_notice("[target] frightens people near them."))
				return
			if(VAMPIRE_CLAN_BRUJAH)
				to_chat(owner, span_notice("[target] is cursed to anger for their shame at carthage.."))
			if(VAMPIRE_CLAN_NOSFERATU)
				to_chat(owner, span_notice("[target] is entranced by that which is unknown."))
				return
			if(VAMPIRE_CLAN_TREMERE)
				to_chat(owner, span_notice("[target] has a sense of perfectionism by their own actions."))
				return
			if(VAMPIRE_CLAN_BAALI)
				to_chat(owner, span_notice("[target] is scared of the lord's presence."))
				return
			if(VAMPIRE_CLAN_BANU_HAQIM)
				to_chat(owner, span_notice("[target] sees themselves as absolute judgement."))
				return
			if(VAMPIRE_CLAN_TRUE_BRUJAH)
				to_chat(owner, span_notice("[target] cant express emotions."))
				return
			/* DARKPACK TODO: Warrior Salubri / Salubri Warrior
			if(VAMPIRE_CLAN_SALUBRI_WARRIOR)
				to_chat(owner, span_notice("[target] pursues an endless revenge."))
				return
			*/



/datum/discipline_power/daimonion/sense_the_sin/proc/baali_get_stolen_disciplines(target, owner)
	if(!owner || !target)
		return
	var/datum/splat/vampire/kindred/vampire = iskindred(target)
	if(vampire)
		var/datum/subsplat/vampire_clan/clan = vampire.clan
		if(vampire.get_discipline("Quietus") && clan.id != VAMPIRE_CLAN_BANU_HAQIM)
			to_chat(owner, span_notice("[target] fears that the fact they stole Banu Haqim's Quietus will be known."))
		if(vampire.get_discipline("Protean") && clan.id != VAMPIRE_CLAN_GANGREL)
			to_chat(owner, span_notice("[target] fears that the fact they stole Gangrel's Protean will be known."))
		if(vampire.get_discipline("Serpentis") && clan.id != VAMPIRE_CLAN_SETITE)
			to_chat(owner, span_notice("[target] fears that the fact they stole the Setite's Serpentis will be known."))
		if(vampire.get_discipline("Necromancy") && clan.id != VAMPIRE_CLAN_GIOVANNI || vampire.get_discipline("Necromancy") && clan.id != VAMPIRE_CLAN_CAPPADOCIAN)
			to_chat(owner, span_notice("[target] fears that the fact they stole Giovanni's Necromancy will be known."))
		if(vampire.get_discipline("Obtenebration") && clan.id != VAMPIRE_CLAN_LASOMBRA)
			to_chat(owner, span_notice("[target] fears that the fact they stole Lasombra's Obtenebration will be known."))
		if(vampire.get_discipline("Dementation") && clan.id != VAMPIRE_CLAN_MALKAVIAN)
			to_chat(owner, span_notice("[target] fears that the fact they stole Malkavian's Dementation will be known."))
		if(vampire.get_discipline("Vicissitude") && clan.id != VAMPIRE_CLAN_TZIMISCE)
			to_chat(owner, span_notice("[target] fears that the fact they stole Tzimisce's Vicissitude will be known."))
		if(vampire.get_discipline("Melpominee") && clan.id != VAMPIRE_CLAN_DAUGHTERS_OF_CACOPHONY)
			to_chat(owner, span_notice("[target] fears that the fact they stole Daughters of Cacophony's Melpominee will be known."))
		if(vampire.get_discipline("Daimonion") && clan.id != VAMPIRE_CLAN_BAALI)
			to_chat(owner, span_notice("[target] fears that the fact they stole Baali's Daimonion will be known."))
		if(vampire.get_discipline("Temporis") && clan.id != VAMPIRE_CLAN_TRUE_BRUJAH)
			to_chat(owner, span_notice("[target] fears that the fact they stole True Brujah's Temporis will be known."))
		if(vampire.get_discipline("Valeren") && clan.id != VAMPIRE_CLAN_SALUBRI)
			to_chat(owner, span_notice("[target] fears that the fact they stole Salubri's Valeren will be known."))
		if(vampire.get_discipline("Mytherceria") && clan.id != VAMPIRE_CLAN_KIASYD)
			to_chat(owner, span_notice("[target] fears that the fact they stole Kiasyd's Mytherceria will be known."))

//FEAR OF THE VOID BELOW
/datum/discipline_power/daimonion/fear_of_the_void_below
	name = "Fear of the Void Below"
	desc = "Induce fear in a target."

	level = 2
	check_flags = DISC_CHECK_CONSCIOUS

	target_type = TARGET_HUMAN
	range = 7

	duration_length = 3 SECONDS
	var/datum/storyteller_roll/fear_of_the_void_below/fear_of_the_void_below_roll

/datum/storyteller_roll/fear_of_the_void_below
	bumper_text = "fear of the void below"
	applicable_stats = list(STAT_WITS, STAT_INTIMIDATION)
	roll_output_type = ROLL_PRIVATE

/datum/discipline_power/daimonion/fear_of_the_void_below/pre_activation_checks(mob/living/target)
	if(!fear_of_the_void_below_roll)
		fear_of_the_void_below_roll = new()
	fear_of_the_void_below_roll.difficulty = target.st_get_stat(STAT_COURAGE) + 4
	var/roll = fear_of_the_void_below_roll.st_roll(owner, target)
	if(roll != ROLL_SUCCESS)
		to_chat(owner, span_warning("[target] has too much willpower to induce fear into them!"))
		return FALSE
	return TRUE

/datum/discipline_power/daimonion/fear_of_the_void_below/activate(mob/living/carbon/human/target)
	. = ..()
	to_chat(target, span_warning("Your mind is enveloped by your greatest fear!"))
	if(prob(50)) // REPLACE THIS - the people hate hardstuns
		target.Paralyze(6 SECONDS)
	else
		target.Sleeping(6 SECONDS)

//CONFLAGRATION
/datum/discipline_power/daimonion/conflagration
	name = "Conflagration"
	desc = "Draw out the destructive essence of the Beyond."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 7
	activate_sound = 'modular_darkpack/modules/powers/sounds/daimonion_fireball.ogg'
	aggravating = TRUE
	hostile = TRUE
	violates_masquerade = TRUE

/obj/projectile/flames/baali
	color = "#1c1f1d"
	damage = 25
	damage_type = AGGRAVATED

/datum/discipline_power/daimonion/conflagration/activate(mob/living/target)
	. = ..()
	var/turf/start = get_turf(owner)
	var/obj/projectile/flames/baali/created_fireball = new(start)
	created_fireball.firer = owner
	var/angle = get_angle(owner, target)
	created_fireball.fire(angle, target)

//PSYCHOMANIA
/datum/discipline_power/daimonion/psychomania
	name = "Psychomania"
	desc = "Bring forth the target's greatest fear."

	level = 4
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	target_type = TARGET_LIVING
	range = 7

	violates_masquerade = FALSE
	var/datum/storyteller_roll/psychomania/psychomania_roll

/datum/storyteller_roll/psychomania
	bumper_text = "psychomania"
	roll_output_type = ROLL_PRIVATE

/datum/discipline_power/daimonion/psychomania/pre_activation_checks(mob/living/target)
	if(!psychomania_roll)
		psychomania_roll = new()

	//forces the subject's player to roll her lowest Virtue
	var/datum/st_stat/virtue/lowest_virtue
	for(var/virtue_type in subtypesof(/datum/st_stat/virtue))
		var/datum/st_stat/virtue/target_stat = target.storyteller_stats["[virtue_type]"]
		if(!lowest_virtue || target_stat.get_score() < lowest_virtue.get_score())
			lowest_virtue = target_stat

	psychomania_roll.applicable_stats = list(lowest_virtue)
	var/roll = psychomania_roll.st_roll(target, owner)

	if(roll != ROLL_SUCCESS)
		to_chat(owner, span_cult("[target] will suffer greatly."))
		return TRUE

	to_chat(owner, span_warning("[target] is too pure to manifest their fears!"))
	return FALSE

/datum/discipline_power/daimonion/psychomania/activate(mob/living/target)
	. = ..()

	var/datum/splat/werewolf/shifter/garou_splat = isshifter(target)
	if(garou_splat)
		switch(garou_splat.tribe.name)
			if(TRIBE_BLACK_SPIRAL_DANCERS)
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
				target.visible_message(span_warning("[target] whines in animalistic fear"), span_cult("VISIONS OF BRIMSTONE AND FLAME FLASH BEFORE MY EYES"),)
				target.Paralyze(5 SECONDS)
			else
				if(garou_splat.rage > 4)
					target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh1.ogg", 50, FALSE)
					to_chat(target, span_cult("THE WYRMFOE IS ALL AROUND ME"))
					new /datum/hallucination/delusion(target, TRUE, "dancer", 200, 0)
					//target.rollfrenzy() DARKPACK TODO: Frenzy
				else
					to_chat(target, span_cult("I can feel a overwhelming presence.. I NEED TO RUN!!"))
					var/obj/effect/client_image_holder/baali_demon/wyrm/demon = new(get_turf(target), list(target))
					RegisterSignal(demon, COMSIG_BAALI_DEMON_REACHED_TARGET, PROC_REF(on_demon_contact))
					target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh2.ogg", 50, FALSE)

	var/datum/splat/vampire/kindred/kindred_splat = iskindred(target)
	if(kindred_splat)
		switch(kindred_splat.clan.id)
			if(VAMPIRE_CLAN_TOREADOR)
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh2.ogg", 50, FALSE)
				new /datum/hallucination/fire(target, TRUE)
				to_chat(target, span_cult("FLAMES ENGULF MY BEAUTY"))
				target.Paralyze(5 SECONDS)
				return
			if(VAMPIRE_CLAN_LASOMBRA)
				to_chat(target, span_cult("THE SHADOWS BETRAY ME, SEEKING MY LIFE"))
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
				//target.blind_eyes(6 SECONDS) ok how do i make something blind
				target.Paralyze(6 SECONDS)
				return
			if(VAMPIRE_CLAN_BRUJAH)
				to_chat(target, span_warning("You see visions of an underground stone monument weeping blood."))
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
				to_chat(target, span_cult("THE BEAST RAGES AGAINST THIS VISION!!"))
				//target.rollfrenzy() DARKPACK TODO : Frenzy
			if(VAMPIRE_CLAN_TZIMISCE)
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh3.ogg", 50, FALSE)
				to_chat(target, span_cult("I SEE VISIONS OF FLAME ENGULFING MY DOMAIN"))
				new /datum/hallucination/fire(target, TRUE)
				target.Paralyze(6 SECONDS)
				return
			if(VAMPIRE_CLAN_MALKAVIAN)
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/malklaugh.ogg", 50, FALSE)
				target.Paralyze(6 SECONDS)
				target.visible_message(span_warning("[target] repeatedly bashes their head against the ground"), span_cult("THE WHISPERS ARE OVERTAKING ME"),)
				target.apply_damage(50, BRUTE, BODY_ZONE_HEAD)
				return
			if(VAMPIRE_CLAN_TREMERE)
				to_chat(target, span_cult("Blood pours out from my body, manifesting into a grotesque form"))
				var/obj/effect/client_image_holder/baali_demon/tremere/demon = new(get_turf(target), list(target))
				RegisterSignal(demon, COMSIG_BAALI_DEMON_REACHED_TARGET, PROC_REF(on_demon_contact))
				return
			if(VAMPIRE_CLAN_BAALI)
				to_chat(target, span_notice("The sacred icons appearing before you lack the true substance of faith"))
				new /datum/hallucination/delusion(target, TRUE, "repent", 200, 0)
				to_chat(owner, span_notice("Your illusions are easily dispelled by [target]"))
				return
			if(VAMPIRE_CLAN_BANU_HAQIM)
				to_chat(target, span_cult("An overwhelming presence manifests around me.."))
				var/obj/effect/client_image_holder/baali_demon/banu/demon = new(get_turf(target), list(target))
				RegisterSignal(demon, COMSIG_BAALI_DEMON_REACHED_TARGET, PROC_REF(on_demon_contact))
				return
			if(VAMPIRE_CLAN_SALUBRI)
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh1.ogg", 50, FALSE)
				to_chat(target, span_warning("My third eye begins to reflexively open.."))
				target.visible_message(span_warning("[target] tightly grasps their forehead, trying to conceal something"), span_cult("I MUST HIDE MY NATURE"),)
				target.apply_damage(50, BRUTE, BODY_ZONE_HEAD)
				target.Paralyze(6 SECONDS)
				return
			/* DARKPACK TODO: Warrior Salubri / Salubri Warrior
			if(VAMPIRE_CLAN_SALUBRI_WARRIOR)
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh2.ogg", 50, FALSE)
				to_chat(target, span_cult("BRIMSTONE AND FLAME AWAIT ME BEFORE MY REVENGE'S END"))
				target.rollfrenzy()
				return
			*/
			if(VAMPIRE_CLAN_GIOVANNI)
				to_chat(target, span_cult("A sense of profound dread enters you as soundless words enter your mind"))
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
				var/obj/effect/client_image_holder/baali_demon/spectre/demon = new(get_turf(target), list(target))
				RegisterSignal(demon, COMSIG_BAALI_DEMON_REACHED_TARGET, PROC_REF(on_demon_contact))
				return
			if(VAMPIRE_CLAN_CAPPADOCIAN)
				to_chat(target, span_cult("Freshly manifest despair enters your decaying flesh as you feel a hauntingly empty presence."))
				target.playsound_local(target, "modular_darkpack/modules/powers/sounds/daimonion_laughs/eldritchlaugh.ogg", 50, FALSE)
				var/obj/effect/client_image_holder/baali_demon/spectre/demon = new(get_turf(target), list(target))
				RegisterSignal(demon, COMSIG_BAALI_DEMON_REACHED_TARGET, PROC_REF(on_demon_contact))
				return
			else
				to_chat(target, span_cult("THE BEAST SCREAMS IN MY MIND TO RUN"))
				var/obj/effect/client_image_holder/baali_demon/demon = new(get_turf(target), list(target))
				RegisterSignal(demon, COMSIG_BAALI_DEMON_REACHED_TARGET, PROC_REF(on_demon_contact))
				return

	if(isghoul(target))
		to_chat(target, span_cult("SOMETHING IS COMING, WHAT IS IT?!!"))
		var/obj/effect/client_image_holder/baali_demon/demon = new(get_turf(target), list(target))
		RegisterSignal(demon, COMSIG_BAALI_DEMON_REACHED_TARGET, PROC_REF(on_demon_contact))

	if(!iskindred(target) && !isghoul(target) && !isgarou(target))
		to_chat(target, span_cult("MY WORST NIGHTMARES FLASH BEFORE MY EYES"))
		target.Paralyze(7 SECONDS)

/datum/discipline_power/daimonion/psychomania/proc/on_demon_contact(obj/effect/client_image_holder/baali_demon/source, mob/living/victim)
	SIGNAL_HANDLER
	switch(source.type)
		if(/obj/effect/client_image_holder/baali_demon/spectre)
			victim.visible_message(span_warning("[victim] collapses onto the ground"), span_warning("[source.name] touches you with an outstretched hand"))
			victim.Paralyze(7 SECONDS)
			victim.adjust_stamina_loss(200)
			to_chat(victim, span_cult("THE SPIRIT HAS TAKEN SOMETHING FROM ME"))

		if(/obj/effect/client_image_holder/baali_demon/wyrm)
			victim.visible_message(span_warning("[victim] whines in animalistic fear"), span_cult("THE WYRM HAS NOTICED ME"))
			victim.Paralyze(5 SECONDS)
			victim.playsound_local(victim, "modular_darkpack/modules/powers/sounds/daimonion_laughs/malklaugh.ogg", 50, FALSE)

		if(/obj/effect/client_image_holder/baali_demon/banu)
			victim.visible_message(span_warning("[victim] grasps their chest, feeling for a hole"), span_cult("THE [source.name] PLUCKS OUT YOUR HEART"))
			victim.Paralyze(7 SECONDS)

		if(/obj/effect/client_image_holder/baali_demon/tremere)
			victim.visible_message(span_warning("[victim] collapses onto the ground, convulsing"), span_cult("THE [source.name] TAKES YOUR VITAE"))
			victim.playsound_local(victim, "modular_darkpack/modules/powers/sounds/daimonion_laughs/malklaugh.ogg", 50, FALSE)
			victim.Paralyze(7 SECONDS)

		else
			victim.visible_message(span_warning("[victim] falls on their knees"), span_warning("[source.name] grasps your head with its hands"))
			victim.Paralyze(7 SECONDS)
			victim.adjust_stamina_loss(200)
			victim.playsound_local(victim, "modular_darkpack/modules/powers/sounds/daimonion_laughs/demonlaugh1.ogg", 50, FALSE)
			to_chat(victim, span_cult("HELL IS REAL, IT HAS TOUCHED ME"))

	step_away(victim, get_turf(source))

//CONDEMNATION
/datum/discipline_power/daimonion/condemnation
	name = "Condemnation"
	desc = "Condemn a soul to suffering."

	level = 5
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_IMMOBILE
	target_type = TARGET_LIVING
	range = 7
	violates_masquerade = TRUE
	var/datum/storyteller_roll/condemnation/condemnation_roll
	var/list/available_curses

/datum/storyteller_roll/condemnation
	bumper_text = "condemnation"
	applicable_stats = list(STAT_INTELLIGENCE, STAT_OCCULT)
	roll_output_type = ROLL_PRIVATE

/datum/discipline_power/daimonion/condemnation/activate(mob/living/target)
	. = ..()

	if(target.has_status_effect(/datum/status_effect/condemnation))
		to_chat(owner, span_warning("They are already damned!"))
		return

	var/datum/splat/vampire/kindred/kindred_splat = iskindred(owner)
	if(!available_curses)
		for(var/curse_type in subtypesof(/datum/status_effect/condemnation))
			var/datum/status_effect/condemnation/curse = curse_type
			if(kindred_splat.generation <= curse.genrequired)
				LAZYSET(available_curses, curse.name, curse_type)

	var/chosen_curse_name = tgui_input_list(owner, "What curse shall befall the damned?", "Curse Selection", available_curses)
	if(!chosen_curse_name)
		return

	var/datum/status_effect/condemnation/chosen_curse_datum = available_curses[chosen_curse_name]

	if(!condemnation_roll)
		condemnation_roll = new()

	condemnation_roll.difficulty = target.st_get_stat(STAT_TEMPORARY_WILLPOWER)
	var/roll = condemnation_roll.st_roll(owner, target)
	if(roll != ROLL_SUCCESS)
		to_chat(owner, span_warning("You fail to pierce their mind and the target remains free of your curse."))
		//not sure if target should get a to_chat?
		return

	target.apply_status_effect(chosen_curse_datum)
	owner.maxbloodpool -= chosen_curse_datum.bloodcost
	if(owner.bloodpool > owner.maxbloodpool)
		owner.bloodpool = owner.maxbloodpool


