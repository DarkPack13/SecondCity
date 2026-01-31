// Base color auras
#define AURA_AFRAID COLOR_ORANGE // Orange
#define AURA_AGGRESSIVE COLOR_PURPLE // Purple
#define AURA_ANGRY COLOR_RED // Red
#define AURA_BITTER COLOR_BROWN // Brown
#define AURA_CALM COLOR_CARP_LIGHT_BLUE // Light Blue
#define AURA_COMPASSIONATE COLOR_PINK // Pink
#define AURA_CONSERVATIVE LIGHT_COLOR_LAVENDER // Lavender
#define AURA_DEPRESSED COLOR_GRAY // Gray
#define AURA_DESIROUS COLOR_DARK_RED // Deep Red
#define AURA_DISTRUSTFUL LIGHT_COLOR_GREEN // Light Green
#define AURA_ENVIOUS COLOR_CARP_DARK_GREEN // Dark Green
#define AURA_EXCITED COLOR_VIOLET // Violet
#define AURA_GENEROUS COLOR_LIGHT_PINK // Rose
#define AURA_HAPPY COLOR_VIVID_RED // Vermillion
#define AURA_HATEFUL COLOR_BLACK // Black
#define AURA_IDEALISTIC COLOR_YELLOW // Yellow
#define AURA_INNOCENT COLOR_WHITE // White
#define AURA_LOVESTRUCK COLOR_BLUE // Blue
#define AURA_OBSESSED COLOR_GREEN // Green
#define AURA_SAD COLOR_SILVER // Silver
#define AURA_SPIRITUAL COLOR_GOLD // Gold
#define AURA_SUSPICIOUS COLOR_STRONG_BLUE // Dark Blue

// Modifier auras.
#define AURA_ANXIOUS "Anxious" // Auras appear scrambled like static or white noise

#define AURA_CONFUSED "Confused" // Mottled, shifting colors -- Intermittent pauses in animation
#define AURA_DAYDREAMING "Daydreaming" // Sharp flickering colors -- Slow animation
#define AURA_PSYCHOTIC "Psychotic" // Hypnotic, swirling colors -- Fast animation

// Untoggleable auras. Left in here as reminders of what is used by outside variables.
#define AURA_DIABLERIST (FALSE) // Black veins in aura
#define AURA_FRENZIED (FALSE) // Rapidly rippling colors
#define AURA_VAMPIRE (FALSE) // Aura colors are pale
#define AURA_GHOUL (FALSE) // Pale blotches in the aura
#define AURA_MAGIC_USE (FALSE) // Myriad sparkles in aura -- Not implemented. Mages.
#define AURA_WEREBEAST (FALSE) // Bright, vibrant aura -- DARKPACK TODO - GAROU
#define AURA_GHOST (FALSE) // Weak, intermittent aura
#define AURA_FAERIE (FALSE) // Rainbow highlights in aura -- Not implemented. Changelings.

GLOBAL_LIST_INIT(aura_list, sort_list(list(
"Afraid" = AURA_AFRAID,
"Aggressive" = AURA_AGGRESSIVE,
"Angry" = AURA_ANGRY,
"Bitter" = AURA_BITTER,
"Calm" = AURA_CALM,
"Compassionate" = AURA_COMPASSIONATE,
"Conservative" = AURA_CONSERVATIVE,
"Depressed" = AURA_DEPRESSED,
"Desirous" = AURA_DESIROUS,
"Distrustful" = AURA_DISTRUSTFUL,
"Envious" = AURA_ENVIOUS,
"Excited" = AURA_EXCITED,
"Generous" = AURA_GENEROUS,
"Happy" = AURA_HAPPY,
"Hateful" = AURA_HATEFUL,
"Idealistic" = AURA_IDEALISTIC,
"Innocent" = AURA_INNOCENT,
"Lovestruck" = AURA_LOVESTRUCK,
"Obsessed" = AURA_OBSESSED,
"Sad" = AURA_SAD,
"Spiritual" = AURA_SPIRITUAL,
"Suspicious" = AURA_SUSPICIOUS,
"Anxious" = AURA_ANXIOUS,
"Confused" = AURA_CONFUSED,
"Daydreaming" = AURA_DAYDREAMING,
"Psychotic" = AURA_PSYCHOTIC)))

/proc/emotion_to_quality(emotion)
	var/emo_desc = "bad_code"

	switch(emotion)
		if(AURA_AFRAID)
			emo_desc = "fear"
		if(AURA_AGGRESSIVE)
			emo_desc = "aggressiveness"
		if(AURA_ANGRY)
			emo_desc = "anger"
		if(AURA_BITTER)
			emo_desc = "bitterness"
		if(AURA_CALM)
			emo_desc = "calmness"
		if(AURA_COMPASSIONATE)
			emo_desc = "compassion"
		if(AURA_CONSERVATIVE)
			emo_desc = "conservativeness"
		if(AURA_DEPRESSED)
			emo_desc = "depression"
		if(AURA_DESIROUS)
			emo_desc = "desire"
		if(AURA_DISTRUSTFUL)
			emo_desc = "distrust"
		if(AURA_ENVIOUS)
			emo_desc = "envy"
		if(AURA_EXCITED)
			emo_desc = "excitement"
		if(AURA_GENEROUS)
			emo_desc = "generosity"
		if(AURA_HAPPY)
			emo_desc = "happiness"
		if(AURA_HATEFUL)
			emo_desc = "hate"
		if(AURA_IDEALISTIC)
			emo_desc = "idealism"
		if(AURA_INNOCENT)
			emo_desc = "innocence"
		if(AURA_LOVESTRUCK)
			emo_desc = "love"
		if(AURA_OBSESSED)
			emo_desc = "obsessiveness"
		if(AURA_SAD)
			emo_desc = "sadness"
		if(AURA_SPIRITUAL)
			emo_desc = "spirituality"
		if(AURA_SUSPICIOUS)
			emo_desc = "suspicion"
		if(AURA_ANXIOUS)
			emo_desc = "anxiety"
		if(AURA_CONFUSED)
			emo_desc = "confusion"
		if(AURA_DAYDREAMING)
			emo_desc = "absentmindedness"
		if(AURA_PSYCHOTIC)
			emo_desc = "psychosis"

	return emo_desc
