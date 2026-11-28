/obj/item/occult_artifact/vampire/tarulfang
	true_name = "Tarulfang"
	true_desc = "Makes frenzies easier to control."
	icon_state = "tarulfang"
	research_value = 10
	rank = 1

/obj/item/occult_artifact/vampire/tarulfang/grant_powers()
	. = ..()
	ADD_TRAIT(owner, TRAIT_FRENZY_RESISTANT, REF(src))

/obj/item/occult_artifact/vampire/tarulfang/ungrant_powers()
	. = ..()
	REMOVE_TRAIT(owner, TRAIT_FRENZY_RESISTANT, REF(src))
