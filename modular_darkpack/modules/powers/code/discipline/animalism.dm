/datum/discipline/animalism
	name = "Animalism"
	desc = {"Commune with and command the beasts of the city.
● Feral Whispers: Tame an animal so it will answer your call. Rolls manipulation + animal ken
●● Beckoning: Call your tamed animals to your side. Rolls charisma + survival
●●● Quell the Beast: Intimidate or soothe a target's inner Beast. Rolls manipulation + intimidation or empathy
●●●● Subsume the Spirit: Possess an animal, leaving your body behind. Rolls manipulation + animal ken
●●●●● Drawing Out the Beast: Loose your Beast upon another vampire or ghoul. Rolls manipulation + self-control or instinct"}
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
	cooldown_length = 10 MINUTES
	var/datum/storyteller_roll/feral_whispers/feral_whispers_roll

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
	if(!feral_whispers_roll)
		feral_whispers_roll = new()
	feral_whispers_roll.difficulty = target.feral_whispers_difficulty
	var/roll = feral_whispers_roll.st_roll(owner, target)
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
	cooldown_length = 5 MINUTES
	var/datum/storyteller_roll/beckoning/beckoning_roll

/datum/storyteller_roll/beckoning
	bumper_text = "beckoning"
	applicable_stats = list(STAT_CHARISMA, STAT_SURVIVAL)
	difficulty = 6
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
	if(!beckoning_roll)
		beckoning_roll = new()
	var/successes = beckoning_roll.st_roll(owner, owner)
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

//QUELL THE BEAST
/datum/discipline_power/animalism/quell_the_beast
	name = "Quell the Beast"
	desc = "Lock eyes with someone and intimidate or soothe their inner Beast. Mortals grow sluggish, and the frenzied are calmed."
	level = 3
	target_type = TARGET_HUMAN
	range = 3
	vitae_cost = 0
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_DIRECT_SEE
	cooldown_length = 1 SCENES
	var/chosen_ability
	var/datum/storyteller_roll/quell_the_beast/quell_roll

/datum/storyteller_roll/quell_the_beast
	bumper_text = "quell the beast"
	difficulty = 7
	numerical = TRUE
	roll_output_type = ROLL_FLAG_ROLLER

/datum/discipline_power/animalism/quell_the_beast/pre_activation_checks(atom/target)
	var/choice = tgui_alert(owner, "Intimidate their Beast, or soothe it?", "Quell the Beast", list("Intimidate", "Soothe"))
	if(!choice)
		return FALSE
	chosen_ability = (choice == "Intimidate") ? STAT_INTIMIDATION : STAT_EMPATHY
	var/mob/living/living_target = target
	owner.face_atom(living_target)
	living_target.face_atom(owner)
	if(!do_after(owner, 1 TURNS, living_target, IGNORE_TARGET_LOC_CHANGE, extra_checks = CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(can_see), owner, living_target, range)))
		return FALSE
	return TRUE

/datum/discipline_power/animalism/quell_the_beast/activate(mob/living/carbon/human/target)
	. = ..()
	if(!quell_roll)
		quell_roll = new()
	quell_roll.applicable_stats = list(STAT_MANIPULATION, chosen_ability)
	var/successes = quell_roll.st_roll(owner, target)
	if(successes <= 0)
		to_chat(owner, span_warning("[target]'s Beast does not yield to yours."))
		return
	if(HAS_TRAIT(target, TRAIT_IN_FRENZY))
		target.exit_frenzy_mode()
		to_chat(owner, span_notice("You stare down [target]'s Beast until it slinks back into the dark."))
		to_chat(target, span_notice("Your Beast cowers under [owner]'s gaze, and the frenzy drains out of you."))
	else if(ismundane(target))
		target.apply_status_effect(/datum/status_effect/quelled, successes TURNS)
		to_chat(owner, span_notice("[target]'s will drains away under your gaze."))
	else
		// dont want this to function as a splat checker
		to_chat(owner, span_warning("[target]'s Beast is not so easily intimidated."))
		return

	if(isnpc(target))
		var/mob/living/carbon/human/npc/npc = target
		npc.end_combat()

/datum/status_effect/quelled
	id = "quelled"
	status_type = STATUS_EFFECT_REFRESH
	alert_type = null

/datum/status_effect/quelled/on_creation(mob/living/new_owner, set_duration)
	duration = set_duration
	return ..()

/datum/status_effect/quelled/on_apply()
	owner.add_movespeed_modifier(/datum/movespeed_modifier/quelled)
	to_chat(owner, span_warning("A strange calm settles over you."))
	return TRUE

/datum/status_effect/quelled/on_remove()
	owner.remove_movespeed_modifier(/datum/movespeed_modifier/quelled)

