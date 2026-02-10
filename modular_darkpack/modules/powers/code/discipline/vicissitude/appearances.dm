/*
 * Create a new changeling profile datum based off of [target].
 *
 * target - the human we're basing the new profile off of.
 * protect - if TRUE, set the new profile to protected, preventing it from being removed (without force).
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/create_profile(mob/living/carbon/human/target, protect = 0)
	var/datum/changeling_profile/new_profile = new()

	target.dna.real_name = target.real_name //Set this again, just to be sure that it's properly set.

	// Set up a copy of their DNA in our profile.
	var/datum/dna/new_dna = new target.dna.type()
	target.dna.copy_dna(new_dna)
	new_profile.dna = new_dna
	new_profile.name = target.name
	new_profile.protected = protect

	new_profile.age = target.age
	new_profile.physique = target.physique
	new_profile.athletics_level = target.mind?.get_skill_level(/datum/skill/athletics) || SKILL_LEVEL_NONE

	// Grab the target's quirks.
	for(var/datum/quirk/target_quirk as anything in target.quirks)
		LAZYADD(new_profile.quirks, new target_quirk.type)

	// Clothes, of course
	new_profile.underwear = target.underwear
	new_profile.underwear_color = target.underwear_color
	new_profile.undershirt = target.undershirt
	new_profile.socks = target.socks

	// Grab skillchips they have
	new_profile.skillchips = target.clone_skillchip_list(TRUE)

	// Get any scars they may have
	for(var/datum/scar/target_scar as anything in target.all_scars)
		LAZYADD(new_profile.stored_scars, target_scar.format())

	// Make an icon snapshot of what they currently look like
	var/datum/icon_snapshot/entry = new()
	entry.name = target.name
	entry.icon = target.icon
	entry.icon_state = target.icon_state
	entry.overlays = target.get_overlays_copy(list(HANDS_LAYER, HANDCUFF_LAYER, LEGCUFF_LAYER))
	new_profile.profile_snapshot = entry

	// Grab the target's sechut icon.
	new_profile.id_icon = target.wear_id?.get_sechud_job_icon_state()

	var/list/slots = list("head", "wear_mask", "wear_neck", "back", "wear_suit", "w_uniform", "shoes", "belt", "gloves", "glasses", "ears", "wear_id", "s_store")
	for(var/slot in slots)
		if(!(slot in target.vars))
			continue
		var/obj/item/clothing/clothing_item = target.vars[slot]
		if(!clothing_item)
			continue
		new_profile.name_list[slot] = clothing_item.name
		new_profile.appearance_list[slot] = clothing_item.appearance
		new_profile.flags_cover_list[slot] = clothing_item.flags_cover
		new_profile.lefthand_file_list[slot] = clothing_item.lefthand_file
		new_profile.righthand_file_list[slot] = clothing_item.righthand_file
		new_profile.inhand_icon_state_list[slot] = clothing_item.inhand_icon_state
		new_profile.worn_icon_list[slot] = clothing_item.worn_icon
		new_profile.worn_icon_state_list[slot] = clothing_item.worn_icon_state
		new_profile.exists_list[slot] = 1

	new_profile.voice = target.voice
	new_profile.voice_filter = target.voice_filter

	return new_profile

/*
 * Add a new profile to our changeling's profile list.
 * Pops the first profile in the list if we're above our limit of profiles.
 *
 * new_profile - the profile being added.
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/add_profile(datum/changeling_profile/new_profile)
	if(stored_profiles.len > max_appearances)
		if(!push_out_profile())
			return

	if(!first_profile)
		first_profile = new_profile
		current_profile = first_profile

	stored_profiles += new_profile

/*
 * Create a new profile from the given [profile_target]
 * and add it to our profile list via add_profile.
 *
 * profile_target - the human we're making a profile based off of
 * protect - if TRUE, mark the new profile as protected. If protected, it cannot be removed / popped from the profile list (without force).
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/add_new_profile(mob/living/carbon/human/profile_target, protect = FALSE)
	var/datum/changeling_profile/new_profile = create_profile(profile_target, protect)
	add_profile(new_profile)
	return new_profile

/*
 * Remove a given profile from the profile list.
 *  *
 * profile_target - the human we want to remove from our profile list (looks for a profile with a matching name)
 * force - if TRUE, removes the profile even if it's protected.
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/remove_profile(mob/living/carbon/human/profile_target, force = FALSE)
	for(var/datum/changeling_profile/found_profile as anything in stored_profiles)
		if(profile_target.real_name == found_profile.name)
			if(found_profile.protected && !force)
				continue
			stored_profiles -= found_profile
			qdel(found_profile)

/*
 * Removes the highest changeling profile from the list
 * that isn't protected and returns TRUE if successful.
 *
 * Returns TRUE if a profile was removed, FALSE otherwise.
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/push_out_profile()
	var/datum/changeling_profile/profle_to_remove
	for(var/datum/changeling_profile/found_profile as anything in stored_profiles)
		if(!found_profile.protected)
			profle_to_remove = found_profile
			break

	if(profle_to_remove)
		stored_profiles -= profle_to_remove
		return TRUE
	return FALSE

/*
 * Create a profile based on the changeling's initial appearance.
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/create_initial_profile()
	if(!ishuman(owner))
		return

	add_new_profile(owner, TRUE)

/*
 * Restores the appearance of the changeling to the original DNA.
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/admin_restore_appearance(mob/admin)
	if(!stored_profiles.len || !iscarbon(owner))
		to_chat(admin, span_danger("Resetting DNA failed!"))
		return

	var/mob/living/carbon/carbon_owner = owner
	first_profile.dna.copy_dna(carbon_owner.dna, COPY_DNA_SE|COPY_DNA_SPECIES)
	carbon_owner.real_name = first_profile.name
	carbon_owner.updateappearance(mutcolor_update = TRUE)
	carbon_owner.domutcheck()

/*
 * Transform the currentc hangeing [user] into the [chosen_profile].
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/transform(mob/living/carbon/human/user, datum/changeling_profile/chosen_profile)
	var/static/list/slot2slot = list(
		"head" = ITEM_SLOT_HEAD,
		"wear_mask" = ITEM_SLOT_MASK,
		"wear_neck" = ITEM_SLOT_NECK,
		"back" = ITEM_SLOT_BACK,
		"wear_suit" = ITEM_SLOT_OCLOTHING,
		"w_uniform" = ITEM_SLOT_ICLOTHING,
		"shoes" = ITEM_SLOT_FEET,
		"belt" = ITEM_SLOT_BELT,
		"gloves" = ITEM_SLOT_GLOVES,
		"glasses" = ITEM_SLOT_EYES,
		"ears" = ITEM_SLOT_EARS,
		"wear_id" = ITEM_SLOT_ID,
		"s_store" = ITEM_SLOT_SUITSTORE,
	)

	var/datum/dna/chosen_dna = chosen_profile.dna
	user.real_name = chosen_profile.name
	user.underwear = chosen_profile.underwear
	user.underwear_color = chosen_profile.underwear_color
	user.undershirt = chosen_profile.undershirt
	user.socks = chosen_profile.socks
	user.age = chosen_profile.age
	user.physique = chosen_profile.physique
	user.mind?.set_level(/datum/skill/athletics, chosen_profile.athletics_level, silent = TRUE)
	user.voice = chosen_profile.voice
	user.voice_filter = chosen_profile.voice_filter

	chosen_dna.copy_dna(user.dna, COPY_DNA_SE)

	for(var/obj/item/bodypart/limb as anything in user.bodyparts)
		limb.update_limb(is_creating = TRUE)

	user.updateappearance(mutcolor_update = TRUE)
	user.domutcheck()

	// Get rid of any scars from previous Changeling-ing
	for(var/datum/scar/old_scar as anything in user.all_scars)
		if(old_scar.fake)
			user.all_scars -= old_scar
			qdel(old_scar)

	// Now, we do skillchip stuff, AFTER DNA code.
	// (There's a mutation that increases max chip complexity available, even though we force-implant skillchips.)

	// Remove existing skillchips.
	user.destroy_all_skillchips(silent = FALSE)

	// Add new set of skillchips.
	for(var/chip in chosen_profile.skillchips)
		var/chip_type = chip["type"]
		var/obj/item/skillchip/skillchip = new chip_type(user)

		if(!istype(skillchip))
			stack_trace("Failure to implant changeling from [chosen_profile] with skillchip [skillchip]. Tried to implant with non-skillchip type [chip_type]")
			qdel(skillchip)
			continue

		// Try force-implanting and activating. If it doesn't work, there's nothing much we can do. There may be some
		// incompatibility out of our hands
		var/implant_msg = user.implant_skillchip(skillchip, TRUE)
		if(implant_msg)
			// Hopefully recording the error message will help debug it.
			stack_trace("Failure to implant changeling from [chosen_profile] with skillchip [skillchip]. Error msg: [implant_msg]")
			qdel(skillchip)
			continue

		// Time to set the metadata. This includes trying to activate the chip.
		var/set_meta_msg = skillchip.set_metadata(chip)

		if(set_meta_msg)
			// Hopefully recording the error message will help debug it.
			stack_trace("Failure to activate changeling skillchip from [chosen_profile] with skillchip [skillchip] using [chip] metadata. Error msg: [set_meta_msg]")
			continue

	//vars hackery. not pretty, but better than the alternative.
	for(var/slot in slot2type)
		if(istype(user.vars[slot], slot2type[slot]) && !(chosen_profile.exists_list[slot])) // Remove unnecessary flesh items
			qdel(user.vars[slot])
			continue

		if((user.vars[slot] && !istype(user.vars[slot], slot2type[slot])) || !(chosen_profile.exists_list[slot]))
			continue

		if(istype(user.vars[slot], slot2type[slot]) && slot == "wear_id") // Always remove old flesh IDs - so they get properly updated.
			qdel(user.vars[slot])

		var/obj/item/new_flesh_item
		var/equip = FALSE
		if(!user.vars[slot])
			var/slot_type = slot2type[slot]
			equip = TRUE
			new_flesh_item = new slot_type(user)

		else if(istype(user.vars[slot], slot2type[slot]))
			new_flesh_item = user.vars[slot]

		new_flesh_item.appearance = chosen_profile.appearance_list[slot]
		new_flesh_item.name = chosen_profile.name_list[slot]
		new_flesh_item.flags_cover = chosen_profile.flags_cover_list[slot]
		new_flesh_item.lefthand_file = chosen_profile.lefthand_file_list[slot]
		new_flesh_item.righthand_file = chosen_profile.righthand_file_list[slot]
		new_flesh_item.inhand_icon_state = chosen_profile.inhand_icon_state_list[slot]
		new_flesh_item.worn_icon = chosen_profile.worn_icon_list[slot]
		new_flesh_item.worn_icon_state = chosen_profile.worn_icon_state_list[slot]

		if(istype(new_flesh_item, /obj/item/changeling/id) && chosen_profile.id_icon)
			var/obj/item/changeling/id/flesh_id = new_flesh_item
			flesh_id.hud_icon = chosen_profile.id_icon

		if(equip)
			user.equip_to_slot_or_del(new_flesh_item, slot2slot[slot], indirect_action = TRUE)
			if(!QDELETED(new_flesh_item))
				ADD_TRAIT(new_flesh_item, TRAIT_NODROP, CHANGELING_TRAIT)

	for(var/stored_scar_line in chosen_profile.stored_scars)
		var/datum/scar/attempted_fake_scar = user.load_scar(stored_scar_line)
		if(attempted_fake_scar)
			attempted_fake_scar.fake = TRUE

	user.regenerate_icons()
	user.name = user.get_visible_name()
	current_profile = chosen_profile

/*
 * Get the corresponding changeling profile for the passed name.
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/get_dna(searched_dna_name)
	for(var/datum/changeling_profile/found_profile as anything in stored_profiles)
		if(searched_dna_name == found_profile.name)
			return found_profile

/*
 * Checks if we have a changeling profile with the passed DNA.
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/has_profile_with_dna(datum/dna/searched_dna)
	for(var/datum/changeling_profile/found_profile as anything in stored_profiles)
		if(searched_dna.is_same_as(found_profile.dna))
			return TRUE
	return FALSE


//Change our DNA to that of somebody we've absorbed.
/datum/action/cooldown/mob_cooldown/shapeshift/proc/transform_mob(mob/living/carbon/human/user)
	var/datum/changeling_profile/chosen_prof = select_dna()
	if(!chosen_prof)
		return FALSE
	if(!IN_GIVEN_RANGE(owner, target, range))
		return FALSE
	transform(user, chosen_prof)
	SEND_SIGNAL(user, COMSIG_CHANGELING_TRANSFORM)
	return TRUE

/**
 * Gives a changeling a list of all possible dnas in their profiles to choose from and returns profile containing their chosen dna
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/select_dna()
	var/mob/living/carbon/user = owner
	if(!istype(user))
		return FALSE

	var/list/disguises = list()
	for(var/datum/changeling_profile/current_profile as anything in stored_profiles)
		var/datum/icon_snapshot/snap = current_profile.profile_snapshot
		var/image/disguise_image = image(icon = snap.icon, icon_state = snap.icon_state)
		disguise_image.overlays = snap.overlays
		disguises[current_profile.name] = disguise_image

	var/chosen_name = show_radial_menu(user, user, disguises, custom_check = CALLBACK(src, PROC_REF(check_menu), user), radius = 40, require_near = TRUE, tooltips = TRUE)
	if(!chosen_name)
		return FALSE

	var/datum/changeling_profile/prof = get_dna(chosen_name)
	return prof

/**
 * Checks if we are allowed to interact with a radial menu
 *
 * Arguments:
 * * user The carbon mob interacting with the menu
 */
/datum/action/cooldown/mob_cooldown/shapeshift/proc/check_menu(mob/living/carbon/user)
	if(!istype(user))
		return FALSE
	return TRUE
