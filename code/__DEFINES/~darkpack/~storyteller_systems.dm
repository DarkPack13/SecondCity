// In age of release
//#define SYSTEM_WOD_V20
//#define SYSTEM_WOD_V5
//#define SYSTEM_COD

#if !defined(SYSTEM_WOD_V20) && !defined(SYSTEM_WOD_V5) && !defined(SYSTEM_COD)
	#define SYSTEM_WOD_V20 // Default to V20 as its the bible for tfn and commonly used for apoc
#endif

#ifdef SYSTEM_WOD_V20
	#define STORYTELLR_SYSTEM "World of Darkness V20"
#endif

#ifdef SYSTEM_WOD_V5
	#define STORYTELLR_SYSTEM "World of Darkness V5"
#endif

#ifdef SYSTEM_COD
	#define STORYTELLR_SYSTEM "Chronicles of Darnkess"
#endif
