/datum/component/crusties
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/alist/dna_sequences = list()

/datum/component/crusties/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT, PROC_REF(Destroy))

/datum/component/crusties/Initialize(list/blood_or_dna)
	. = ..()
	if(!(blood_or_dna in dna_sequences))
		dna_sequences += blood_or_dna
	else
		return COMPONENT_REDUNDANT

/datum/component/crusties/UnregisterFromParent()
	. = ..()
	UnregisterSignal(parent, COMSIG_COMPONENT_CLEAN_ACT)

/datum/component/crusties/Destroy()
	dna_sequences = list()
	. = ..()
