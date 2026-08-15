/datum/element/decal/crusties
	var/list/dna_sequence

/datum/element/crusties/Attach(list/blood_or_dna)
	. = ..()
	dna_sequence = blood_or_dna

/datum/element/crusties/Detach(datum/source, ...)
	. = ..()
	dna_sequence = null
