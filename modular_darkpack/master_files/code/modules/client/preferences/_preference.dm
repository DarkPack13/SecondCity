/datum/preference
	/// If set to TRUE, this preference will not be applied unless the character has the preference's relevant inherent trait
	var/must_have_relevant_trait = FALSE
	/// Alternative job titles stored in preferences. Assoc list, ie. alt_job_titles["Scientist"] = "Cytologist"
	var/list/alt_job_titles = list()
