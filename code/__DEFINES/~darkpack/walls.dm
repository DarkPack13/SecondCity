// Put here to allow downstreams to add subtypes.
#define LOW_WALL_HELPER(wall_type, wall_icon)	\
	/obj/structure/platform/lowwall/##wall_type {	\
		icon = ##wall_icon; \
	}	\
	/obj/structure/platform/lowwall/##wall_type/window {			\
		window = /obj/structure/window/fulltile;		\
		WHEN_MAP(icon = 'modular_darkpack/modules/walls/icons/lowwalls.dmi'); \
		WHEN_MAP(icon_state = "window_spawner"); 		\
	}	\
	/obj/structure/platform/lowwall/##wall_type/window/reinforced { \
		window = /obj/structure/window/reinforced/fulltile; \
	}
