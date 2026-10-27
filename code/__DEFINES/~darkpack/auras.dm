// Base color auras
#define AURA_AFRAID "Afraid"
#define AURA_AGGRESSIVE "Aggressive"
#define AURA_ANGRY "Angry"
#define AURA_BITTER "Bitter"
#define AURA_CALM "Calm"
#define AURA_COMPASSIONATE "Compassionate"
#define AURA_CONSERVATIVE "Conservative"
#define AURA_DEPRESSED "Depressed"
#define AURA_DESIROUS "Desirous"
#define AURA_DISTRUSTFUL "Distrustful"
#define AURA_ENVIOUS "Envious"
#define AURA_EXCITED "Excited"
#define AURA_GENEROUS "Generous"
#define AURA_HAPPY "Happy"
#define AURA_HATEFUL "Hateful"
#define AURA_IDEALISTIC "Idealistic"
#define AURA_INNOCENT "Innocent"
#define AURA_LOVESTRUCK "Lovestruck"
#define AURA_OBSESSED "Obsessed"
#define AURA_SAD "Sad"
#define AURA_SPIRITUAL "Spiritual"
#define AURA_SUSPICIOUS "Confidence"
#define AURA_CONFIDENCE "Suspicious"
#define AURA_ANXIOUS "Anxious"
#define AURA_CONFUSED "Confused"
#define AURA_DAYDREAMING "Daydreaming"
#define AURA_PSYCHOTIC "Psychotic"

// Modifier auras.

// Auras appear scrambled like static or white noise
// Mottled, shifting colors -- Intermittent pauses in animation
// Sharp flickering colors -- Slow animation
// Hypnotic, swirling colors -- Fast animation

// Untoggleable auras. Left in here as reminders of what is used by outside variables.
#define AURA_DIABLERIST (FALSE) // Black veins in aura
#define AURA_FRENZIED (FALSE) // Rapidly rippling colors
#define AURA_VAMPIRE (FALSE) // Aura colors are pale
#define AURA_GHOUL (FALSE) // Pale blotches in the aura
#define AURA_MAGIC_USE (FALSE) // Myriad sparkles in aura -- Not implemented. Mages.
#define AURA_WEREBEAST (FALSE) // Bright, vibrant aura // WEREWOLF
#define AURA_GHOST (FALSE) // Weak, intermittent aura
#define AURA_FAERIE (FALSE) // Rainbow highlights in aura -- Not implemented. Changelings.

GLOBAL_LIST_INIT(aura_list_to_color, sort_list(list(
	AURA_AFRAID = COLOR_ORANGE,
	AURA_AGGRESSIVE = COLOR_PURPLE,
	AURA_ANGRY = COLOR_RED,
	AURA_BITTER = COLOR_BROWN,
	AURA_CALM = COLOR_CARP_LIGHT_BLUE,
	AURA_COMPASSIONATE = COLOR_PINK,
	AURA_CONSERVATIVE = LIGHT_COLOR_LAVENDER,
	AURA_DEPRESSED = COLOR_GRAY,
	AURA_DESIROUS = COLOR_DARK_RED,
	AURA_DISTRUSTFUL = LIGHT_COLOR_GREEN,
	AURA_ENVIOUS = COLOR_CARP_DARK_GREEN,
	AURA_EXCITED = COLOR_VIOLET,
	AURA_GENEROUS = COLOR_LIGHT_PINK,
	AURA_HAPPY = COLOR_VIVID_RED,
	AURA_HATEFUL = COLOR_BLACK,
	AURA_IDEALISTIC = COLOR_YELLOW,
	AURA_INNOCENT = COLOR_OFF_WHITE,
	AURA_LOVESTRUCK = COLOR_BLUE,
	AURA_OBSESSED = COLOR_GREEN,
	AURA_SAD = COLOR_SILVER,
	AURA_SPIRITUAL = COLOR_GOLD,
	AURA_SUSPICIOUS = COLOR_STRONG_BLUE,
	AURA_CONFIDENCE = COLOR_VIVID_YELLOW,
	AURA_ANXIOUS = "Anxious",
	AURA_CONFUSED = "Confused",
	AURA_DAYDREAMING = "Daydreaming",
	AURA_PSYCHOTIC = "Psychotic",
)))

GLOBAL_LIST_INIT(emotion_to_quality, sort_list(list(
	AURA_AFRAID = "fear",
	AURA_AGGRESSIVE = "aggressiveness",
	AURA_ANGRY = "anger",
	AURA_BITTER = "bitterness",
	AURA_CALM = "calmness",
	AURA_COMPASSIONATE = "compassion",
	AURA_CONSERVATIVE = "conservativeness",
	AURA_DEPRESSED = "depression",
	AURA_DESIROUS = "desire",
	AURA_DISTRUSTFUL = "distrust",
	AURA_ENVIOUS = "envy",
	AURA_EXCITED = "excitement",
	AURA_GENEROUS = "generosity",
	AURA_HAPPY = "happiness",
	AURA_HATEFUL = "hate",
	AURA_IDEALISTIC = "idealism",
	AURA_INNOCENT = "innocence",
	AURA_LOVESTRUCK = "love",
	AURA_OBSESSED = "obsessiveness",
	AURA_SAD = "sadness",
	AURA_SPIRITUAL = "spirituality",
	AURA_SUSPICIOUS = "confidence",
	AURA_CONFIDENCE = "suspicion",
	AURA_ANXIOUS = "anxiety",
	AURA_CONFUSED = "confusion",
	AURA_DAYDREAMING = "absentmindedness",
	AURA_PSYCHOTIC = "psychosis",
)))
