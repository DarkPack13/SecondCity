// VTM pg. 480
/datum/quirk/darkpack/bruiser
	name = "Bruiser"
	desc = {"Your appearance is sufficiently thug-like to inspire fear (or at least disquiet) in those who see you.
While you're not necessarily ugly, you do radiate a quiet menace, to the point where people cross the street to avoid passing near you.
All Intimidation rolls against those who have not demonstrated their physical superiority to you are at -1 difficulty."}
	icon = FA_ICON_BASEBALL_BAT_BALL
	value = 1
	gain_text = span_notice("You feel menacing.")
	lose_text = span_notice("You feel average.")
	failure_message = span_notice("You just can't pull off the menacing look.")
	mob_trait = TRAIT_BRUISER

/*Your appearance is sufficiently thug-like to inspire
fear (or at least disquiet) in those who see you. While
you’re not necessarily ugly, you do radiate a quiet men
ace, to the point where people cross the street to avoid
passing near you. All Intimidation rolls against those
who have not demonstrated their physical superiority
to you are at -1 difficulty.*/
