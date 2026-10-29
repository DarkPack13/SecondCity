// DARKPACK TODO - FRENZY - (This never did FUCK anything.)
/obj/item/occult_artifact/vampire/tarulfang
	true_name = "Tarulfang"
	true_desc = "Decreases chance of frenzy."
	icon_state = "tarulfang"
	taint_wyld = 3

/obj/item/occult_artifact/vampire/tarulfang/grant_powers()
	. = ..()
	owner.frenzy_chance_boost = 5

/obj/item/occult_artifact/vampire/tarulfang/ungrant_powers()
	. = ..()
	owner.frenzy_chance_boost = 10
