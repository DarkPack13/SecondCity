/obj/item/reagent_containers/food/drinks/silver_goblet
	name = "silver goblet"
	desc = "A gleaming goblet used in ancient vampire rites."
	icon_state = "pewter_cup"
	w_class = WEIGHT_CLASS_TINY
	force = 1
	throwforce = 1
	amount_per_transfer_from_this = 5
	custom_materials = list(/datum/material/iron=100)
	possible_transfer_amounts = list(1, 5)
	volume = 50
	flags_1 = CONDUCT_1
	spillable = TRUE
	resistance_flags = FIRE_PROOF
	isGlass = FALSE
	reagent_flags = OPENCONTAINER
	var/list/blood_donors = list() // Store all who poured blood in the cup

/obj/item/reagent_containers/food/drinks/silver_goblet/is_drainable()
	return TRUE

/obj/item/reagent_containers/food/drinks/silver_goblet/New()
	..()
	reagents = new /datum/reagents(src.volume)
	blood_donors = list() // Initialize the list

/obj/item/reagent_containers/food/drinks/silver_goblet/update_icon_state()
	. = ..()
	if(reagents && reagents.has_reagent(/datum/reagent/blood))
		icon_state = "pewter_cup_filled_blood"
	else
		icon_state = "pewter_cup"
	return TRUE

/obj/item/reagent_containers/food/drinks/silver_goblet/attack_self(mob/living/carbon/human/user)
	if(!istype(user))
		return ..()

	var/is_vampire_species = FALSE
	if(istype(user, /mob/living/carbon/human))
		if(iskindred(user))
			is_vampire_species = TRUE

	if(!is_vampire_species)
		to_chat(user, span_warning("You have no urge to spill your blood into this cup."))
		return

	if(reagents.total_volume >= volume)
		to_chat(user, span_warning("The [src] is already full!"))
		return

	if(user.bloodpool < 2)
		to_chat(user, span_warning("You don't have enough blood to spare!"))
		return

	user.visible_message(span_notice("[user] prepares to cut their wrist to add blood to the [src]."), span_notice("You prepare to cut your wrist and add your blood to the [src]."))

	if(!do_after(user, 5 SECONDS, target = src))
		to_chat(user, span_warning("You decide not to add your blood to the [src]."))
		return

	user.visible_message(span_notice("[user] cuts their wrist and lets blood drip into the [src]."), span_notice("You cut your wrist and let your blood flow into the [src]."))

	playsound(user, 'sound/weapons/bladeslice.ogg', 30, TRUE)
	user.adjustBruteLoss(5) // Small damage from cutting wrist

	// Transfer blood to the cup
	reagents.add_reagent(/datum/reagent/blood/vitae, 5)
	user.bloodpool -= 2 // Use bloodpool

	// Add this user to the list of blood donors if not already present
	if(!(user in blood_donors))
		blood_donors += user

	update_icon_state()



