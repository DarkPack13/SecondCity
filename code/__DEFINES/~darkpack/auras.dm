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

// MYTHERCERIA AURAS START HERE // DARKPACK TODO: replace everything commented "placeholder" with real icons. Some will be base_icon_states (i.e. crinos, mage, fae)
#define FAESIGHT_GENERIC "generic" // everything not below
// Splat detectors
// <fera>
#define FAESIGHT_GAROU "brown" // Werewolves // Replace this and other fera with grabbing the mob's breed form (or crinos if in breed form) sprite
#define FAESIGHT_CORAX "black" // Corax // Placeholder - modular_darkpack/modules/npc/icons/corvid.dmi
#define FAESIGHT_KITSUNE "fox" // Kitsune // Placeholder - icons/mob/simple/pets.dmi
#define FAESIGHT_BASTET "cat" // Bastet // Placeholder - icons/mob/simple/pets.dmi
#define FAESIGHT_NUWISHA "bullterrier" // Coyotes // Placeholder - icons/mob/simple/pets.dmi
#define FAESIGHT_GURAHL "bear" // Bears // Placeholder - modular_darkpack/modules/npc/icons/bear.dmi
#define FAESIGHT_MOKOLE "raptor" // Lizards of ALMOST all kinds // Placeholder - icons/mob/simple/lavaland/raptor_big.dmi
#define FAESIGHT_ROKEA "blahaj" // Sharks // Placeholder - icons/obj/toys/plushes.dmi
#define FAESIGHT_ANANASI "tank" // Spoder // Placeholder - icons/mob/simple/arachnoid.dmi
#define FAESIGHT_CAMAZOTZ "bat" // Bats // Placeholder - icons/mob/simple/animal.dmi
#define FAESIGHT_LEPIX "rabbit_white" // Rabbits. Joke fera. // Placeholder - icons/mob/simple/rabbit.dmi
#define FAESIGHT_NAGAH "snake" // Super secret snakes // Placeholder - icons/mob/simple/animal.dmi
#define FAESIGHT_AJABA "pug" // Hyenas // Placeholder - icons/mob/simple/pets.dmi
#define FAESIGHT_RATKIN "regalrat" // Terrorism rats // Placeholder - icons/mob/simple/animal.dmi
#define FAESIGHT_APIS "cow" // Hyper-extinct cows. Useful for spirits maybe. // Placeholder - icons/mob/simple/cows.dmi
#define FAESIGHT_GRONDR "pig" // Hyper-extinct pigs // Placeholder - icons/mob/simple/animal.dmi
#define FAESIGHT_ANURANA "frog" // Mockery frogs // Placeholder - icons/mob/simple/animal.dmi
#define FAESIGHT_KERASI "unicorn" // Mockery rhinos // Placeholder - icons/obj/toys/plushes.dmi
#define FAESIGHT_SAMSA "cockroach" // Mockery roaches <3 <3 <3 // Placeholder - icons/mob/simple/animal.dmi
#define FAESIGHT_WARWOLVES "beast_crinos" // Mockery Garou, like the crinos_beast basic mob - modular_darkpack/modules/npc/icons/werewolf.dmi
#define FAESIGHT_YEREN "monkey" // Mockery apes // Placeholder - icons/mob/human/human.dmi
// </fera>

#define FAESIGHT_MAGE "nim" // mages and some sorcerers - if we ever get mages, replace this with their chosen Avatar // Placeholder - icons/mob/simple/mob.dmi
#define FAESIGHT_FAE "god" // all things fairy (not inculding ourselves) // Placeholder - icons/mob/simple/mob.dmi
#define FAESIGHT_DEMON "slaughter_demon" // DEMON!!! // Placeholder - icons/mob/simple/demon.dmi
#define FAESIGHT_TRUEFAITH "god" // may not need to exist. but whatever. // Placeholder - icons/mob/simple/mob.dmi
#define FAESIGHT_UMBRA "ghost1" // spirits, banes, etc. Replace with actual spirit sprites one day // Placeholder - icons/mob/simple/mob.dmi

GLOBAL_LIST_INIT(fae_sight_auras, sort_list(list(
"Lupine" = FAESIGHT_GAROU,
"Avian" = FAESIGHT_CORAX,
"Vulpine" = FAESIGHT_KITSUNE,
"Feline" = FAESIGHT_BASTET,
"Latran" = FAESIGHT_NUWISHA,
"Ursine" = FAESIGHT_GURAHL,
"Reptilian" = FAESIGHT_MOKOLE,
"Selachian" = FAESIGHT_ROKEA,
"Arachnid" = FAESIGHT_ANANASI,
"Chiropteran" = FAESIGHT_CAMAZOTZ,
"Lagomorph" = FAESIGHT_LEPIX,
"Serpent" = FAESIGHT_NAGAH,
"Hyena" = FAESIGHT_AJABA,
"Rodent" = FAESIGHT_RATKIN,
"Bovine" = FAESIGHT_APIS,
"Porcine" = FAESIGHT_GRONDR,
"Ranine" = FAESIGHT_ANURANA,
"Rhino" = FAESIGHT_KERASI,
"Roach" = FAESIGHT_SAMSA,
"Feral Lupine" = FAESIGHT_WARWOLVES,
"Monkey" = FAESIGHT_YEREN,
"Mage" = FAESIGHT_MAGE,
"Fae" = FAESIGHT_FAE,
"Believer" = FAESIGHT_TRUEFAITH,
"Spiritual" = FAESIGHT_UMBRA,
"Magic" = FAESIGHT_GENERIC,
)))
