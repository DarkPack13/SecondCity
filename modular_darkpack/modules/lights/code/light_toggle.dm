/obj/machinery/light/click_alt(mob/living/user)
	to_chat(user, span_notice("<i>You look for the lightswitch...</i>"))
	if(!do_after(user, 2 SECONDS, timed_action_flags = IGNORE_HELD_ITEM))
		return
	set_on(!on)
	balloon_alert_to_viewers("<B>[user] toggles [src] [on ? "on" : "off"].</B>")
	return CLICK_ACTION_SUCCESS

/obj/machinery/light/examine_more(mob/user)
	. = ..()
	. += span_notice("<i>You can toggle the light on or off via alt-click.</i>")
	return .
