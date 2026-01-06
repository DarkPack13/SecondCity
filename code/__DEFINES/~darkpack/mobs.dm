// Defines for Species IDs. Used to refer to the name of a species, for things like bodypart names or species preferences.
#define SPECIES_KINDRED "kindred"
#define SPECIES_GHOUL "ghoul"
#define SPECIES_FERA "fera" // Generic transformable species. Used for things like Corax and Garou. Not intended as a playable species.
#define SPECIES_GAROU "garou"
#define SPECIES_ALL list(SPECIES_HUMAN, SPECIES_KINDRED, SPECIES_GHOUL, SPECIES_FERA, SPECIES_GAROU)
// #define SPECIES_CORAX "corax" // DARKPACK TODO - CORAX

/// Health level where mobs who can Torpor will actually die
#define HEALTH_THRESHOLD_TORPOR_DEAD -200

#define isavatar(A) (istype(A, /mob/living/basic/avatar))
#define iszomboid(A) (istype(A, /mob/living/basic/zombie) || (istype(A, /mob/living/basic/beastmaster/giovanni_zombie)))

#define isshifted(A) (istype(A, /mob/living/carbon/human/fera))
//homid
#define ishomid(A) (istype(A, /mob/living/carbon/human) && (is_species(A, /datum/species/human/shifter/garou)))
//bestial
#define isglabro(A) (istype(A, /mob/living/carbon/human/fera/glabro))
//war
#define iscrinos(A) (istype(A, /mob/living/carbon/human/fera/crinos))
//dire
#define ishispo(A) (istype(A, /mob/living/carbon/human/fera/hispo))
//feral
#define islupus(A) (istype(A, /mob/living/carbon/human/fera/lupus))


#define isnpc(A) (istype(A, /mob/living/carbon/human/npc))

#define INCORPOREAL_MOVE_AVATAR 4 // Avatar incorporeal movement
