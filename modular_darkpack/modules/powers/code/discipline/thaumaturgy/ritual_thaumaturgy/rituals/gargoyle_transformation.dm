// **************************************************************** GARGOYLE TRANSFORMATION *************************************************************


/obj/ritualrune/gargoyle
	name = "Gargoyle Transformation"
	desc = "Create a Gargoyle from vampire bodies. One body creates a normal Gargoyle, two bodies create a perfect Gargoyle."
	icon_state = "rune9"
	word = "FORMA-GARGONEM"
	thaumlevel = 5
	var/duration_length = 60 SECONDS

/obj/ritualrune/gargoyle/complete()
	// vampire bodies only
	var/list/valid_bodies = list()

	for(var/mob/living/carbon/human/H in loc)
		if(H && H.dna && istype(H.dna.species, /datum/species/kindred))
			if(H == usr)
				to_chat(usr, span_warning("You may not turn yourself into a Gargoyle!"))
				return
			else if(H.clan?.name == VAMPIRE_CLAN_GARGOYLE)
				to_chat(usr, span_warning("You may not use this ritual on a Gargoyle!"))
				return
			else if(H.stat > SOFT_CRIT)
				valid_bodies += H
			else
				H.adjustCloneLoss(50)
				playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 10, FALSE)
				to_chat(usr, "Your specimen must be incapacitated! The ritual has merely hurt them!")
				return


	if(valid_bodies.len < 1)
		to_chat(usr, span_warning("The ritual requires at least one vampire body!"))
		return

	// Begin the ritual
	var/body_count = valid_bodies.len
	to_chat(usr, span_notice("You begin invoking the ritual of Gargoyle Creation with [body_count] vampire bod[body_count == 1 ? "y" : "ies"]..."))
	usr.visible_message(span_notice("[usr] begins invoking a ritual with [body_count] vampire bod[body_count == 1 ? "y" : "ies"]..."))

	playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 50, FALSE)
	playsound(loc, 'code/modules/wod13/sounds/vicissitude.ogg', 50, FALSE)

	// Apply stun so that they cant just crawl away in crit - caster must also stay still
	for(var/mob/living/carbon/human/H in valid_bodies)
		H.Stun(600)
		H.emote("twitch")

	// Start the transformation process
	if(do_after(usr, duration_length, usr))
		activated = TRUE
		last_activator = usr

		// Determine if we're creating a perfect gargoyle (2+ bodies) or regular (1 body)
		var/perfect_gargoyle = (body_count >= 2)

		var/transformation_message
		if(perfect_gargoyle)
			transformation_message = span_gargoylealert("The bodies begin to merge and petrify into a massive stone form!")
		else
			transformation_message = span_gargoylealert("The body begins to petrify into a stone form!")
		visible_message(transformation_message)

		// Complete the transformation
		addtimer(CALLBACK(src, PROC_REF(gargoyle_transform), valid_bodies, perfect_gargoyle), 1 SECONDS)
	else
		to_chat(usr, span_warning("Your ritual was interrupted!"))
		// Unstun the bodies if interrupted
		for(var/mob/living/carbon/human/H in valid_bodies)
			H.Stun(5) // Brief stun to recover

