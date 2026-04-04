/datum/quirk/darkpack/forked_tongue
	name = "Forked Tongue"
	desc = "Your tongue is forked, flickering, and inhumanly reptilian. To not cover your mouth is a breach of the masquerade as your tongue flickers about."
	value = -2
	mob_trait = TRAIT_FORKED_TONGUE
	gain_text = span_notice("Your tongue forks and flickers in a way no human's does.")
	lose_text = span_notice("Your tongue feels normal in your mouth once more.")
	allowed_splats = list(SPLAT_KINDRED)
	included_clans = list(VAMPIRE_CLAN_SETITE)
	icon = FA_ICON_FACE_GRIN_TONGUE_WINK
	failure_message = "Your tongue feels normal in your mouth once more."

/datum/quirk/item_quirk/forked_tongue/add_unique(client/client_source)
	give_item_to_holder(
		/obj/item/clothing/mask/vampire,
		list(
			LOCATION_MASK,
			LOCATION_BACKPACK,
			LOCATION_HANDS,
		)
	)
