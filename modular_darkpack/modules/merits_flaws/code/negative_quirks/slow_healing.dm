// V20 pg. 483
/datum/quirk/darkpack/slow_healing
	name = "Slow Healing"
	desc = "You have difficulty healing wounds. It requires twice the blood points to heal yourself."
	value = -3
	mob_trait = TRAIT_SLOW_HEALING
	gain_text = span_notice("Your wounds sting.")
	lose_text = span_notice("You no longer feel worried about your wounds.")
	allowed_splats = list(SPLAT_KINDRED)
	icon = FA_ICON_BANDAGE
	failure_message = "You no longer feel worried about your wounds."

/*You have difficulty healing wounds. It requires two
blood points to heal one health level of bashing or le
thal damage, and you heal one health level of aggra
vated damage every five days (plus the usual five blood
points and Willpower expenditure).*/