/obj/ritualrune/gargoyle/proc/gargoyle_transform(list/bodies, perfect_gargoyle = FALSE)
	if(!bodies || bodies.len < 1)
		return

	if(perfect_gargoyle)
		// Create perfect gargoyle (2+ bodies) -- you'd have to frag two different kindred players to create a perfect gargoyle.
		var/mob/living/simple_animal/hostile/gargoyle/perfect/G = new /mob/living/simple_animal/hostile/gargoyle/perfect(loc)
		G.visible_message(span_gargoylealert("A massive perfect Gargoyle rises from the ritual!"))

		// Ensure perfect gargoyle is at full health
		G.revive(TRUE)
		G.health = G.maxHealth
		G.apply_status_effect(STATUS_EFFECT_INLOVE, usr)

		// Handle the other bodies
		for(var/mob/living/carbon/human/H in bodies)
			if(!QDELETED(H))
				for(var/datum/action/A in H.actions)
					if(A && A.vampiric)
						A.Remove(H)

				H.gib(FALSE, FALSE, TRUE)

		// This function asks the ghosts and observers if theyd like to control the perfect Gargoyle. No clue why it's named that or what it stands for. It's from tzimisce.dm.
		G.gain_sentience()

		playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 50, FALSE)
		playsound(loc, 'code/modules/wod13/sounds/vicissitude.ogg', 50, FALSE)
	else
		// Create normal sentient gargoyle (1 body)
		var/mob/living/carbon/human/target_body = bodies[1]
		var/old_name = target_body.real_name

		// Transform the body into a gargoyle
		if(!target_body || QDELETED(target_body) || target_body.stat > DEAD)
			return

		// Remove any vampiric actions
		for(var/datum/action/A in target_body.actions)
			if(A && A.vampiric)
				A.Remove(target_body)

		var/original_location = get_turf(target_body)

		// Revive the specimen and turn them into a gargoyle kindred
		target_body.revive(TRUE)
		target_body.set_species(/datum/species/kindred)
		target_body.set_clan(/datum/vampire_clan/gargoyle)
		target_body.apply_status_effect(STATUS_EFFECT_INLOVE, usr)
		target_body.real_name = old_name // the ritual for some reason is deleting their old name and replacing it with a random name.
		target_body.name = old_name
		target_body.update_name()

		target_body.create_disciplines(FALSE, target_body.clan.clan_disciplines)

		if(target_body.loc != original_location)
			target_body.forceMove(original_location)

		playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 50, FALSE)
		playsound(target_body.loc, 'code/modules/wod13/sounds/vicissitude.ogg', 50, FALSE)

		// Handle key assignment
		if(!target_body.key)
			var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you wish to play as Sentient Gargoyle?", null, null, null, 20 SECONDS, src)
			for(var/mob/dead/observer/G in GLOB.player_list)
				if(G.key)
					to_chat(G, span_ghostalert("Gargoyle Transformation rune has been triggered."))
			if(LAZYLEN(candidates))
				var/mob/dead/observer/C = pick(candidates)
				target_body.key = C.key

			var/choice = tgui_alert(target_body, "Do you want to pick a new name as a Gargoyle?", "Gargoyle Choose Name", list("Yes", "No"), 10 SECONDS)
			if(choice == "Yes")
				var/chosen_gargoyle_name = tgui_input_text(target_body, "What is your new name as a Gargoyle?", "Gargoyle Name Input")
				target_body.real_name = chosen_gargoyle_name
				target_body.name = chosen_gargoyle_name
				target_body.update_name()
			else
				target_body.visible_message(span_gargoylealert("A Gargoyle rises from the ritual!"))
				qdel(src)
				return

		target_body.visible_message(span_gargoylealert("A Gargoyle rises from the ritual!"))

	qdel(src)

// Perfect Gargoyle definition
/mob/living/simple_animal/hostile/gargoyle/perfect
	name = "Perfect Gargoyle"
	desc = "A massive stone-skinned monstrosity with enhanced strength and durability."
	icon_state = "gargoyle_m"
	icon_living = "gargoyle_m"
	mob_size = MOB_SIZE_LARGE
	speed = -2
	maxHealth = 600
	health = 600
	harm_intent_damage = 8
	melee_damage_lower = 35
	melee_damage_upper = 60
	attack_verb_continuous = "brutally crushes"
	attack_verb_simple = "brutally crush"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	bloodpool = 15
	maxbloodpool = 15

/mob/living/simple_animal/hostile/gargoyle/perfect/Initialize()
	. = ..()
	// Make the perfect gargoyle slightly larger
	transform = transform.Scale(1.10, 1.10)
