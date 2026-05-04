// VTM pg. 481
/datum/quirk/darkpack/nervous_tic
	name = "Nervous Tic"
	desc = {"You have some sort of repetitive motion that you
make in times of stress, and it's a dead giveaway as to
your identity. Examples include a nervous cough, con
stantly wringing your hands, cracking your knuckles,
and so on."}
	icon = FA_ICON_FACE_ROLLING_EYES // Debate on icon? Might not be fitting enough, eh.
	value = -1
	gain_text = span_notice("You feel an urge to do something self-soothing.")
	lose_text = span_notice("You feel calmer.")
	failure_message = span_notice("You feel calmer.")
	roleplay_only = TRUE

/*You have some sort of repetitive motion that you
make in times of stress, and it’s a dead giveaway as to
your identity. Examples include a nervous cough, con
stantly wringing your hands, cracking your knuckles,
and so on. It costs one Willpower to refrain from en
gaging in your tic.*/
