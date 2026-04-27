// VTM pg. 480
/datum/quirk/darkpack/enchanting_voice
	name = "Enchanting Voice"
	desc = {"There is something about your voice that others cannot ignore.
When you command, they are cowed. When you seduce, they swoon.
Whether thundering, soothing, persuading, or simply talking, your voice commands attention.
The difficulties of all rolls involving the use of the voice to persuade, charm, or command are reduced by two."}
	icon = FA_ICON_FACE_GRIN_HEARTS
	value = 2
	gain_text = span_notice("Your voice sounds especially charming.")
	lose_text = span_notice("You feel your voice hitch.")
	failure_message = span_notice("You don't sound as good as you thought.")
	mob_trait = TRAIT_ENCHANTING_VOICE
