/datum/quirk/darkpack/recognize_werewolves
	name = "Recognize Werewolves"
	desc = {"Over the years, you've become adept at picking out the Changers of your
			race in a crowd. Rather than having any kind of mystical awareness, you've
			simply learned what physical and personality traits tend to mark Gaia's children.
			They just stand out to you, once they're undergone the Change. This merit doesn't
			allow you to find cubs on the verge of Firsting (or what have you), but you may
			notice their propensity for violence. All Perception attempts to notice which people
			in the room seem to have that special touch of Rage or wildness that could indicate
			they're of your Changing Breed are at -2 difficulty."}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 53)
	value = 2
	mob_trait = TRAIT_RECOGNIZE_WEREWOLVES
	gain_text = span_notice("You percieve intricacies about your kin not many would notice.")
	lose_text = span_notice("Your perception dulls, the intuition guiding is no more.")
	icon = FA_ICON_USER_SHIELD
	failure_message = "Your perception dulls, the intuition guiding is no more."
	allowed_splats = list(SPLAT_KINFOLK)

// DARKPACK TODO - Lock to kin type when more than Garou exist.

/datum/quirk/darkpack/recognize_werewolves/add(client/client_source)
	var/datum/action/gargoyle_statue_form/statue_action = new()
	statue_action.Grant(quirk_holder)

/datum/action/recognize_werewolves
	name = "Recognize Werewolves"
	desc = "Attempt to discern if someone is a Changer of your race."
	button_icon = 'modular_darkpack/master_files/icons/hud/actions.dmi'
	button_icon_state = "gargoyle"
