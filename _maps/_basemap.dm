//#define LOWMEMORYMODE //uncomment this to load centcom and runtime station and thats it.
//#define SHOW_INVENTORY_ICONS //uncomment this to make mapping software use inventory icons rather then world icons

#include "map_files\generic\CentCom.dmm"

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS
		// DARKPACK EDIT CHANGE START
		#include "map_files\Vampire\runtimetown.dmm"
		#include "map_files\debug\multiz.dmm"
		#include "map_files\debug\runtimestation.dmm"
		// DARKPACK EDIT CHANGE END
	#endif
	#ifdef ALL_TEMPLATES
		#include "templates.dm"
	#endif
#endif
