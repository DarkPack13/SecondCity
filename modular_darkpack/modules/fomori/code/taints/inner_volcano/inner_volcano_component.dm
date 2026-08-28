/datum/component/inner_volcano
	var/list/watched_stats = list(
			STAT_STRENGTH,
			STAT_DEXTERITY,
			STAT_STAMINA,
			STAT_ATHLETICS,
			STAT_BRAWL,
			STAT_FIREARMS,
			STAT_LARCENY,
			STAT_MELEE,
			STAT_PERFORMANCE, // stage-fright
			STAT_STEALTH, // we stressed about getting caught
			STAT_SURVIVAL, // stressed about surviving
			STAT_PERMANENT_WILLPOWER, // we're testing our inner willpower. stressful
			STAT_TEMPORARY_WILLPOWER, // ditto
			STAT_COURAGE, // ditto 2
		)

/datum/component/inner_volcano/Initialize()
	. = ..()
	if(!ishuman(parent))
		return ELEMENT_INCOMPATIBLE
	to_chat(world, "[type] added to [parent]")
	RegisterSignal(parent, COMSIG_LIVING_DICE_ROLLED, PROC_REF(on_dice_rolled))
	RegisterSignal(parent, COMSIG_HUMAN_CORETEMP_CHANGE, PROC_REF(on_coretemp_change))

/datum/component/inner_volcano/proc/on_dice_rolled(mob/living/carbon/human/human_roller, datum/storyteller_roll/roll_datum, atom/target, output)
	for(var/datum/st_stat/stat in roll_datum.applicable_stats)
		if(stat in watched_stats)
			break // breaking here means we found a stat that we're looking for
	human_roller.adjust_coretemperature(15) // Heat damage is set to start at BODYTEMP_NORMAL + 90

/datum/component/inner_volcano/proc/on_coretemp_change(oldvalue, newvalue) // We adjust the bodytemp back up if we are getting colder
	var/mob/living/carbon/human/human_parent = parent
	if(newvalue < oldvalue) // if we're getting COLDER
		if(human_parent.coretemperature > BODYTEMP_NORMAL)
			var/change = oldvalue-newvalue
			human_parent.adjust_coretemperature(change*0.75, min_temp = BODYTEMP_NORMAL) // we cool down 25% slower
