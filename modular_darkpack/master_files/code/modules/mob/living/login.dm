//im pretty sure this was originally done because the obfuscate icons are purely client side? must be a better way
/mob/living/Login()
	. = ..()
	if(HAS_TRAIT(src, TRAIT_OBFUSCATED))
		add_obficon()

/mob/living/Logout()
	. = ..()
	remove_obficon()
