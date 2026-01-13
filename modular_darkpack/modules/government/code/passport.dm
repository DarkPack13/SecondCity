// DARKPACK TODO - We should support selecting something other then a passport, e.g: driver licenses

/datum/quirk/illegal_identity
	name = "Illegal Identity"
	desc = "Illegal immigrant? Died legally? Born a wolf? The cops aren't happy."
	value = 0
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	icon = FA_ICON_PERSON_CIRCLE_QUESTION
	mob_trait = TRAIT_ILLEGAL_IDENTITY
	gain_text = span_warning("You feel legally unprepared.")
	lose_text = span_notice("You feel bureaucratically legitimate.")
	medical_record_text = "Patient is not checked in with valid identification."
	// excluded_clans = list(CLAN_RAVNOS) // DARKPACK TODO - RAVNOS - (They are forced to take this)

/datum/quirk/illegal_identity/add()
	. = ..()
	if(!ishuman(quirk_holder))
		return
	var/mob/living/carbon/human/criminal = quirk_holder
	var/obj/item/passport/passport = locate() in criminal // In pockets
	if(!passport && criminal.back)
		passport = locate() in criminal.back // In backpack
	if(passport && passport.owner == criminal.real_name)
		passport.link_human(criminal)

/datum/loadout_item/pocket_items/passport
	name = "Passport"
	item_path = /obj/item/passport

/obj/item/passport
	name = "passport"
	desc = "A book with someone's license, photo, and identifying information. Don't lose it!"
	icon = 'modular_darkpack/modules/deprecated/icons/items.dmi'
	worn_icon = 'modular_darkpack/modules/clothes/icons/worn.dmi'
	icon_state = "passport1"
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_ID
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/deprecated/icons/onfloor.dmi')

	var/closed = TRUE
	/// String of who the owner of the passport.
	var/owner = ""

	/// If the ID is a counterfit.
	var/fake = FALSE
	/// If the NAME does not belong to the person.
	var/fake_itentity = FALSE

/obj/item/passport/Initialize(mapload)
	. = ..()
	var/mob/living/carbon/human/user = null
	if(ishuman(loc)) // In pockets
		user = loc
	else if(ishuman(loc?.loc)) // In backpack
		user = loc
	if(user)
		// Init and equiping via loadout are both too soon to be able to catch the illegal identity quirk
		link_human(user)

/obj/item/passport/proc/link_human(mob/living/carbon/human/user)
	if(HAS_TRAIT(user, TRAIT_ILLEGAL_IDENTITY))
		fake = TRUE
		fake_itentity = TRUE

	if(fake_itentity)
		owner = user.generate_random_mob_name(TRUE)
	else
		owner = user.real_name

/obj/item/passport/examine(mob/user)
	. = ..()
	// DARKPACK TODO - STATS - (Make this a perception+investigation roll when we have retrying check standeridization)
	if(!closed && owner)
		. += span_notice("It reads as belonging to [owner].")
		if(fake)
			. += span_notice("It looks like a crude counterfeit.")

/obj/item/passport/attack_self(mob/user)
	. = ..()
	if(closed)
		closed = FALSE
		icon_state = "passport0"
		to_chat(user, span_notice("You open [src]."))
	else
		closed = TRUE
		icon_state = "passport1"
		to_chat(user, span_notice("You close [src]."))
