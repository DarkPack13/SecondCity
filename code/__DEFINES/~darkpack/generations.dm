/**
 * Generation defines
 * Higher = weaker
 * Lower = stronger
 */

/// Limit for highest generation possible, Based off V20 Beckket's Jyhad Diary
#define HIGHEST_GENERATION_LIMIT 16
/// Limit for lowest generation possible
#define LOWEST_GENERATION_LIMIT 1
/// Limit for lowest public generation
#define MAX_PUBLIC_GENERATION 10
/// Limit for lowest trusted player generation
#define MAX_TRUSTED_GENERATION 8
/// The default generation every kindred begins at
#define DEFAULT_GENERATION 13
// The generation a ghoul is. This is purely so that ghouls can use disciplines on humans only.
#define GHOUL_GENERATION HIGHEST_GENERATION_LIMIT + 1
// The generation a human is.
#define HUMAN_GENERATION GHOUL_GENERATION + 1
// The lowest generation that anyone using Blood of Potency can go down to.
#define BLOOD_POTENCY_GENERATION 4

//Rank definitions.

#define MAX_PUBLIC_RANK 4
#define MAX_TRUSTED_RANK 5
#define MINIMUM_LUPUS_ATHRO_AGE 7
#define MINIMUM_ATHRO_AGE 21
#define MINIMUM_LUPUS_ELDER_AGE 15
#define MINIMUM_ELDER_AGE 30