/datum/movespeed_modifier/quelled
	multiplicative_slowdown = 0.4

//SUBSUME THE SPIRIT
/datum/discipline_power/animalism/subsume_the_spirit
	name = "Subsume the Spirit"
	desc = "Lock eyes with an animal and pour your mind into its body, leaving your own behind."
	level = 4
	target_type = TARGET_MOB
	range = 3
	vitae_cost = 0
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_DIRECT_SEE
	cooldown_length = 1 SCENES
	var/datum/storyteller_roll/subsume_the_spirit/subsume_roll

/datum/storyteller_roll/subsume_the_spirit
	bumper_text = "subsume the spirit"
	applicable_stats = list(STAT_MANIPULATION, STAT_ANIMAL_KEN)
	roll_output_type = ROLL_FLAG_ROLLER
	difficulty = 8

/datum/discipline_power/animalism/subsume_the_spirit/pre_activation_checks(atom/target)
	var/mob/living/basic/animal = target
	if(!istype(animal) || !animal.feral_whispers_difficulty || animal.mind || animal.stat == DEAD)
		to_chat(owner, span_warning("[target] has no beast's mind for you to enter."))
		return FALSE
	if(istype(animal.ai_controller, /datum/ai_controller/basic_controller/beastmaster_summon) && !(animal in owner.beastmaster_minions))
		to_chat(owner, span_warning("[animal] is already bound to another's will."))
		return FALSE
	animal.face_atom(owner)
	owner.face_atom(animal)
	animal.Stun(2 TURNS)
	if(!do_after(owner, 2 TURNS, animal))
		return FALSE
	return TRUE

/datum/discipline_power/animalism/subsume_the_spirit/activate(mob/living/basic/target)
	. = ..()
	if(!subsume_roll)
		subsume_roll = new()
	if(subsume_roll.st_roll(owner, target) != ROLL_SUCCESS)
		to_chat(owner, span_warning("[target]'s mind slips away from yours."))
		return
	target.apply_status_effect(/datum/status_effect/subsumed_spirit, owner)

/datum/status_effect/subsumed_spirit
	id = "subsumed_spirit"
	duration = STATUS_EFFECT_PERMANENT
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = null
	var/mob/living/carbon/human/body
	var/datum/action/subsume_return/return_action
	var/datum/storyteller_roll/subsume_return/return_roll
	var/list/animal_stats
	COOLDOWN_DECLARE(body_damage_warning)
	COOLDOWN_DECLARE(return_attempt)

/datum/storyteller_roll/subsume_return
	bumper_text = "return to body"
	applicable_stats = list(STAT_WITS, STAT_EMPATHY)
	difficulty = 8
	roll_output_type = ROLL_FLAG_TARGET

/datum/status_effect/subsumed_spirit/on_creation(mob/living/new_owner, mob/living/carbon/human/caster)
	body = caster
	return ..()

/datum/status_effect/subsumed_spirit/on_apply()
	if(QDELETED(body) || !body.mind)
		return FALSE
	body.mind.transfer_to(owner)
	animal_stats = owner.storyteller_stats
	owner.replace_storyteller_stats(body.storyteller_stats.Copy())
	to_chat(owner, span_notice("You slip into [owner]'s mind, its senses becoming your own."))
	return_action = new(src)
	return_action.Grant(owner)
	RegisterSignal(owner, COMSIG_LIVING_DEATH, PROC_REF(on_animal_death))
	RegisterSignal(body, COMSIG_MOB_APPLY_DAMAGE, PROC_REF(on_body_damaged))
	RegisterSignals(body, list(COMSIG_LIVING_DEATH, SIGNAL_ADDTRAIT(TRAIT_TORPOR)), PROC_REF(on_body_death))
	RegisterSignal(body, COMSIG_QDELETING, PROC_REF(on_body_deleted))
	return TRUE

/datum/status_effect/subsumed_spirit/on_remove()
	QDEL_NULL(return_action)
	QDEL_NULL(return_roll)
	owner.replace_storyteller_stats(animal_stats)
	animal_stats = null
	if(!QDELETED(body) && owner.mind)
		owner.mind.transfer_to(body)
		to_chat(body, span_notice("You return to your own body."))
	body = null

/datum/status_effect/subsumed_spirit/proc/try_return()
	if(!COOLDOWN_FINISHED(src, return_attempt))
		to_chat(owner, span_warning("You need to gather yourself before reaching for your body again."))
		return
	COOLDOWN_START(src, return_attempt, 1 TURNS)
	if(!return_roll)
		return_roll = new()
	if(return_roll.st_roll(body, owner) != ROLL_SUCCESS)
		to_chat(owner, span_warning("You reach for your body, but the animal's mind is too strong."))
		return
	qdel(src)

