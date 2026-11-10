/datum/quirk/darkpack/wolf_sense
	name = "Wolf-Sense"
	desc = {"This merit is a blend of folk wisdom, practical sense and animal instincts.
			If you have Wolf-sense and make a successful Intelligence roll,"}
	ttrpg_sources = list(/datum/source_book/wta20/kinfolk_unsung_heroes = 52)
	value = 1
	mob_trait = TRAIT_WOLF_SENSE
	icon = FA_ICON_SHIELD_DOG
	allowed_splats = SPLAT_KINFOLK

/datum/quirk/darkpack/wolf_sense/add(client/client_source)
	RegisterSignals(quirk_holder, list(COMSIG_LIVING_PRE_DICE_ROLLED, COMSIG_LIVING_DICE_ROLLED), PROC_REF(wolf_sense_roll))

/datum/quirk/darkpack/wolf_sense/remove()
	UnregisterSignal(quirk_holder, list(COMSIG_LIVING_PRE_DICE_ROLLED, COMSIG_LIVING_DICE_ROLLED), PROC_REF(wolf_sense_roll))


// Ability Stuff
/datum/storyteller_roll/wolf_sense
	applicable_stats = list(STAT_INTELLIGENCE)
	difficulty = 6
	roll_output_type = null

/datum/quirk/darkpack/wolf_sense
	var/static/list/wolf_sense_text = list(
	"You feel a shiver crawl up your spine!",
	"Your ears twitch..."
	"You feel as if something just happened."
	)

/datum/quirk/darkpack/wolf_sense/proc/wolf_sense_roll()
	SIGNAL_HANDLER
	var/datum/storyteller_roll/wolf_sense/sense_roll = new()
	switch (sense_roll.st_roll(caster, human_target))
		if (ROLL_BOTCH, ROLL_FAILURE)
			return
		if (ROLL_SUCCESS)
			wolf_sense_activate()
	return

/datum/quirk/darkpack/wolf_sense/proc/wolf_sense_activate(mob/living/owner)
	owner.visible_message(span_notice("[pick(wolf_sense_text)]"))

