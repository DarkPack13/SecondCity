/datum/quirk/darkpack/vicissitude_modifications
	abstract_type = /datum/quirk/darkpack/vicissitude_modifications
	name = "Vicissitude Modifications"
	desc = "You are a ghoul whose body has been hideously modified through the use of the Vicissitude Discipline. This will grant the Monstrous flaw if not already taken."
	allowed_splats = list(SPLAT_GHOUL)
	// Ghouls dont acctually care about clans rn?
	// included_clans = list(VAMPIRE_CLAN_TZIMISCE)
	icon = FA_ICON_TEETH_OPEN
	quirk_flags = QUIRK_CHANGES_APPEARANCE
	ttrpg_sources = list(/datum/source_book/vtm20/ghouls_and_revenants = 134)

/datum/quirk/darkpack/vicissitude_modifications/add(client/client_source)
	. = ..()
	quirk_holder.add_quirk(/datum/quirk/darkpack/monstrous)

/*
/datum/quirk/darkpack/vicissitude_modifications/fangs
	name = "Vicissitude Modifications (Fangs)"
	value = 1
*/


// Meant to be +2 to soak.
/datum/quirk/darkpack/vicissitude_modifications/carapace
	name = "Vicissitude Modifications (Carapace)"
	value = 3

/datum/quirk/darkpack/vicissitude_modifications/carapace/add(client/client_source)
	. = ..()
	// ugh. This needs to be fixed when my TG pull is in.
	var/mob/living/carbon/human/human_owner = astype(quirk_holder)
	if(!human_owner)
		return
	human_owner.physiology.armor = human_owner.physiology.armor.add_other_armor(/datum/armor/vicissitude_modifications_carapace)

/datum/quirk/darkpack/vicissitude_modifications/carapace/remove()
	. = ..()
	var/mob/living/carbon/human/human_owner = astype(quirk_holder)
	if(!human_owner)
		return
	human_owner.physiology.armor = human_owner.physiology.armor.subtract_other_armor(/datum/armor/vicissitude_modifications_carapace)

/datum/armor/vicissitude_modifications_carapace
	acid = 10
	bio = 10
	bomb = 15
	bullet = 15
	consume = 15
	energy = 15
	laser = 15
	fire = 10
	melee = 15
	wound = 15

/* Port https://github.com/Monkestation/crimson-grid/pull/165
/datum/quirk/darkpack/vicissitude_modifications/armblade
	name = "Vicissitude Modifications (Armblade)"
	desc = "You are a ghoul whose body has been hideously modified through the use of the Vicissitude Discipline. This will grant the Monstrous flaw if not already taken. Through vicissitude, one of your arms has been given a horrifyingly sharp bone blade that is concealed."
	value = 5
	icon = FA_ICON_PERSON_RIFLE
	ttrpg_sources = list(/datum/source_book/homebrew = WE_MADE_IT_UP)


/datum/quirk/darkpack/vicissitude_modifications/armblade/add_unique(client/client_source)
	. = ..()
	var/mob/living/carbon/human/human_holder = astype(quirk_holder)
	if(!human_holder)
		return
	var/obj/item/organ/cyberimp/arm/toolkit/tzimisce/arm_blade = new()
	arm_blade.Insert(human_holder)
*/
