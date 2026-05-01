///From /datum/hotspot/perform_exposure()
#define COMSIG_TURF_HOTSPOT_EXPOSE "turf_hotspot_expose"
///From /turf/ignite_turf(): (power, fire_color)
#define COMSIG_TURF_IGNITED "turf_ignited"
	///Prevents hotspots and turf fires
	#define SUPPRESS_FIRE (1<<0)
///From /obj/item/open_flame(): (flame_heat)
#define COMSIG_TURF_OPEN_FLAME "open_flame"
	#define BLOCK_TURF_IGNITION (1<<0)
