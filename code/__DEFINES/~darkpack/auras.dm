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
#define AURA_INNOCENT COLOR_OFF_WHITE // White
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
#define AURA_WEREBEAST (FALSE) // Bright, vibrant aura // WEREWOLF
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
	"Psychotic" = AURA_PSYCHOTIC
)))

GLOBAL_LIST_INIT(emotion_to_quality, sort_list(list(
	"Afraid" = "fear",
	"Aggressive" = "aggressiveness",
	"Angry" = "anger",
	"Bitter" = "bitterness",
	"Calm" = "calmness",
	"Compassionate" = "compassion",
	"Conservative" = "conservativeness",
	"Depressed" = "depression",
	"Desirous" = "desire",
	"Distrustful" = "distrust",
	"Envious" = "envy",
	"Excited" = "excitement",
	"Generous" = "generosity",
	"Happy" = "happiness",
	"Hateful" = "hate",
	"Idealistic" = "idealism",
	"Innocent" = "innocence",
	"Lovestruck" = "love",
	"Obsessed" = "obsessiveness",
	"Sad" = "sadness",
	"Spiritual" = "spirituality",
	"Suspicious" = "suspicion",
	"Anxious" = "anxiety",
	"Confused" = "confusion",
	"Daydreaming" = "absentmindedness",
	"Psychotic" = "psychosis"
)))

// MYTHERCERIA AURAS START HERE // DARKPACK TODO: replace everything commented "placeholder" with real icons. Some will be base_icon_states (i.e. crinos, mage, fae)
#define FAE_SIGHT_GENERIC "generic" // everything not below
// Splat detectors
// <fera>
#define FAE_SIGHT_GAROU "garou" // Werewolves // Replace this and other fera with grabbing the mob's breed form (or crinos if in breed form) sprite
#define FAE_SIGHT_CORAX "corax" // Corax // Placeholder - black - modular_darkpack/modules/npc/icons/corvid.dmi
#define FAE_SIGHT_KITSUNE "kitsune" // Kitsune // Placeholder - fox - icons/mob/simple/pets.dmi
#define FAE_SIGHT_BASTET "bastet" // Bastet // Placeholder - cat - icons/mob/simple/pets.dmi
#define FAE_SIGHT_NUWISHA "nuwisha" // Coyotes // Placeholder - bullterrier - icons/mob/simple/pets.dmi
#define FAE_SIGHT_GURAHL "gurahl" // Bears // Placeholder - bear - modular_darkpack/modules/npc/icons/bear.dmi
#define FAE_SIGHT_MOKOLE "mokole" // Lizards of ALMOST all kinds // Placeholder - young_green - icons/mob/simple/lavaland/raptor_big.dmi
#define FAE_SIGHT_ROKEA "rokea" // Sharks // Placeholder - blahaj - icons/obj/toys/plushes.dmi
#define FAE_SIGHT_ANANASI "ananasi" // Spoder // Placeholder - tank - icons/mob/simple/arachnoid.dmi
#define FAE_SIGHT_CAMAZOTZ "camazotz" // Bats // Placeholder - bat - icons/mob/simple/animal.dmi
#define FAE_SIGHT_LEPIX "lepix" // Rabbits. Joke fera. // Placeholder - rabbit_white - icons/mob/simple/rabbit.dmi
#define FAE_SIGHT_NAGAH "nagah" // Super secret snakes // Placeholder - snake - icons/mob/simple/animal.dmi
#define FAE_SIGHT_AJABA "ajaba" // Hyenas // Placeholder - pug - icons/mob/simple/pets.dmi
#define FAE_SIGHT_RATKIN "ratkin" // Terrorism rats // Placeholder - regalrat - icons/mob/simple/animal.dmi
#define FAE_SIGHT_APIS "apis" // Hyper-extinct cows. Useful for spirits maybe. // Placeholder - cow - icons/mob/simple/cows.dmi
#define FAE_SIGHT_GRONDR "grondr" // Hyper-extinct pigs // Placeholder - pig - icons/mob/simple/animal.dmi
#define FAE_SIGHT_ANURANA "anurana" // Mockery frogs // Placeholder - frog - icons/mob/simple/animal.dmi
#define FAE_SIGHT_KERASI "kerasi" // Mockery rhinos // Placeholder - unicorn - icons/obj/toys/plushes.dmi
#define FAE_SIGHT_SAMSA "samsa" // Mockery roaches <3 <3 <3 // Placeholder - cockroach - icons/mob/simple/animal.dmi
#define FAE_SIGHT_WARWOLF "warwolf" // Mockery Garou, like the crinos_beast basic mob // Placeholder - beast_crinos - modular_darkpack/modules/npc/icons/werewolf.dmi
#define FAE_SIGHT_YEREN "yeren" // Mockery apes // Placeholder - monkey - icons/mob/human/human.dmi
// </fera>

#define FAE_SIGHT_MAGE "mage" // mages and some sorcerers - if we ever get mages, replace this with their chosen Avatar // Placeholder - nim - icons/mob/simple/mob.dmi
#define FAE_SIGHT_FAE "fae" // all things fairy (not inculding ourselves) // Placeholder - god - icons/mob/simple/mob.dmi
#define FAE_SIGHT_DEMON "demon" // DEMON!!! // Placeholder - slaughter_demon - icons/mob/simple/demon.dmi
#define FAE_SIGHT_TRUEFAITH "truefaith" // may not need to exist. but whatever. // Placeholder - ghostking - icons/mob/simple/mob.dmi
#define FAE_SIGHT_UMBRA "umbra" // spirits, banes, etc. Replace with actual spirit sprites one day // Placeholder - ghost1 - icons/mob/simple/mob.dmi

GLOBAL_LIST_INIT(fae_sight_auras, sort_list(list(
"Lupine" = FAE_SIGHT_GAROU,
"Avian" = FAE_SIGHT_CORAX,
"Vulpine" = FAE_SIGHT_KITSUNE,
"Feline" = FAE_SIGHT_BASTET,
"Latran" = FAE_SIGHT_NUWISHA,
"Ursine" = FAE_SIGHT_GURAHL,
"Reptilian" = FAE_SIGHT_MOKOLE,
"Selachian" = FAE_SIGHT_ROKEA,
"Arachnid" = FAE_SIGHT_ANANASI,
"Chiropteran" = FAE_SIGHT_CAMAZOTZ,
"Lagomorph" = FAE_SIGHT_LEPIX,
"Serpent" = FAE_SIGHT_NAGAH,
"Hyena" = FAE_SIGHT_AJABA,
"Rodent" = FAE_SIGHT_RATKIN,
"Bovine" = FAE_SIGHT_APIS,
"Porcine" = FAE_SIGHT_GRONDR,
"Ranine" = FAE_SIGHT_ANURANA,
"Rhino" = FAE_SIGHT_KERASI,
"Roach" = FAE_SIGHT_SAMSA,
"Feral Lupine" = FAE_SIGHT_WARWOLF,
"Monkey" = FAE_SIGHT_YEREN,
"Mage" = FAE_SIGHT_MAGE,
"Fae" = FAE_SIGHT_FAE,
"Demonic" = FAE_SIGHT_DEMON,
"Believer" = FAE_SIGHT_TRUEFAITH,
"Spiritual" = FAE_SIGHT_UMBRA,
"Magic" = FAE_SIGHT_GENERIC,
)))
