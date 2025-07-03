/obj/structure/vampmap
	name = "\improper map"
	desc = "Locate yourself now."
	icon = 'icons/wod13/props.dmi'
	icon_state = "map"
	plane = GAME_PLANE
	layer = ABOVE_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/vampmap/attack_hand(mob/user)
	. = ..()
	var/dat = {"
			<style type="text/css">

			body {
				background-color: #090909; color: white;
			}

			</style>
			"}
	var/obj/damap/DAMAP = new(user)
	var/obj/damap/supply/SU = new(user)
	var/obj/damap/church/CH = new(user)
	var/obj/damap/graveyard/GR = new(user)
	var/obj/damap/hotel/HO = new(user)
	var/obj/damap/tower/TO = new(user)
	var/obj/damap/clean/CL = new(user)
	var/obj/damap/theatre/TH = new(user)
	var/obj/damap/bar/BA = new(user)
	var/obj/damap/hospital/HS = new(user)
	var/obj/overlay/AM = new(DAMAP)
	AM.icon = 'icons/wod13/disciplines.dmi'
	AM.icon_state = "target"
	AM.layer = ABOVE_HUD_LAYER
	AM.pixel_x = x-4
	AM.pixel_y = y-4
	DAMAP.overlays |= AM
	dat += "<center>[icon2html(getFlatIcon(DAMAP), user)]</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(SU), user)] - Railway Station;</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(CH), user)] - Catholic Church;</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(GR), user)] - City Graveyard;</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(HO), user)] - Hotel \"Cock Roach\";</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(TO), user)] - Millenium Tower;</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(CL), user)] - Cleaning Services;</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(TH), user)] - National Theatre;</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(BA), user)] - Bar \"Big Shoe\";</center><BR>"
	dat += "<center>[icon2html(getFlatIcon(HS), user)] - City Hospital.</center>"
	user << browse(dat, "window=map;size=400x600;border=1;can_resize=0;can_minimize=0")
	onclose(user, "map", src)
	qdel(DAMAP)
	qdel(AM)
	qdel(SU)
	qdel(CH)
	qdel(GR)
	qdel(HO)
	qdel(TO)
	qdel(CL)
	qdel(TH)
	qdel(BA)
	qdel(HS)

/obj/damap
	icon = 'icons/wod13/map.dmi'
	icon_state = "map"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/supply
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "supply"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/church
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "church"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/graveyard
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "graveyard"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/hotel
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "hotel"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/tower
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "tower"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/clean
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "clean"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/theatre
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "theatre"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/bar
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "bar"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/damap/hospital
	icon = 'icons/wod13/disciplines.dmi'
	icon_state = "hospital"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
