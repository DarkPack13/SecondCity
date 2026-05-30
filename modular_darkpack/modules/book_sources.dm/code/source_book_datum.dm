/datum/source_book
	var/name
	/// Determiner for how accurate it is to whitewolf published media.
	var/offical_status
	/// Media does not have or care about page numbers
	var/ignore_pages = FALSE

/datum/source_book/vtm20
	name = "Vampire The Masquerade 20th Anniversary Edition"
	offical_status = SOURCE_OFFICAL

/datum/source_book/hunterhunted2
	name = "The Hunters Hunted II"
	offical_status = SOURCE_OFFICAL

/datum/source_book/ghouls_and_revenants
	name = "Ghouls & Revenants"
	offical_status = SOURCE_OFFICAL

/datum/source_book/wta20
	name = "Werewolf The Apocalypse 20th Anniversary Edition"
	offical_status = SOURCE_OFFICAL

/datum/source_book/homebrew
	name = "Homebrew"
	offical_status = SOURCE_HOMEBREW

/datum/proc/highest_source_offical_status()
	var/static/list/priority = list(
		SOURCE_OFFICAL = 1,
		SOURCE_STORYTELLER_VAULT = 2,
		SOURCE_HOMEBREW = 3,
	)
	var/highest_book
	for(var/datum/source_book/book, page_number in ttrpg_sources)
		if(!highest_book || priority[book] < highest_book)
			highest_book = priority[book]

	return highest_book

/datum/proc/get_book_sources_readable()
	var/books = list()
	for(var/datum/source_book/book, page_number in ttrpg_sources)
		if(isnum(page_number))
			books += "[book::name]: p. [page_number]"
		else
			books += "[book::name]: [page_number]"
