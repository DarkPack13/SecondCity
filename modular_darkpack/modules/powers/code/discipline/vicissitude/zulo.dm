////////////////////
// Sabby:
// Zulo Form refactored in Jul-2026 from Basicmob into a carbon species for better functionality.
// Fera_species.dm code was used as a base template, whilst also taking cues from Blood Form and other vicissitude code.
////////////////////

////////////////////
// If you'd like to create and add new Zulo form sprites in the future, follow this process:
// 1. Below assumes you followed the instructions on line 41 of zulo_organs.dm;
// 2. Update the zulo_forms GLOBAL_LIST below:
// 3. Create a name for your list item, such as "Beast" and = to the exact same sprite name you used in zulo_organs.dm and the .dmi you updated.
// 4. Update the second GLOBAL_LIST below:
// 5. Use the exact name you added to the first list and = to /datum/species/tzimisce_zulo_form/[use the same name here but lowercase]
// 6. Scroll do the bottom of this code and create the new /datum/ there, make sure to use the correct format above.
// 7. If your sprite is 32x32, then add the sprite_size_transform = 1.50. If it is 64x64, do not add.
// 8. Copy the bodypart overrides list from the datums above for ease of use.
// 9. Update each of the objs to BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/zulo/[name of the obj you created in zulo_organs.dm],
// 10. Save and test.
////////////////////

// Sabby: This list holds icon for the character screen form selection UI
GLOBAL_LIST_INIT(zulo_forms, list(
	"Beast" = "weretzi",
	"Brust" = "4armstzi",
	"Noble" = "nobletzi",
))

// Sabby: This list is used to point the above selection to the right species inheriting datums at bottom of this code.
GLOBAL_LIST_INIT(zulo_species, list(
	"Noble" = /datum/species/tzimisce_zulo_form/noble,
	"Beast" = /datum/species/tzimisce_zulo_form/beast,
	"Brust" = /datum/species/tzimisce_zulo_form/brust,
))

/datum/species/tzimisce_zulo_form
	abstract_type = /datum/species/tzimisce_zulo_form
	abstract_type = /datum/species/tzimisce_zulo_form
	name = "Zulo"
	plural_form = "Zulo"
	id = SPECIES_ZULO_FORM
	examine_limb_id = SPECIES_ZULO_FORM
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	inherent_traits = list( // Sabby: note, a lot of traits came from my painstakingly looking at trait definitions, tracking them down in the code and checking what they seem to do.
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_TOXIMMUNE,
		TRAIT_NOCRITDAMAGE,
		TRAIT_MASQUERADE_VIOLATING_FACE,
		TRAIT_STRONG_GRABBER, // Sabby: feels appropriate for a large warform to be able to skip passive grab and go into Agg grab.
		TRAIT_GIANT, // Sabby:  functionality at tackle.dm row 380. Makes target harder to tackle. Feels appropriate for large warform.
		TRAIT_PUSHIMMUNE, // Sabby: present in oldcode. According to living_defense.dm, it prevents an agg grab. By name, I thought it would prevents shove. I still believe it makes sense for a war form to not be agg grabbed.
		TRAIT_HARDLY_WOUNDED, // Sabby: present in oldcode. Functionality found in wounds.dm line 61.
		TRAIT_BRAWLING_KNOCKDOWN_BLOCKED, // Sabby: new feature. Found from declarations list and studied from item_attack.dm line 463 and tackle.dm. Basically keeps target from getting knocked down on hand-to-hand.
		TRAIT_NO_STAGGER, // Sabby: new feature. Found from declarations list and studied from staggered.dm. Prevents application of /datum/status_effect/staggered (which is basically a daze sort of effect). Same reasoning as above.
		TRAIT_NO_THROW_HITPUSH, // Sabby: new feature. Found from declarations list and studied from staggered.dm line 1330. Basically: prevents application of hitpush when hit by thrown items. Reasoning: same as above.
		TRAIT_NO_UNDERWEAR,
		TRAIT_NO_BLOOD_OVERLAY,
		TRAIT_TRANSFORM_UPDATES_ICON,
		TRAIT_NO_CUFF, // Sabby: hard to put cuffs on a warform that might even have multiple arms or be a were-beast. Waiting for cuffbreaking code.
		TRAIT_MUTANT_COLORS // Sabby: paired with fixed_mut_color below to give Zulo its own fixed sprite color rather than the character's skin tone
	)
	no_equip_flags = ITEM_SLOT_MASK | ITEM_SLOT_OCLOTHING | ITEM_SLOT_GLOVES | ITEM_SLOT_FEET | ITEM_SLOT_ICLOTHING | ITEM_SLOT_SUITSTORE | ITEM_SLOT_HEAD | ITEM_SLOT_EYES | ITEM_SLOT_EARS
	var/obj/item/zulo_backpack_to_hide
	// Sabby: important to retain at least backpack slot - the Tzimisce soil bag needs to remain on the character.
	exotic_bloodtype = BLOOD_TYPE_KINDRED
	// Sabby: necessary vars for capturing pre-Zulo social stats and size
	var/old_appearance
	var/old_manipulation
	var/old_charisma
	var/old_size
	var/mob_pixel_w = 0
	var/mob_pixel_z = 0
	var/sprite_size_transform = 1 //Sabby: in case any new future sprites are 32x32, not 64x64, overwrite this with 1.50 on the new form's datum.
	// Sabby: Zulo-specific bodyparts are defined in zulo_organs.dm.
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/zulo,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/zulo,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/zulo,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/zulo,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/zulo,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/zulo,
	)
	// Sabby: mut_color to work with TRAIT_MUTANT_COLORS to keep sprite color from being changed by base character skin colors.
	fixed_mut_color = "#e5e0d0"

