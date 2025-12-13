GLOBAL_LIST_INIT(bloodpool_by_gen, list(
	0, // index filler
	0, // 1st (not normally used)
	0, // 2nd
	0, // 3rd
	50, // 4th
	40, // 5th
	30, // 6th
	20, // 7th
	15, // 8th
	14, // 9th
	13, // 10th
	12, // 11th
	11, // 12th
	10, // 13th
	10, // 14th
	10, // 15th
	10 // 16th
))

/proc/get_max_bloodpool(gen)
	if(gen < 1)
		return 0
	if(gen > HIGHEST_GENERATION_LIMIT)
		return 10
	return GLOB.bloodpool_by_gen[gen]
