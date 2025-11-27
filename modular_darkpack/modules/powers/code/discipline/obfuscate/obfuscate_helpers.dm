/// Called when [TRAIT_OBFUSCATED] is added to the mob.
/mob/living/proc/make_invisible(datum/source)
	SIGNAL_HANDLER
	animate(src, invisibility = OBFUSCATE_INVISIBILITY, time = 0.5 SECONDS)
	add_obficon()

/// Called when [TRAIT_OBFUSCATED] is removed from the mob.
/mob/living/proc/make_visible(datum/source)
	SIGNAL_HANDLER
	animate(src, invisibility = NONE, time = 0.5 SECONDS)
	remove_obficon()

/// Creating & Handling obfuscate indicator
/mob/living/proc/add_obficon()
	if(!client)
		return
	var/image/icon = image('modular_darkpack/modules/powers/icons/obfuscate_shadow.dmi', src, "shadow", FLY_LAYER)
	icon.alpha = 100
	icon.pixel_y = -4
	LAZYINITLIST(obf_icons)
	obf_icons += icon
	client.images |= icon

/mob/living/proc/remove_obficon()
	if(!client || !obf_icons)
		return
	for(var/image/I in obf_icons)
		if(I in client.images)
			client.images -= I
	obf_icons = null
