/datum/discipline/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	clan_restricted = TRUE
	power_type = /datum/discipline_power/protean

/datum/discipline_power/protean
	name = "Protean power name"
	desc = "Protean power description"
	abstract_type = /datum/discipline_power/protean

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/protean_activate.ogg'
	deactivate_sound = 'modular_darkpack/modules/deprecated/sounds/protean_deactivate.ogg'

//EYES OF THE BEAST
/datum/discipline_power/protean/eyes_of_the_beast
	name = "Eyes of the Beast"
	desc = "Let your eyes be a gateway to your Beast. Gain its eyes."

	level = 1

	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	violates_masquerade = FALSE

	toggled = TRUE
	var/original_eye_color

/datum/discipline_power/protean/eyes_of_the_beast/activate()
	. = ..()
	ADD_TRAIT(owner, TRAIT_NIGHT_VISION, type)
	owner.update_sight()
	owner.add_eye_color("#ff0000", EYE_COLOR_SPECIES_PRIORITY+1)

/datum/discipline_power/protean/eyes_of_the_beast/deactivate()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_NIGHT_VISION, type)
	owner.update_sight()
	owner.remove_eye_color(EYE_COLOR_SPECIES_PRIORITY+1)

/datum/discipline_power/protean/feral_claws
	name = "Feral Claws"
	desc = "Become a predator and grow hideous talons."

	level = 2

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	toggled = TRUE
	duration_length = 2 TURNS

	grouped_powers = list(
		/datum/discipline_power/protean/earth_meld,
		/datum/discipline_power/protean/shape_of_the_beast,
		/datum/discipline_power/protean/mist_form
	)

/datum/discipline_power/protean/feral_claws/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.put_in_r_hand(new /obj/item/knife/vamp/gangrel(owner))
	owner.put_in_l_hand(new /obj/item/knife/vamp/gangrel(owner))

/datum/discipline_power/protean/feral_claws/deactivate()
	. = ..()
	for(var/obj/item/knife/vamp/gangrel/G in owner.contents)
		qdel(G)

//EARTH MELD
/datum/discipline_power/protean/earth_meld
	name = "Earth Meld"
	desc = "Hide yourself in the earth itself."

	level = 3

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

	grouped_powers = list(
		/datum/discipline_power/protean/feral_claws,
		/datum/discipline_power/protean/shape_of_the_beast,
		/datum/discipline_power/protean/mist_form
	)
	var/obj/effect/decal/dirt_pile/D

/datum/discipline_power/protean/earth_meld/proc/become_soil()
	animate(owner, transform = matrix(), color = "#ffffff", time = 10) // Reset ourselves while we're invisible
	D = new (get_turf(owner)) // Spawn some dirt
	D.alpha = 64 // Subtle dirt
	owner.forceMove(D) // Put ourselves inside the dirt

/datum/discipline_power/protean/earth_meld/pre_activation_checks()
	var/allowed_turfs = list()

	if(!is_type_in_list(owner.loc, allowed_turfs)) // Check if the turf we're standing on is in allowed_turfs
		to_chat(owner, span_warning("You can't meld into the ground here!"))
		return FALSE
	else
		return TRUE

/datum/discipline_power/protean/earth_meld/activate()
	. = ..()
	owner.drop_all_held_items()
	owner.Stun(20 SECONDS) // Dirt can't move, and neither can you!
	animate(owner, transform = matrix()/4, color = "#35240b", time = 10) // Sink into the earth
	addtimer(CALLBACK(src, PROC_REF(become_soil)), 1 SECONDS)

/datum/discipline_power/protean/earth_meld/deactivate()
	. = ..()
	if(owner.IsStun())
		owner.SetStun(0) // End the ongoing stun
	if(!D.expiring) // If D.expiring == 1, the following will occur anyways.
		owner.Knockdown(3 SECONDS) // Get-up lag
		owner.forceMove(get_turf(D))
		D.remove_dirt_pile()

//SHAPE OF THE BEAST
/datum/discipline_power/protean/shape_of_the_beast
	name = "Shape of the Beast"
	desc = "Assume the form of an animal and retain your power."

	level = 4

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

	grouped_powers = list(
		/datum/discipline_power/protean/feral_claws,
		/datum/discipline_power/protean/earth_meld,
		/datum/discipline_power/protean/mist_form
	)

	var/datum/action/cooldown/spell/shapeshift/gangrel/better/GA

/datum/discipline_power/protean/shape_of_the_beast/activate()
	. = ..()
	if (!GA)
		GA = new(owner.mind)
	owner.drop_all_held_items()
	#warn fix
	//GA.Shapeshift(owner)

/datum/discipline_power/protean/shape_of_the_beast/deactivate()
	. = ..()
	//GA.Restore(GA.myshape)
	owner.Stun(1 SECONDS)
	owner.do_jitter_animation(15)



//MIST FORM
/* APOC EDIT REMOVE
/datum/action/cooldown/spell/shapeshift/gangrel/best
	shapeshift_type = /mob/living/simple_animal/hostile/gangrel/best
*/

/datum/discipline_power/protean/mist_form
	name = "Mist Form"
	desc = "Dissipate your body and move as mist."

	level = 5

	check_flags = DISC_CHECK_IMMOBILE | DISC_CHECK_CAPABLE

	violates_masquerade = TRUE

	cancelable = TRUE
	duration_length = 20 SECONDS
	cooldown_length = 20 SECONDS

	grouped_powers = list(
		/datum/discipline_power/protean/feral_claws,
		/datum/discipline_power/protean/earth_meld,
		/datum/discipline_power/protean/shape_of_the_beast
	)

	var/datum/action/cooldown/spell/shapeshift/mist/GA

/datum/discipline_power/protean/mist_form/activate()
	. = ..()
	if (!GA)
		GA = new(owner.mind)
	owner.drop_all_held_items()
	#warn fix
	//GA.Shapeshift(owner)

/datum/discipline_power/protean/mist_form/deactivate()
	. = ..()
	//GA.Restore(GA.myshape)
	owner.Stun(1 SECONDS)
	owner.do_jitter_animation(15)
