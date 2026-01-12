/mob/living/proc/AdjustHumanity(value, limit, forced)
	// Only vampires have a "working" morality system currently
	var/datum/splat/vampire/kindred/vampirism = iskindred(src)
	if (!vampirism)
		return

	// "Enlightenment" is essentially the Path of Pure Evil. Inverts Humanity changes and limits.
	var/is_enlightenment = vampirism.enlightenment
	var/path = is_enlightenment ? "Enlightenment" : "Humanity"
	if (is_enlightenment && !forced)
		value = -value
		limit = 10 - limit

	// Work out actual change in Humanity
	var/new_humanity
	var/humanity_change
	if (value > 0)
		new_humanity = clamp(humanity + value, 0, limit)
		humanity_change = new_humanity - humanity

		// Hit the limit for increase, no change
		if (humanity_change <= 0)
			return
	else if (value < 0)
		var/loss_modifier = HAS_TRAIT(src, TRAIT_SENSITIVE_HUMANITY) ? 2 : 1
		value *= loss_modifier

		new_humanity = clamp(humanity + value, limit, 10)
		humanity_change = new_humanity - humanity

		// Hit the limit for decrease, no change
		if (humanity_change >= 0)
			return
	else
		return

	var/signal_return = SEND_SIGNAL(src, COMSIG_LIVING_CHANGING_HUMANITY, humanity_change)
	if (signal_return & BLOCK_HUMANITY_CHANGE)
		return

	// Change Humanity according to calculated values
	humanity += humanity_change
	if (humanity_change > 0)
		SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/humanity_gain.ogg', 0, 0, 75))
		to_chat(src, span_boldnicegreen("[uppertext(path)] INCREASED!"))

		// Gaining Path flavour text
		switch (humanity)
			if (10)
				to_chat(src, span_green("As your [path] reaches its peak, you feel the Beast [is_enlightenment ? "reaching perfect harmony with you" : "falling into a deep slumber, waiting"]."))
	else if (humanity_change < 0)
		SEND_SOUND(src, sound('modular_darkpack/modules/deprecated/sounds/humanity_loss.ogg', 0, 0, 75))
		to_chat(src, span_userdanger(span_bold("[uppertext(path)] DECREASED!")))

		// Losing Path flavour text
		switch (humanity)
			if (1)
				to_chat(src, span_userdanger(span_bold("BLOOD. FEED. HUNGER.")))
			if (2)
				to_chat(src, span_userdanger("You are losing your mind. The [span_bold("BEAST")] commands you."))
			if (3)
				to_chat(src, span_danger("Your higher reason is eroding. The Beast is gaining control..."))
			if (4)
				to_chat(src, span_danger("You feel the Beast gnawing at the edges of your mind..."))
			if (9)
				to_chat(src, span_warning("As you fall from your perfect [path], you feel the Beast [is_enlightenment ? "taking power over" : "reawakening in"] a dark corner of your soul."))

	SEND_SIGNAL(src, COMSIG_LIVING_CHANGED_HUMANITY, humanity_change)
