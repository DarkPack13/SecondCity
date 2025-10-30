// **************************************************************** CHIME OF UNSEEN SPIRITS *************************************************************
/obj/ritualrune/chime_of_unseen_spirits
	name = "Chime of Unseen Spirits"
	desc = "Enchant a chime to reveal the presence of nearby spirits."
	icon_state = "rune6"
	word = "Sonitus occultorum."
	thaumlevel = 1

/obj/ritualrune/chime_of_unseen_spirits/complete()
    new /obj/item/spirit_chime(loc)
    playsound(loc, 'modular_darkpack/modules/deprecated/sounds/thaum.ogg', 50, FALSE)
    qdel(src)
