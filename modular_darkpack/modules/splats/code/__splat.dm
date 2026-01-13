/**
 * # Splat
 *
 * A type of supernatural being (like vampires, werewolves, ghouls, etc.) that
 * players can be. Has traits and actions that are inherent to all members
 * of the splat.
 *
 * Also manages the supernatural powers of this splat that the owner has, but
 * it's limited until future reworks improve powers.
 */
/datum/splat
	abstract_type = /datum/splat

	/// Name of the splat
	var/name
	/// Description of what the splat is and what it does
	var/desc
	/// ID for trait sources and whatnot
	var/id

	/// Traits possessed by all members of this splat
	var/list/splat_traits
	/// Actions possessed by all members of this splat
	var/list/splat_actions
	/// Biotypes possessed by all members of this splat
	var/splat_biotypes
	/// Base type of the powers that this splat has
	var/power_type

	/// Splats that someone with this splat cannot gain
	var/list/incompatible_splats

	/// Powers unique to this splat possessed by the owner
	var/list/datum/action/powers
	/// Mob this splat belongs to
	var/mob/living/carbon/human/owner
