// VTM pg. 495
/datum/quirk/darkpack/light_sensitive
	name = "Light Sensitive"
	desc = {"You're more sensitive to the sun than others.
Sunlight deals double damage to you."}
	icon = FA_ICON_SUN
	value = -1 // A lot less awful than in the ttrpg
	mob_trait = TRAIT_LIGHT_WEAKNESS
	allowed_splats = list(SPLAT_KINDRED)
	excluded_clans = list(VAMPIRE_CLAN_SETITE, VAMPIRE_CLAN_WARRIOR_SETITE, VAMPIRE_CLAN_TLACIQUE)

/*You are even more sensitive to sunlight than other
vampires are. Sunlight causes double normal damage,
and the light of the moon can cause lethal damage in a
manner similar to the sun, though it must shine direct
ly upon you. Even bright lights hurt your eyes, requir
ing the use of sunglasses. Followers of Set and related
bloodlines cannot take this Flaw, as they already have
a worse version of it.*/
