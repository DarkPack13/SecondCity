/obj/item/occult_artifact/vampire/mummywrap_fetish
	true_name = "Mummywrap Fetish"
	true_desc = "Passive health regeneration."
	icon_state = "m_fetish"
	research_value = 10
	var/last_regen = 0

/obj/item/occult_artifact/vampire/mummywrap_fetish/process(seconds_per_tick)
	. = ..()
	if(identified && owner)
		if(last_regen + 6 SECONDS < world.time)
			last_regen = world.time
			owner.heal_storyteller_health(dots_to_heal = 1, heal_aggravated = FALSE, heal_scars = TRUE, heal_blood = TRUE)
