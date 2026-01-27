/datum/discipline/mytherceria
	name = "Mytherceria"
	desc = "Command fae-like powers to beguile and ensorcell your foes."
	icon_state = "obfuscate"
	power_type = /datum/discipline_power/obfuscate

/datum/discipline_power/mytherceria
	name = "Mytherceria power name"
	desc = "Mytherceria power description"

	activate_sound = 'modular_darkpack/modules/deprecated/sounds/kiasyd.ogg'

/**
 * • Folderol
 *
 * The Kiasyd can cleave truth from lies. The exact effect varies from vampire to vampire.
 * Some Kiasyd experience bleeding from the eyes or ears when they hear
 * a lie, while some Weirdlings’ eyes glow when told a falsehood. Whatever the effect, this power detects lies,
 * not mistakes, meaning that a target has to know he is lying in order for this power to work.
 *
 * The character knows when a target is deliberately lying. No roll or cost associated with this power, but it must be activated
 * by the Kiasyd deliberately. Does not in any way give hints to the truth. Has no effect on people who are not lying intentionally.
 */
/datum/discipline_power/mytherceria/folderol
	name = "Folderol"
	desc = "Detect if a target is deliberately lying."

	level = 1
	check_flags = DISC_CHECK_CONSCIOUS
	target_type = TARGET_LIVING
	vitae_cost = 0
	cooldown_length = 1 TURNS
	range = 7

/datum/discipline_power/auspex/telepathy/activate(mob/living/target)
	. = ..()
	var/mob/living/L = target

	SEND_SOUND(L, sound(activate_sound, 0, 0, 50)) // LOOK OUT! THERE'S A FAIRY!

	var/response_w = input(L, "Does your character believe your last statement to be the truth?") in list("Yes", "No")

	if(response_w == "Yes") // Telling the truth!
		to_chat(user, "<span class='notice'>[L] is not intentionally lying.</span>")
	else if(response_w == "No") // Lying!
		to_chat(user, "<span class='notice'>[L] is LYING!</span>")
	else // Dunno
		to_chat(user, "<span class='notice'>[L]'s truthfulness is difficult to determine.</span>")

	log_directed_talk(owner, target, "[owner] used Folderol on [target]. Response: [response_w]", LOG_SAY, "Folderol")
	return

/**
 * •• Fae Sight
 *
 * The Kiasyd’s knowledge of magic isn’t just theoretical. Their strangely-colored eyes are capable of
 * detecting the arcane energies of the fae, as well as magic from other, more esoteric sources.
 * They are not, however, capable of using this power to detect the residue of ghosts or vampiric magic.
 *
 * The Kiasyd sees faeries and other faetouched mortals for what they really are, no roll required.
 * Additionally, the player can detect ANY magic that is not undead in nature (including ghosts, wraiths, vampires, etc.)
 * This is functionally Scent of the True Form but it can detect magical items and spells as well.
 *
 * TODO: Crinos beast HUD overlay
 *
 *//*
/datum/discipline_power/mytherceria/fae_sight
	name = "Fae Sight"
	desc = "Sense magical residue and see magical beings for what they really are."

	level = 1
	vitae_cost = 0
	check_flags = DISC_CHECK_CONSCIOUS | DISC_CHECK_CAPABLE
	target_type = TARGET_MOB
	range = 7
	duration_length = 1 SCENES
	cooldown_length = 1 SCENES

/datum/discipline_power/mytherceria/fey_sight/activate(mob/living/target)
	. = ..()
	var/list/total_list = list()
	for(var/obj/item/item in target.contents)
		if(istype(item, /obj/item/storage))
			total_list |= item.contents
		total_list |= item
	to_chat(owner, "<span class='purple'>Your fae senses reach out to detect what they're carrying...</span>")
	for(var/obj/item/item in total_list)
		if(item)
			if(item.is_magic)
				to_chat(owner, "- <span class='nicegreen'>[item.name]</span>")
			else if(item.is_iron)
				to_chat(owner, "- <span class='danger'>[item.name]</span>")
			else
				to_chat(owner, "- [item.name]")

/datum/discipline_power/auspex/aura_perception/activate()
	. = ..()
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_FAE_SIGHT]
	target_hud.show_to(owner)

/datum/discipline_power/auspex/aura_perception/deactivate()
	. = ..()
	var/datum/atom_hud/data/auspex_aura/target_hud = GLOB.huds[DATA_HUD_FAE_SIGHT]
	target_hud.hide_from(owner)*/
	#warn MYTHERCERIA 2 COMMENTED OUT
/**
 * ••• Aura Absorption
 *
 * The Kiasyd is capable of seeing images of events and emotions past by touching an object or an area.
 * However, unlike the Auspex Power The Spirit’s Touch, this power absorbs the images, making them harder for
 * other beings with similar powers to access. Anyone attempting to use this power, Spirit’s Touch,
 * or a similar ability to see what the Kiasyd has seen finds that the images are hard to hold,
 * slipping through his mind’s eye like minnows through a stream.
 *
 * Perception + Empathy roll. Functionally spirits touch but erases whatever's discovered.
 *
 * TODO: If we aver add Natures and/or Demeanors, make them temporarily undetectable unless someone beats the first roll.
 * TODO: "The first Kiasyd’s successes subtract from the number of successes scored by anyone trying to read the object thereafter."
 */
/datum/discipline_power/mytherceria/aura_absorption
	name = "Aura Absorption"
	desc = "Find out something about an object and absorb it's resonance."

	level = 3
	check_flags = DISC_CHECK_CONSCIOUS
	vitae_cost = 0
	cooldown_length = 1 TURNS

	toggled = TRUE
#warn MYTHERCERIA 3 UNIMPLEMENTED