/datum/species/tzimisce_zulo_form/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load, regenerate_icons)
	. = ..()
	human_who_gained_species.hairstyle = "Bald"
	human_who_gained_species.facial_hairstyle = "Shaved"
	human_who_gained_species.add_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	human_who_gained_species.add_offsets(type, w_add = mob_pixel_w, z_add = mob_pixel_z)
	human_who_gained_species.update_mob_height()
	old_size = human_who_gained_species.current_size
	human_who_gained_species.update_transform(sprite_size_transform)
	old_appearance = human_who_gained_species.st_get_stat(STAT_APPEARANCE)
	old_manipulation = human_who_gained_species.st_get_stat(STAT_MANIPULATION)
	old_charisma = human_who_gained_species.st_get_stat(STAT_CHARISMA)
	// Sabby: +3 stat boots to all physical stats, and socials to 0 as per V20 - pages: 242
	// Sabby: below is the most reliable way I found of doing something I struggled with: set social stats to 0 and restore when out of Zulo.
	if(old_appearance > 0)
		human_who_gained_species.st_add_stat_mod(STAT_APPEARANCE, -old_appearance, type)
	if(old_manipulation > 0)
		human_who_gained_species.st_add_stat_mod(STAT_MANIPULATION, -old_manipulation, type)
	if(old_charisma > 0)
		human_who_gained_species.st_add_stat_mod(STAT_CHARISMA, -old_charisma, type)
	human_who_gained_species.st_add_stat_mod(STAT_STRENGTH, 3, type)
	human_who_gained_species.st_add_stat_mod(STAT_DEXTERITY, 3, type)
	human_who_gained_species.st_add_stat_mod(STAT_STAMINA, 3, type)
	human_who_gained_species.remove_overlay(BODY_ADJ_LAYER)
	zulo_backpack_to_hide = human_who_gained_species.get_item_by_slot(ITEM_SLOT_BACK)
	if(zulo_backpack_to_hide)
		zulo_backpack_to_hide.worn_icon_state = "empty"
		human_who_gained_species.update_worn_back()
	// Sabby: learned from fera code. Needed for revert on death.
	RegisterSignal(human_who_gained_species, COMSIG_LIVING_DEATH, PROC_REF(revert_on_zulo_death))

/datum/species/tzimisce_zulo_form/on_species_loss(mob/living/carbon/human/human, datum/species/new_species, pref_load)
	. = ..()
	// Sabby: below is taken from oldcode to revert the = "bald" on_gain setting from above.
	if(human.client)
		human.hairstyle = human.client.prefs.read_preference(/datum/preference/choiced/hairstyle)
		human.facial_hairstyle = human.client.prefs.read_preference(/datum/preference/choiced/facial_hairstyle)
	human.remove_movespeed_mod_immunities(type, /datum/movespeed_modifier/damage_slowdown)
	human.remove_offsets(type)
	human.update_mob_height() // Sabby: restores character pre-transform height.
	human.update_transform(old_size/human.current_size)
	human.st_remove_stat_mod(STAT_APPEARANCE, type) //Sabby: restores social stats when exiting Zulo
	human.st_remove_stat_mod(STAT_MANIPULATION, type)
	human.st_remove_stat_mod(STAT_CHARISMA, type)
	human.st_remove_stat_mod(STAT_STRENGTH, type)
	human.st_remove_stat_mod(STAT_DEXTERITY, type)
	human.st_remove_stat_mod(STAT_STAMINA, type)
	if(zulo_backpack_to_hide)
		zulo_backpack_to_hide.worn_icon_state = initial(zulo_backpack_to_hide.worn_icon_state)
		human.update_worn_back()
		zulo_backpack_to_hide = null
	// Sabby: learned from fera code. Needed for revert on death.
	UnregisterSignal(human, COMSIG_LIVING_DEATH)

// Sabby: learned from fera code, feeds into the registered signal gained/lost with species
/datum/species/tzimisce_zulo_form/proc/revert_on_zulo_death(mob/living/carbon/human/source)
	source.set_species(mrace = /datum/species/human, icon_update = TRUE, pref_load = TRUE, replace_missing = FALSE)

// Sabby: similar to fera_organs line 17, this applies the height adjustment to the chest part (avoids pixel distortion in Zulo sprites)
/obj/item/bodypart/chest/zulo/update_mob_heights(mob/living/carbon/human/holder)
	return HUMAN_HEIGHT_MEDIUM

////////////////////
// Sabby: This is a very clumsy solution that I'd love help improving in the future.
// Basically, the only way I could figure out to account for multiple future sprites while
// maintaining a carbon form was to create species datums for each (and future) sprite.
// Each inherits from the parent zulo datum, and all each does is simply override.
////////////////////

// Sabby: Beast form uses weretzi limb sprites
/datum/species/tzimisce_zulo_form/beast
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/zulo/beast,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/zulo/beast,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/zulo/beast,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/zulo/beast,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/zulo/beast,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/zulo/beast,
	)
// Sabby: Brust form uses 4armstzi limb sprites
/datum/species/tzimisce_zulo_form/brust
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/zulo/brust,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/zulo/brust,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/zulo/brust,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/zulo/brust,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/zulo/brust,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/zulo/brust,
	)
// Sabby: Noble form uses nobletzi limb sprites
/datum/species/tzimisce_zulo_form/noble
	sprite_size_transform = 1.5 //Sabby: good to apply size transform to 32x32 sprites so Zulo looks a bit bigger than regular character sprites.
	bodypart_overrides = list(
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/zulo/noble,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/zulo/noble,
		BODY_ZONE_HEAD = /obj/item/bodypart/head/zulo/noble,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/zulo/noble,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/zulo/noble,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/zulo/noble,
	)
