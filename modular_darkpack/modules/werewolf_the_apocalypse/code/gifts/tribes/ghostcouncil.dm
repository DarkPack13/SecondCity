/datum/action/cooldown/power/gift/sense_magic
	name = "Sense Magic"
	desc = {"The werewolf can sense the pulse and flux of mystic energies, whether the righteous Gifts of the Garou,
	the arrogant wizardry of mages, the debased powers of vampires, or even the black arts of the Wyrm's minions"}
	rank = 1


/datum/storyteller_roll/gift/sense_magic
	bumper_text = /datum/action/cooldown/power/gift/sense_magic::name
	applicable_stats = list(STAT_PERCEPTION, STAT_INVESTIGATION) // DARKPACK TODO - STAT_ENIGMA is not real yet.
	numerical = TRUE


