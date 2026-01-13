// Defines for Species IDs. Used to refer to the name of a species, for things like bodypart names or species preferences.
#define SPECIES_KINDRED "kindred"
#define SPECIES_GHOUL "ghoul"
#define SPECIES_GAROU "garou"

/// Health level where mobs who can Torpor will actually die
#define HEALTH_THRESHOLD_TORPOR_DEAD -200

#define isavatar(A) (istype(A, /mob/living/basic/avatar))
#define iszomboid(A) (istype(A, /mob/living/basic/zombie) || (istype(A, /mob/living/basic/beastmaster/giovanni_zombie)))

// DARKPACK TODO - implement other splats
#define isgarou(A) (FALSE)

#define iswerewolf(A) (FALSE)
#define iscrinos(A) (FALSE)
#define islupus(A) (FALSE)

#define iscorax(A) (FALSE)
#define iscorvid(A) (FALSE)
#define iscoraxcrinos(A) (FALSE)


#define isnpc(A) (istype(A, /mob/living/carbon/human/npc))

#define INCORPOREAL_MOVE_AVATAR 4 // Avatar incorporeal movement
