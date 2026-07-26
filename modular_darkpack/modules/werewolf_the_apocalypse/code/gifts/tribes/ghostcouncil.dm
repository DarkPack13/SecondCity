/datum/action/cooldown/power/gift/sense_magic
	name = "Sense Magic"
	desc = {"The werewolf can sense the pulse and flux of mystic energies, whether the righteous Gifts of the Garou,
	the arrogant wizardry of mages, the debased powers of vampires, or even the black arts of the Wyrm's minions"}
	rank = 1
	/// List of old atoms we already rolled for.
	var/list/datum/weakref/old_attempts = list()


/datum/storyteller_roll/gift/sense_magic
	bumper_text = /datum/action/cooldown/power/gift/sense_magic::name
	applicable_stats = list(STAT_PERCEPTION, STAT_INVESTIGATION) // DARKPACK TODO - STAT_ENIGMA is not real yet.
	numerical = TRUE
	hide_result = TRUE


/datum/action/cooldown/power/gift/sense_magic/Activate(atom/target)
	. = ..()

	var/list/magic_sources = list()
	for(var/atom/nearby_atom in orange(owner, DEFAULT_SIGHT_DISTANCE))
		if(nearby_atom.get_magic_sources())
			nearby_atom += magic_sources

	for(var/datum/weakref/old_ref in old_attempts)
		var/atom/resolved = old_ref.resolve()
		if(!resolved)
			old_attempts -= old_ref
		else
			magic_sources -= resolved


