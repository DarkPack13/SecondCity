#define SPECIES_BLOODFORM "bloodform"

/datum/species/tzimisce_blood_form
	// Entirely alien beings that seem to be made entirely out of gel. They have three eyes and a skeleton visible within them.
	name = "\improper Bloodform"
	plural_form = "Bloodforms"
	id = SPECIES_BLOODFORM
	examine_limb_id = SPECIES_BLOODFORM
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_SLIME
	inherent_traits = list(
		TRAIT_MUTE,
		TRAIT_NO_EYE_CONTACT,
		TRAIT_MUTANT_COLORS,
	)
	exotic_bloodtype = BLOOD_TYPE_KINDRED
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | RACE_SWAP | ERT_SPAWN | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/blood_form,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/blood_form,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/blood_form,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/blood_form,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/blood_form,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/blood_form,
	)
	mutanteyes = /obj/item/organ/eyes/bloodform
	mutantbrain = /obj/item/organ/brain/bloodform
	mutantears = /obj/item/organ/ears/bloodform
	fixed_mut_color = "#990000a9"
	hair_color_mode = USE_FIXED_MUTANT_COLOR
	hair_alpha = 70
	facial_hair_alpha = 70
	var/datum/action/innate/regenerate_blood_limbs/regenerate_limbs

/datum/species/tzimisce_blood_form/on_species_gain(mob/living/carbon/new_jellyperson, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	if(ishuman(new_jellyperson))
		regenerate_limbs = new
		regenerate_limbs.Grant(new_jellyperson)
	new_jellyperson.AddElement(/datum/element/soft_landing)

/datum/species/tzimisce_blood_form/on_species_loss(mob/living/carbon/former_jellyperson, datum/species/new_species, pref_load)
	if(regenerate_limbs)
		regenerate_limbs.Remove(former_jellyperson)
	former_jellyperson.RemoveElement(/datum/element/soft_landing)
	return ..()

/datum/action/innate/regenerate_blood_limbs
	name = "Regenerate Limbs"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "slimeheal"
	button_icon = 'icons/mob/actions/actions_slime.dmi'
	background_icon_state = "bg_alien"
	overlay_icon_state = "bg_alien_border"
	var/blood_per_limb = 1

/datum/action/innate/regenerate_blood_limbs/IsAvailable(feedback = FALSE)
	. = ..()
	if(!.)
		return
	var/mob/living/carbon/human/H = owner
	var/list/limbs_to_heal = H.get_missing_limbs()
	if(!length(limbs_to_heal))
		return FALSE
	if(H.bloodpool >= blood_per_limb)
		return TRUE

/datum/action/innate/regenerate_blood_limbs/Activate()
	var/mob/living/carbon/human/H = owner
	var/list/limbs_to_heal = H.get_missing_limbs()
	if(!length(limbs_to_heal))
		to_chat(H, span_notice("You feel intact enough as it is."))
		return
	to_chat(H, span_notice("You focus intently on your missing [length(limbs_to_heal) >= 2 ? "limbs" : "limb"]..."))
	if(H.bloodpool >= blood_per_limb * length(limbs_to_heal))
		H.regenerate_limbs()
		H.adjust_blood_pool(-blood_per_limb * length(limbs_to_heal))
		to_chat(H, span_notice("...and after a moment you finish reforming!"))
		return
	else if(H.bloodpool >= blood_per_limb) //We can partially heal some limbs
		while(H.bloodpool >= blood_per_limb)
			var/healed_limb = pick(limbs_to_heal)
			H.regenerate_limb(healed_limb)
			limbs_to_heal -= healed_limb
			H.adjust_blood_pool(-blood_per_limb)
		to_chat(H, span_warning("...but there is not enough of you to fix everything! You must attain more vitae to heal completely!"))
		return
	to_chat(H, span_warning("...but there is not enough of you to go around! You must attain more vitae to heal!"))

/// Bodyparts
/obj/item/bodypart/head/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	teeth_count = 0
	head_flags = HEAD_EYECOLOR | HEAD_EYESPRITES | HEAD_HAIR | HEAD_FACIAL_HAIR
	butcher_replacement = null
	is_dimorphic = FALSE

/obj/item/bodypart/chest/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = TRUE

/obj/item/bodypart/chest/blood_form/get_butt_sprite()
	return icon('icons/mob/butts.dmi', BUTT_SPRITE_SLIME)

/obj/item/bodypart/arm/left/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = FALSE

/obj/item/bodypart/arm/right/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = FALSE

/obj/item/bodypart/leg/left/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = FALSE

/obj/item/bodypart/leg/right/blood_form
	biological_state = (BIO_INORGANIC)
	limb_id = SPECIES_SLIMEPERSON
	dmg_overlay_type = null
	butcher_replacement = null
	is_dimorphic = FALSE

/// Organs
/obj/item/organ/eyes/bloodform
	name = "bloody eyes"
	desc = "Development bug! Report this to github if you see this!"
	zone = BODY_ZONE_CHEST
	iris_overlay = null
	eye_color_left = "#990000a9"
	eye_color_right = "#990000a9"

/obj/item/organ/ears/bloodform
	name = "bloody ears"
	desc = "Development bug! Report this to github if you see this!"
	zone = BODY_ZONE_CHEST

/obj/item/organ/brain/bloodform
	name = "bloody... brain?"
	desc = "Development bug! Report this to github if you see this!"
	zone = BODY_ZONE_CHEST

#undef SPECIES_BLOODFORM