/datum/status_effect/subsumed_spirit/proc/on_animal_death(datum/source, gibbed)
	SIGNAL_HANDLER
	var/mob/living/carbon/human/caster = body
	qdel(src)
	if(QDELETED(caster))
		return
	to_chat(caster, span_userdanger("You are torn back into your body as the animal dies!"))
	caster.Stun(1 TURNS)
	caster.apply_damage(1 TTRPG_DAMAGE, BRUTE)

/datum/status_effect/subsumed_spirit/proc/on_body_damaged(datum/source, damage, damagetype)
	SIGNAL_HANDLER
	if(!COOLDOWN_FINISHED(src, body_damage_warning))
		return
	COOLDOWN_START(src, body_damage_warning, 2 SECONDS)
	to_chat(owner, span_userdanger("You feel your distant body being harmed!"))

/datum/status_effect/subsumed_spirit/proc/on_body_death(datum/source, gibbed)
	SIGNAL_HANDLER
	qdel(src)

/datum/status_effect/subsumed_spirit/proc/on_body_deleted(datum/source)
	SIGNAL_HANDLER
	body = null
	qdel(src)

/datum/action/subsume_return
	name = "Return to Your Body"
	desc = "Release the animal and return to your own body."
	button_icon = 'modular_darkpack/modules/powers/icons/actions.dmi'
	button_icon_state = "animalism"
	check_flags = NONE

/datum/action/subsume_return/Trigger(mob/clicker, trigger_flags)
	. = ..()
	if(!.)
		return
	var/datum/status_effect/subsumed_spirit/subsumed = target
	subsumed.try_return()

//DRAWING OUT THE BEAST
/datum/discipline_power/animalism/drawing_out_the_beast
	name = "Drawing Out the Beast"
	desc = "Loose your Beast upon another vampire or ghoul. Easier while you are already in its grip, but if it slips its leash, it turns on you instead."
	level = 5
	target_type = TARGET_HUMAN
	range = 7
	vitae_cost = 0
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE | DISC_CHECK_DIRECT_SEE
	frenzy_usable = TRUE
	cooldown_length = 5 SCENES // 15 minutes
	var/datum/storyteller_roll/drawing_out_the_beast/drawing_out_roll

/datum/storyteller_roll/drawing_out_the_beast
	bumper_text = "drawing out the beast"
	difficulty = 8
	roll_output_type = ROLL_FLAG_ROLLER

/datum/storyteller_roll/drawing_out_the_beast/using_stats(mob/living/roller)
	return list(STAT_MANIPULATION, roller.is_enlightenment() ? STAT_INSTINCT : STAT_SELF_CONTROL)

/datum/storyteller_roll/drawing_out_the_beast/using_difficulty(mob/living/roller, atom/target)
	. = ..()
	if(HAS_TRAIT(roller, TRAIT_IN_FRENZY))
		. -= 2

/datum/discipline_power/animalism/drawing_out_the_beast/pre_activation_checks(atom/target)
	var/mob/living/carbon/human/human_target = target
	if(HAS_TRAIT(human_target, TRAIT_IN_FRENZY))
		to_chat(owner, span_warning("[human_target] is already in the grip of a Beast."))
		return FALSE
	return TRUE

/datum/discipline_power/animalism/drawing_out_the_beast/activate(mob/living/carbon/human/target)
	. = ..()
	var/frenzying = HAS_TRAIT(owner, TRAIT_IN_FRENZY)
	if(!drawing_out_roll)
		drawing_out_roll = new()
	if(drawing_out_roll.st_roll(owner, target) != ROLL_SUCCESS)
		beast_turns_inward(frenzying)
		return
	if(!get_vampire_splat(target))
		to_chat(owner, span_warning("Your Beast finds nothing in [target] to take hold of, and slinks back to you."))
		return
	if(frenzying)
		owner.exit_frenzy_mode()
	to_chat(owner, span_notice("You loose your Beast upon [target]."))
	to_chat(target, span_userdanger("Something feral claws its way into you from [owner]!"))
	target.enter_frenzy_mode(get_closest_atom(/atom, target.get_frenzy_victims(), target), source = "Drawing Out the Beast")

/datum/discipline_power/animalism/drawing_out_the_beast/proc/beast_turns_inward(frenzying)
	to_chat(owner, span_userdanger("Your Beast slips its leash and turns on you!"))
	if(!frenzying)
		owner.enter_frenzy_mode(get_closest_atom(/atom, owner.get_frenzy_victims(), owner), source = "Drawing Out the Beast", duration = 2 SCENES)
		return
	for(var/datum/status_effect/frenzy/frenzy in owner.status_effects)
		frenzy.duration = 2 SCENES

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