/obj/item/reagent_containers/food/drinks/silver_goblet/attack(mob/living/carbon/M, mob/user)
	if(!reagents.has_reagent(/datum/reagent/blood))
		return ..()

	// Check if the drinker is a vampire or kindred
	var/is_vampire_species = FALSE
	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M
		if(iskindred(H))
			is_vampire_species = TRUE

	// Special handling for vampires drinking blood
	if(is_vampire_species)
		// If multiple donors, it's a proper Vaulderie ritual
		if(length(blood_donors) >= 2)
			// Ask confirmation via tgui_alert
			var/choice = tgui_alert(M, "Do you wish to take part in the Vaulderie? This will bind you to the other participants, and remove any previous bonds... (This will cause your character to change sects to the Sabbat!)", "Vaulderie Ritual", list("Yes", "No"), 10 SECONDS)
			if(choice != "Yes")
				to_chat(M, span_cult("You decide not to participate in the Vaulderie."))
				return

			user.visible_message(span_notice("[user] offers the [src] to [M]."), span_notice("You offer the [src] to [M]."))
			to_chat(M, span_notice("You begin to take part in the Vaulderie..."))

			if(!do_after(M, 100, target = src)) // 10 seconds for Vaulderie
				to_chat(M, span_cult("You stop drinking from the [src]."))
				return
		// Regular blood drinking, no vaulderie
		else
			to_chat(M, span_notice("You begin to drink the blood from the cup..."))

			if(!do_after(M, 100, target = src)) // 10 seconds
				to_chat(M, span_warning("You stop drinking from the [src]."))
				return

	if(length(blood_donors) > 0 && reagents.has_reagent(/datum/reagent/blood))
		if(istype(M, /mob/living/carbon/human))
			if(iskindred(M))
				is_vampire_species = TRUE

		if(is_vampire_species)
		// Create blood bonds to all donors except self
			for(var/mob/living/carbon/human/donor in blood_donors)
				if(M != donor) // Don't blood bond to self
					M.apply_status_effect(STATUS_EFFECT_INLOVE, donor)
					to_chat(M, span_warning("You feel a strange connection to <b>[donor]</b> forming as their blood mingles with yours!"))
					to_chat(donor, span_notice("You sense that <b>[M]</b> has consumed your blood and is now bound to you."))
					M.visible_message(span_notice("[M]'s eyes flash briefly as they become bound to [donor]."), span_notice("Your eyes flash as the blood bond forms."))
					playsound(M, 'sound/magic/smoke.ogg', 20, TRUE)

	// Handle vaulderie
	// First check if there are multiple donors for the vaulderie effect
	if(length(blood_donors) > 1)
		// Multiple donors case - Creates sabbat pack if the drinker doesn't already have a sabbat datum
		if(!is_sabbatist(M))
			to_chat(M, span_cult("You feel your previous blood bonds vanishing as you take part in the Vaulderie and join the Sabbat..."))
			M.mind.assigned_role = "Sabbat Pack"
			var/datum/antagonist/temp_antag = new()
			temp_antag.add_antag_hud(ANTAG_HUD_REV, "rev", M)
			qdel(temp_antag)
	else
		// Single donor case - Transfer sabbat status from donor if they have it
		var/antag_transferred = FALSE

		for(var/mob/living/carbon/human/donor in blood_donors)
			// Check if donor has any sabbat datum
			if(donor.mind && is_sabbatist(donor))
				// Only add the antag datum if the drinker doesn't already have any sabbat datum
				if(M.mind && !is_sabbatist(M))
					to_chat(M, span_warning("You feel a strange connection to [donor] as you drink their blood..."))
					M.mind.assigned_role = "Sabbat Pack"
					var/datum/antagonist/temp_antag = new()
					temp_antag.add_antag_hud(ANTAG_HUD_REV, "rev", M)
					qdel(temp_antag)
					antag_transferred = TRUE
					break

				if(antag_transferred)
					to_chat(M, span_cult("Your mind floods with alien thoughts and philosophies. You now serve the Sabbat!"))
					break  // Only need to transfer one antag datum type
	. = ..()

//on_reagant_change so if all blood is emptied from the cup it empties the blood donors list
/obj/item/reagent_containers/food/drinks/silver_goblet/on_reagent_change()
	..()
	if(reagents.total_volume == 0)
		blood_donors.Cut()

/obj/item/reagent_containers/food/drinks/silver_goblet/afterattack(obj/target, mob/user, proximity)
	if(!proximity || !check_allowed_items(target, 1))
		return

	if(target.is_refillable() && !istype(target, /obj/item/reagent_containers/food/drinks/silver_goblet))
		// If emptying into another container, reset the blood donors
		if(reagents.total_volume > 0 && target.reagents.total_volume < target.reagents.maximum_volume)
			blood_donors.Cut()

	return ..()

/obj/item/reagent_containers/food/drinks/silver_goblet/vaulderie_goblet
	name = "Vaulderie Goblet"
	desc = "An obsidian-black goblet used in ancient vampire rites."
	icon_state = "vaulderie_goblet"

/obj/item/reagent_containers/food/drinks/silver_goblet/vaulderie_goblet/update_icon_state()
	. = ..()
	if(reagents && reagents.has_reagent(/datum/reagent/blood))
		icon_state = "vaulderie_goblet_filled"
	else
		icon_state = "vaulderie_goblet"
	return TRUE
