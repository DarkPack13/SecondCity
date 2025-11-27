/mob/living/carbon
	var/chronological_age = 0

	//Shitty VtM vars I'm moving here so they're not strewn around the codebase
	var/datum/vampire_clan/clan

	var/last_repainted_mark

	///Performs CPR on the target after a delay. //[Lucia] what does this mean?
	var/last_cpr_exp = 0

	var/dementia = FALSE

	//[Lucia] I have no clue why this is necessary, TODO: remove
	var/mob/living/caster

	var/datum/job/JOB
	var/last_loot_check = 0

	var/phonevoicetag = 10

	var/hided = FALSE
	var/additional_hands = FALSE
	var/additional_wings = FALSE
	var/additional_centipede = FALSE
	var/additional_armor = FALSE

	var/image/suckbar
	var/atom/suckbar_loc

	var/last_showed = 0
	var/last_raid = 0
	var/killed_count = 0

	bloodquality = 2

	var/can_be_embraced = TRUE
