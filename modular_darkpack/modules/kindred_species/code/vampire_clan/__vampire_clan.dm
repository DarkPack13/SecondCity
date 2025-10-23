/datum/vampire_clan
	/// Name of the Clan
	var/name
	/// Identifier in sprites for the Clan
	var/id
	/// Description of the Clan
	var/desc
	/// Description of the Clan's supernatural curse
	var/curse

	/// List of Disciplines that are innate to this Clan
	var/list/clan_disciplines
	/// List of Disciplines that are rejected by this Clan
	var/list/restricted_disciplines
	/// List of traits that are applied to members of this Clan
	var/list/clan_traits

	/// The Clan's unique body sprite
	var/alt_sprite
	/// If the Clan's unique body sprites need to account for skintone
	var/alt_sprite_greyscale
	/// If members of this Clan can't have hair
	var/no_hair
	/// If members of this Clan can't have facial hair
	var/no_facial

	/// Default clothing for male members of this Clan
	var/male_clothes
	/// Default clothing for female members of this Clan
	var/female_clothes
	/// Keys for this Clan's exclusive hideout
	var/clan_keys

	/// List of unnatural features that members of this Clan can choose
	var/list/accessories
	/// Associative list of layers for unnatural features that members of this Clan can choose
	var/list/accessories_layers
	/// Clan accessory that's selected by default
	var/default_accessory

	/// Morality level that characters of this Clan start with
	var/start_humanity = 7
	/// If members of this Clan are on a Path of Enlightenment by default
	var/enlightenment

	/// If this Clan needs a whitelist to select and play
	var/whitelisted

/**
 * Applies Clan-specific effects to the mob
 * gaining this Clan. Will alter the mob's
 * sprite according to the alternate sprite
 * and appearance variables, and apply the
 * Clan's traits to the mob. If the Clan is
 * being given as the mob joins the round,
 * it'll cause on_join_round to trigger when the
 * client logs into the mob.
 *
 * Arguments:
 * * vampire - Human being given the Clan
 * * joining_round - If this Clan is being applied as the mob joins the round
 */
/datum/vampire_clan/proc/on_gain(mob/living/carbon/human/vampire, joining_round)
	SHOULD_CALL_PARENT(TRUE)

	// Apply alternative sprites
	if (alt_sprite)
		vampire.set_body_sprite(alt_sprite, alt_sprite_greyscale)

	// Remove hair if the Clan demands it
	if (no_hair)
		vampire.set_hairstyle("Bald", update = FALSE)

	// Remove facial hair if the Clan demands it
	if (no_facial)
		vampire.set_facial_hairstyle("Shaved", update = FALSE)

	// Add unique Clan features as traits
	for (var/trait in clan_traits)
		ADD_TRAIT(vampire, trait, CLAN_TRAIT)

	// Applies on_join_round effects when a client logs into this mob
	if (joining_round)
		RegisterSignal(vampire, COMSIG_MOB_LOGIN, PROC_REF(on_join_round), override = TRUE)

/**
 * Undoes the effects of on_gain to more or less
 * remove the effects of gaining the Clan. By default,
 * this proc only removes unique traits and resets
 * the mob's alternative sprite.
 *
 * Arguments:
 * * vampire - Human losing the Clan.
 */
/datum/vampire_clan/proc/on_lose(mob/living/carbon/human/vampire)
	SHOULD_CALL_PARENT(TRUE)

	// Remove unique Clan feature traits
	for (var/trait in clan_traits)
		REMOVE_TRAIT(vampire, trait, CLAN_TRAIT)

	// Sets the vampire back to their default body sprite
	if (alt_sprite)
		vampire.set_body_sprite(ignore_clan = TRUE)

	// TODO: [Rebase] reimplement clan accessories
	/*
	// Remove Clan accessories
	if (vampire.client?.prefs?.clan_accessory)
		var/equipped_accessory = accessories_layers[vampire.client.prefs.clan_accessory]
		vampire.remove_overlay(equipped_accessory)
	*/

/**
 * Applies Clan-specific effects when the
 * mob that has the Clan logs into their mob
 * at roundstart. Anything that's not innate
 * to the Clan and more part of its social
 * structure or whatnot should go in here.
 * Will teleport Masquerade-breaching Clans to
 * safe areas and give them their Clan keys by
 * default.
 *
 * Arguments:
 * * vampire - Human with this Clan joining the round.
 */
/datum/vampire_clan/proc/on_join_round(mob/living/carbon/human/vampire)
	SIGNAL_HANDLER

	SHOULD_CALL_PARENT(TRUE)

	if (HAS_TRAIT(vampire, TRAIT_MASQUERADE_VIOLATING_FACE))
		if (length(GLOB.masquerade_latejoin))
			var/obj/effect/landmark/latejoin_masquerade/LM = pick(GLOB.masquerade_latejoin)
			if (LM)
				vampire.forceMove(get_turf(LM))

	if (clan_keys)
		vampire.put_in_r_hand(new clan_keys(vampire))

	UnregisterSignal(vampire, COMSIG_MOB_LOGIN)

/**
 * Gives the human a vampiric Clan, applying
 * on_gain effects and post_gain effects if the
 * parameter is true. Can also remove Clans
 * with or without a replacement, and apply
 * on_lose effects. Will have no effect the human
 * is being given the Clan it already has.
 *
 * Arguments:
 * * setting_clan - Typepath or Clan singleton to give to the human
 * * joining_round - If this Clan is being given at roundstart and should call on_join_round
 */
/mob/living/carbon/human/proc/set_clan(setting_clan, joining_round)
	var/datum/vampire_clan/previous_clan = clan

	// Convert IDs and typepaths to singletons, or just directly assign if already singleton
	var/datum/vampire_clan/new_clan = get_vampire_clan(setting_clan)

	// Handle losing Clan
	previous_clan?.on_lose(src)

	clan = new_clan

	// Clan's been cleared, don't apply effects
	if (!new_clan)
		return

	// Gaining Clan effects
	clan.on_gain(src, joining_round)
