GLOBAL_ALIST_INIT(stat_attribute_prios, generate_stat_priority_permutations("Physical", "Social", "Mental", 7, 5, 3))
GLOBAL_ALIST_INIT(stat_ability_prios, generate_stat_priority_permutations("Talents", "Skills", "Knowledges", 13, 9, 5))

/proc/generate_stat_priority_permutations(stat1, stat2, stat3, dots1, dots2, dots3)
	var/alist/results = list()

	var/list/items = list(stat1, stat2, stat3)

	for(var/i = 1 to 3)
		for(var/j = 1 to 3)
			if(j == i)
				continue

			for(var/k = 1 to 3)
				if(k == i || k == j)
					continue

				var/alist/priorities = alist(
					items[i] = dots1,
					items[j] = dots2,
					items[k] = dots3,
				)

				results[jointext(list(items[i], items[j], items[k]), ", ")] = alist(priorities)

	return results

/*
/datum/preference/choiced/stat_spreads
	abstract_type = /datum/preference/choiced/stat_spreads


/datum/preference/choiced/stat_spreads/attribute

/datum/preference/choiced/stat_spreads/ability
*/
