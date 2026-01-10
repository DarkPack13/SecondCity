/obj/item/card/drivers_license
	name = "driver's license"
	desc = "An identification card allowing its holder to own and operate motor vehicles. Doubles as a valid form of identification."
	icon = 'modular_darkpack/modules/government/icons/docs.dmi'
	icon_state = "drivers"
	worn_icon_state = ""
	slot_flags = NONE
	ONFLOOR_ICON_HELPER('modular_darkpack/modules/government/icons/docsonfloor.dmi')
	/// Issuing state
	var/issuing_state = "California"
	/// Owner
	var/owner = ""
	/// If the ID is a counterfit.
	var/fake = FALSE
	/// If the NAME does not belong to the person.
	var/fake_identity = FALSE

/obj/item/card/drivers_license/Initialize(mapload)
	. = ..()
	var/mob/living/carbon/human/user = null
	if(ishuman(loc)) // In pockets
		user = loc
	else if(ishuman(loc?.loc)) // In backpack
		user = loc.loc
	if(user)
		link_human(user)

/obj/item/card/drivers_license/proc/link_human(mob/living/carbon/human/user)
	if(HAS_TRAIT(user, TRAIT_ILLEGAL_IDENTITY))
		fake = TRUE
		fake_identity = TRUE

	if(fake_identity)
		owner = user.generate_random_mob_name(TRUE)
	else
		owner = user.real_name
	if(user.client?.prefs)
		var/pref_country = user.client.prefs.read_preference(/datum/preference/choiced/country_of_origin)
		if(pref_country == "United States")
			var/pref_state = user.client.prefs.read_preference(/datum/preference/choiced/state_of_origin)
			if(pref_state)
				issuing_state = pref_state

/obj/item/card/drivers_license/examine(mob/user)
	. = ..()
	//DARKPACK TODO - STATS - refer to passport.dm, this should be a statcheck to see if its an illegal ID/counterfeit
	if(owner)
		. += span_notice("It reads as belonging to [owner], issued by the state of [issuing_state].")
		if(fake)
			. += span_notice("It looks like a crude counterfeit.")
