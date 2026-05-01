/obj/structure/city_map
	name = "\improper map"
	desc = "Locate yourself now."
	icon = 'modular_darkpack/modules/decor/icons/city_map.dmi'
	icon_state = "map"
	anchored = TRUE
	density = TRUE
	var/page_link = "Map"

/obj/structure/city_map/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/contextual_screentip_bare_hands, lmb_text = "Navigate", rmb_text = "Open Map")

/obj/structure/city_map/attack_hand(mob/user)
	. = ..()
	if(check_holidays(FESTIVE_SEASON))
		var/area/my_area = get_area(src)
		if(istype(my_area) && my_area.outdoors)
			icon_state = "[initial(icon_state)]-snow"
	if(!isliving(user))
		return TRUE
	var/mob/living/navigator = user
	navigator.navigate()

/obj/structure/city_map/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	var/wiki_url = CONFIG_GET(string/wikiurl)
	if(!wiki_url)
		return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
	var/confirmation = (alert(user, "View the map on the wiki?", "[src]", "Yes", "No"))
	if(confirmation == "Yes")
		DIRECT_OUTPUT(user, link("[wiki_url]/[page_link]"))
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN
