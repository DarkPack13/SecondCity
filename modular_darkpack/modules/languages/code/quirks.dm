#warn I will almost 100% remove these.
/datum/quirk/espanol
	name = "Espanol"
	desc = "You know the Spanish language."
	value = 1

/datum/quirk/espanol/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/espanol)

/datum/quirk/chinese
	name = "Mandarin"
	desc = "You know Mandarin."
	value = 1

/datum/quirk/chinese/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/mandarin)

/datum/quirk/cantonese
	name = "Cantonese"
	desc = "You know Cantonese."
	value = 1

/datum/quirk/cantonese/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/cantonese)

/datum/quirk/russian
	name = "Russian"
	desc = "You know the Russian language."
	value = 1

/datum/quirk/russian/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/russian)

/datum/quirk/japanese
	name = "Japanese"
	desc = "You know the Japanese language."
	value = 1

/datum/quirk/japanese/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/japanese)

/datum/quirk/italian
	name = "Italian"
	desc = "You know the Italian language."
	value = 1

/datum/quirk/italian/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/italian)

/datum/quirk/german
	name = "German"
	desc = "You know the German language."
	value = 1

/datum/quirk/german/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/german)

/datum/quirk/latin
	name = "Latin"
	desc = "You know the ancient Latin language."
	value = 1

/datum/quirk/latin/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/latin)

/datum/quirk/hebrew
	name = "Hebrew"
	desc = "You know the ancient Hebrew language."
	value = 1

/datum/quirk/hebrew/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/hebrew)

/datum/quirk/french
	name = "French"
	desc = "You know the romantic language of the French."
	value = 1

/datum/quirk/french/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/french)

/datum/quirk/arabic
	name = "Arabic"
	desc = "You know the melodic language of the Middle East."
	value = 1

/datum/quirk/arabic/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/arabic)

/datum/quirk/greek
	name = "Greek"
	desc = "You know the romantic language of the Greeks."
	value = 1

/datum/quirk/greek/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/greek)

/datum/quirk/irish // APOC EDIT ADD // This is part of the TFN PR, but doesn't have comments.
	name = "Irish"
	desc = "You know the Irish language."
	value = 1

/datum/quirk/irish/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/irish)

/datum/quirk/scottish
	name = "Scottish"
	desc = "You know the Scottish language."
	value = 1

/datum/quirk/scottish/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/scottish)

/datum/quirk/welsh
	name = "Welsh"
	desc = "You know the Welsh language."
	value = 1

/datum/quirk/welsh/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/welsh)

/datum/quirk/armenian
	name = "Armenian"
	desc = "You know the Armenian language."
	value = 1

/datum/quirk/armenian/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/armenian)

/datum/quirk/farsi
	name = "Farsi"
	desc = "You know the Persian language."
	value = 1

/datum/quirk/farsi/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/farsi)

/datum/quirk/korean
	name = "Korean"
	desc = "You know the Korean language."
	value = 1

/datum/quirk/korean/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/korean)

/datum/quirk/tagalog
	name = "Tagalog"
	desc = "You know the Filipino language."
	value = 1

/datum/quirk/tagalog/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/tagalog) // This is where the TFN PR ends

/datum/quirk/portuguese
	name = "Portuguese"
	desc = "You know the Portuguese language."
	value = 1

/datum/quirk/portuguese/add()
	var/mob/living/carbon/H = quirk_holder
	H.grant_language(/datum/language/tagalog) // APOC EDIT END
