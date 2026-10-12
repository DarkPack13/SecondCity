/datum/discipline/animalism
	name = "Animalism"
	desc = {"Commune with and command the beasts of the city.
● Feral Whispers: Tame an animal so it will answer your call. Rolls manipulation + animal ken
●● Beckoning: Call your tamed animals to your side. Rolls charisma + survival
●●● Summon Wolf: Passive
●●●● Summon Bat: Passive
●●●●● Skitter: Passive"}
	icon_state = "animalism"
	power_type = /datum/discipline_power/animalism
	//lazylist
	var/list/tamed_animals

/datum/discipline_power/animalism
	name = "Animalism power name"
	desc = "Animalism power description"
	effect_sound = 'modular_darkpack/modules/werewolf_the_apocalypse/sounds/gifts/wolves.ogg'

//FERAL WHISPERS vtm 20th edition p 129
/datum/discipline_power/animalism/feral_whispers
	name = "Feral Whispers"
	desc = "Lock eyes with an animal and whisper to it. If it heeds you, it will answer your call later."
	level = 1
	target_type = TARGET_MOB
	range = 5
	vitae_cost = 0
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_DIRECT_SEE
	cooldown_length = 1 SECONDS // 5 minutes change to this after testing

/datum/storyteller_roll/feral_whispers
	bumper_text = "feral whispers"
	applicable_stats = list(STAT_MANIPULATION, STAT_ANIMAL_KEN)
	roll_output_type = ROLL_FLAG_ROLLER

/datum/discipline_power/animalism/feral_whispers/pre_activation_checks(atom/target)
	var/mob/living/basic/animal = target
	if(!istype(animal) || !animal.feral_whispers_difficulty || animal.mind || animal.stat == DEAD)
		to_chat(owner, span_warning("[target] has no beast's mind for you to whisper to."))
		return FALSE
	if(animal in owner.beastmaster_minions)
		to_chat(owner, span_warning("[animal] already answers to you."))
		return FALSE
	var/datum/discipline/animalism/animalism = discipline
	if(!istype(animal.ai_controller, /datum/ai_controller/basic_controller/beastmaster_summon) && LAZYLEN(animalism.tamed_animals) >= owner.st_get_stat(STAT_ANIMAL_KEN))
		to_chat(owner, span_warning("You cannot keep any more animals at your call."))
		return FALSE
	animal.face_atom(owner)
	owner.face_atom(animal)
	animal.Stun(1 TURNS)
	if(!do_after(owner, 1 TURNS, animal))
		return FALSE
	return TRUE

/datum/discipline_power/animalism/feral_whispers/activate(mob/living/basic/target)
	. = ..()
	var/datum/discipline/animalism/animalism = discipline
	target.ai_controller?.remove_from_blackboard_lazylist_key(BB_BASIC_MOB_RETALIATE_LIST, owner)
	var/roll = SSroll.storyteller_roll_datum(owner, target, /datum/storyteller_roll/feral_whispers, difficulty = target.feral_whispers_difficulty)
	switch(roll)
		if(ROLL_SUCCESS)
			target.add_ally(owner)
			target.ai_controller?.forgive_target(owner)
			if(istype(target.ai_controller, /datum/ai_controller/basic_controller/beastmaster_summon))
				target.ai_controller.remove_thing_from_blackboard_key(BB_BEASTMASTER_ENEMIES_LIST, owner)
				to_chat(owner, span_notice("[target] calms under your gaze, but it answers to another."))
				return
			LAZYADD(animalism.tamed_animals, target.type)
			to_chat(owner, span_notice("[target] meets your gaze and understands. It will answer when you call."))
		if(ROLL_FAILURE)
			to_chat(owner, span_warning("[target] doesn't heed your whispers."))
		if(ROLL_BOTCH)
			feral_whispers_botch(target)

/datum/discipline_power/animalism/feral_whispers/proc/feral_whispers_botch(mob/living/basic/animal)
	if(prob(50))
		to_chat(owner, span_danger("[animal] bristles at your whispers and lunges at you!"))
		animal.ai_controller?.insert_blackboard_key_lazylist(BB_BASIC_MOB_RETALIATE_LIST, owner)
		return
	to_chat(owner, span_danger("[animal] startles at your whispers and flees!"))
	GLOB.move_manager.move_away(animal, owner, 10, animal.cached_multiplicative_slowdown, 10 SECONDS)

//BECKONING
/datum/discipline_power/animalism/beckoning
	name = "Beckoning"
	desc = "Call out to the animals you have tamed. Each success lets one of them answer."
	level = 2
	vitae_cost = 0
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	cooldown_length = 1 SECONDS // 1 scenes plz

/datum/storyteller_roll/beckoning
	bumper_text = "beckoning"
	applicable_stats = list(STAT_CHARISMA, STAT_SURVIVAL)
	numerical = TRUE
	roll_output_type = ROLL_FLAG_ROLLER

/datum/discipline_power/animalism/beckoning/pre_activation_checks(atom/target)
	var/datum/discipline/animalism/animalism = discipline
	if(!LAZYLEN(animalism.tamed_animals))
		to_chat(owner, span_warning("You have no animals to call."))
		return FALSE
	return TRUE

/datum/discipline_power/animalism/beckoning/activate()
	. = ..()
	var/datum/discipline/animalism/animalism = discipline
	var/successes = SSroll.storyteller_roll_datum(owner, owner, /datum/storyteller_roll/beckoning, difficulty = 6)
	if(successes < 0)
		var/mob/living/basic/lost_animal = pick(animalism.tamed_animals)
		LAZYREMOVE(animalism.tamed_animals, lost_animal)
		to_chat(owner, span_danger("Your call goes unheeded. A [initial(lost_animal.name)] will no longer answer to you."))
		return
	if(!successes)
		to_chat(owner, span_warning("No animals answer your call."))
		return
	choose_animals(successes)


//successes determine how many animals come, 1 success = 1 animal
/datum/discipline_power/animalism/beckoning/proc/choose_animals(successes)
	var/datum/discipline/animalism/animalism = discipline
	for(var/i in 1 to successes)
		if(!LAZYLEN(animalism.tamed_animals) || !owner.can_tame_beastmaster_minion(null, TRUE))
			return
		var/list/choices = list()
		for(var/mob/living/basic/animal_type as anything in animalism.tamed_animals)
			var/datum/radial_menu_choice/choice = new
			choice.name = initial(animal_type.name)
			choice.image = image(initial(animal_type.icon), initial(animal_type.icon_state))
			choices[animal_type] = choice
		var/chosen_type = show_radial_menu(owner, owner, choices, tooltips = TRUE)
		if(!chosen_type || QDELETED(owner))
			return
		call_animal(chosen_type)

/datum/discipline_power/animalism/beckoning/proc/call_animal(animal_type)
	var/datum/discipline/animalism/animalism = discipline

	if(!(animal_type in animalism.tamed_animals))
		return

	LAZYREMOVE(animalism.tamed_animals, animal_type)

	var/mob/living/basic/animal = new animal_type(get_turf(owner))
	animal.alpha = 0
	var/datum/action/innate/togglecorvidflight/corvid_flight = locate() in animal.actions
	var/turf/spawn_turf = find_beckoning_turf(corvid_flight || HAS_TRAIT(animal, TRAIT_MOVE_FLYING))
	animal.forceMove(spawn_turf)
	if(corvid_flight && !HAS_TRAIT(animal, TRAIT_MOVE_FLYING) && isgroundlessturf(spawn_turf))
		corvid_flight.Trigger()
	animate(animal, alpha = 255, time = 1 SECONDS)

	QDEL_NULL(animal.ai_controller)
	animal.ai_controller = new /datum/ai_controller/basic_controller/beastmaster_summon(animal)
	owner.add_beastmaster_minion(animal)

	if(animal.beckoning_sound)
		playsound(animal, animal.beckoning_sound, 50, TRUE)

/datum/discipline_power/animalism/beckoning/proc/find_beckoning_turf(can_fly)
	var/list/candidates = list()
	for(var/turf/open/candidate in view(5, owner))
		if(get_dist(candidate, owner) < 3 || candidate.is_blocked_turf(TRUE))
			continue
		if(!can_fly && isgroundlessturf(candidate))
			continue
		candidates += candidate
	return length(candidates) ? pick(candidates) : get_turf(owner)

//SUMMON WOLF
/datum/discipline_power/animalism/summon_wolf
	name = "Summon Wolf"
	desc = "Summon a spectral wolf to do your bidding."
	level = 3
	violates_masquerade = TRUE
	cooldown_length = 8 SECONDS
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

/datum/discipline_power/animalism/summon_wolf/activate()
	. = ..()
	owner.add_beastmaster_minion(/mob/living/basic/pet/dog/wolf/summoned)

//SUMMON BAT
/datum/discipline_power/animalism/summon_bat
	name = "Summon Bat"
	desc = "Summon a spectral bat to do your bidding."
	level = 4
	violates_masquerade = TRUE
	cooldown_length = 8 SECONDS
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

/datum/discipline_power/animalism/summon_bat/activate()
	. = ..()
	owner.add_beastmaster_minion(/mob/living/basic/bat/summoned)

/datum/action/cooldown/spell/shapeshift/animalism
	name = "Animalism Form"
	desc = "Take on the shape of a rat."
	button_icon_state = "shapeshift"
	cooldown_time = 5 SECONDS
	spell_requirements = NONE
	revert_on_death = TRUE
	die_with_shapeshifted_form = FALSE
	convert_damage = TRUE
	convert_damage_type = BRUTE
	shapeshift_type = /mob/living/basic/mouse/rat
	possible_shapes = list(/mob/living/basic/mouse/rat)

//RAT SHAPESHIFT
/datum/discipline_power/animalism/rat_shapeshift
	name = "Skitter"
	desc = "Become one of the rats that crawl beneath the city."
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING
	level = 5
	violates_masquerade = TRUE
	cooldown_length = 8 SECONDS
	duration_length = 20 SECONDS
	var/datum/action/cooldown/spell/shapeshift/animalism/shapeshift_spell
	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE | DISC_CHECK_LYING

/datum/discipline_power/animalism/rat_shapeshift/activate()
	. = ..()
	if(!ishuman(owner))
		return

	if(!shapeshift_spell)
		shapeshift_spell = new /datum/action/cooldown/spell/shapeshift/animalism()
		shapeshift_spell.spell_requirements = NONE
		shapeshift_spell.Grant(owner)
		RegisterSignal(shapeshift_spell, COMSIG_ACTION_TRIGGER, PROC_REF(on_shapeshift_toggle))

	shapeshift_spell.cast(owner)

/datum/discipline_power/animalism/rat_shapeshift/proc/on_shapeshift_toggle(datum/source)
	SIGNAL_HANDLER
	if(!is_type_in_list(owner, shapeshift_spell.possible_shapes))
		addtimer(CALLBACK(src, PROC_REF(deactivate)), 0.1 SECONDS)

/datum/discipline_power/animalism/rat_shapeshift/deactivate()
	. = ..()
	if(!owner || owner.stat == DEAD)
		return

	if(shapeshift_spell && is_type_in_list(owner, shapeshift_spell.possible_shapes))
		shapeshift_spell.cast(owner)
		owner.Stun(1.5 SECONDS)

/mob/living/basic/pet/dog/wolf/summoned
	name = "wolf"
	desc = "A wolf bound to its master's will."
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
	basic_mob_flags = DEL_ON_DEATH
	mob_biotypes = MOB_ORGANIC
	speed = 0.35
	maxHealth = 80
	health = 80
	melee_damage_lower = 10
	melee_damage_upper = 20
	obj_damage = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'modular_darkpack/modules/deprecated/sounds/dog.ogg'
	random_wolf_color = FALSE
	bloodpool = 2

/mob/living/basic/bat/summoned
	name = "bat"
	desc = "A bat bound to its master's will."
	ai_controller = /datum/ai_controller/basic_controller/beastmaster_summon
	melee_damage_lower = 4
	melee_damage_upper = 10
	obj_damage = 10
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	bloodpool = 2
