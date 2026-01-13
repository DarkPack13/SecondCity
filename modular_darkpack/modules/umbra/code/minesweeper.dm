/obj/minespot
	name = "safe umbral tether"
	desc = "Connects the parts of Penumbra together."
	icon = 'modular_darkpack/modules/umbra/icons/umbra.dmi'
	icon_state = "tile1"
	plane = GAME_PLANE
	layer = BELOW_OBJ_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	anchored = TRUE
	density = TRUE
	var/marked = FALSE
	var/bomb = FALSE
	var/uncovered = FALSE
	var/amount_of_bombs
	var/dangerous = FALSE

/obj/minespot/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "Uncover", rmb_text = "Mark")
	color = "#8e8e8e"
	icon_state = "tile[rand(1, 16)]"

/obj/minespot/examine(mob/user)
	. = ..()
	if(!bomb && uncovered)
		. += "There are [amount_of_bombs] nearby"

/obj/minespot/proc/uncover(mob/living/user)
	if(uncovered || marked)
		return FALSE
	uncovered = TRUE
	density = FALSE
	if(bomb)
		animate(src, color = "#FFFFFF", time = 1 SECONDS)
		icon_state = "boom"
		if(!dangerous)
			return
		var/roll_result = SSroll.storyteller_roll(user.st_get_stat(STAT_PERCEPTION) + user.st_get_stat(STAT_OCCULT), 6, list(user), user)
		switch(roll_result)
			if(ROLL_SUCCESS)
				to_chat(user, span_revenwarning("Close... but the spirits do not punish you for this one."))
			if(ROLL_FAILURE)
				to_chat(user, span_revendanger("Too close... Your mind feels uneasy from that."))
				user.adjust_agg_loss(5)
			if(ROLL_BOTCH)
				to_chat(user, span_revendanger("THE SPIRITS PUNISH YOU FOR THAT ONE."))
				user.adjust_agg_loss(25)
		return
	amount_of_bombs = nearby_mines()
	switch(amount_of_bombs)
		if(0)
			animate(src, color = "#FFFFFF", time = 1 SECONDS)
		if(1)
			animate(src, color = "#00edff", time = 1 SECONDS)
		if(2)
			animate(src, color = "#40ff00", time = 1 SECONDS)
		if(3)
			animate(src, color = "#ffbf00", time = 1 SECONDS)
		if(4)
			animate(src, color = "#ff0000", time = 1 SECONDS)
		if(5)
			animate(src, color = "#ff0089", time = 1 SECONDS)
		if(6)
			animate(src, color = "#c800ff", time = 1 SECONDS)
		if(7)
			animate(src, color = "#4000ff", time = 1 SECONDS)
		if(8)
			animate(src, color = "#4000ff", time = 1 SECONDS)
	if(!bomb && amount_of_bombs == 0)
		for(var/obj/minespot/M in range(1, src))
			M.uncover(user)
	return TRUE

/obj/minespot/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	return uncover(user)

/obj/minespot/Bumped(atom/movable/bumped_atom)
	if(!dangerous && isliving(bumped_atom))
		uncover(bumped_atom)
	. = ..()

/obj/minespot/proc/nearby_mines()
	var/nearby_bombs = 0
	for(var/obj/minespot/M in range(1, src))
		if(M.bomb)
			nearby_bombs += 1
	return clamp(nearby_bombs, 0, 8)

/obj/minespot/attack_hand_secondary(mob/living/user, list/modifiers)
	. = ..()
	if(!uncovered)
		if(!marked)
			icon_state = "marked"
			marked = TRUE
		else
			icon_state = "tile[rand(1, 16)]"
			marked = FALSE
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/minespot/playable
	name = "umbral tether"

/obj/minespot/playable/Initialize(mapload)
	. = ..()
	if(prob(20))
		bomb = TRUE

/obj/minespot/playable/dangerous
	name = "unforgiving umbral tether"
	dangerous = TRUE
