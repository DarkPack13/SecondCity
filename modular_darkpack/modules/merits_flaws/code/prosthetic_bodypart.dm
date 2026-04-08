/datum/quirk/darkpack/prosthetic_limb
	name = "Prosthetic Limb"
	desc = "An accident caused you to lose one of your limbs. Because of this, you now have a prosthetic replacement!"
	icon = "tg-prosthetic-leg"
	value = -2
	hardcore_value = 2
	quirk_flags = QUIRK_HUMAN_ONLY | QUIRK_CHANGES_APPEARANCE
	darkpack_allowed = TRUE
	medical_record_text = "Patient underwent amputation of a limb, sporting a prosthetic replacement."
	failure_message = "Your limb.. regrew?"
	/// The slot to replace, in string form
	var/slot_string = "limb"
	/// The slot to replace, in GLOB.limb_zones (both arms and both legs)
	var/limb_zone


/datum/quirk_constant_data/darkpack_prosthetic_limb
	associated_typepath = /datum/quirk/darkpack/prosthetic_limb
	customization_options = list(/datum/preference/choiced/prosthetic)

/datum/quirk/darkpack/prosthetic_limb/add_unique(client/client_source)
	var/obj/item/bodypart/limb_type = GLOB.prosthetic_limb_choice[client_source?.prefs?.read_preference(/datum/preference/choiced/prosthetic)]
	if(isnull(limb_type))  //Client gone or they chose a random prosthetic
		limb_type = GLOB.prosthetic_limb_choice[pick(GLOB.darkpack_prosthetic_limb_choice)]
	limb_zone = limb_type.body_zone

	var/mob/living/carbon/human/human_holder = quirk_holder
	var/obj/item/bodypart/prosthetic = new limb_type()
	slot_string = "[prosthetic.plaintext_zone]"
	human_holder.del_and_replace_bodypart(prosthetic, special = TRUE)

/datum/quirk/darkpack/prosthetic_limb/post_add()
	to_chat(quirk_holder, span_bolddanger("Your [slot_string] has been replaced with a prosthetic. It has limited mobility, not allowing you to really defend yourself with it. Additionally, \
	you need to use a welding tool and cables to repair it, instead of sutures and regenerative meshes."))

/datum/quirk/darkpack/prosthetic_limb/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.reset_to_original_bodypart(limb_zone)
