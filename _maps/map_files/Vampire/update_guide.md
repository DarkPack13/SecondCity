# Hello Downstream Mapper!
Are you updating an old map to darkpack?
Here is a little checklist of things to do.

See `tools/UpdatePaths/readme.md` for how to run the updates paths. This will ensure all types are updated to TG.
It also tries its best to fix a few old mapping sins like layer edits, some of which are now linted against in TG.

After you have ran the updates paths, You may find some stuff is still broken. Part of this is the cost for ensuring our updates path is non-volatile
Stuff like chairs, some floor decals, light fixtures, may need to be hand updated due to limitations

There is also a whole host of new things you get to add to maps or changes to how you map.
* Navigate landmarks `/obj/effect/landmark/navigate_destination` to allow people to create paths to areas.
* Telecomms from https://github.com/DarkPack13/SecondCity/pull/432. Either use an `/obj/machinery/telecomms/allinone/public` or hand map telecomms where relevent
* Sprinklers from https://github.com/DarkPack13/SecondCity/pull/78. Areas are now only fire suppresed if you hand place sprinkers `/obj/machinery/sprinkler`
* Doors now have there varibles controlled via helpers, much more visable and reusable from https://github.com/DarkPack13/SecondCity/pull/318 `/obj/effect/mapping_helpers/door`
* A much more robust set of tools for generating random flora or forest. `/area/vtm/planetgeneration` is an area type that randomly generates forest like terrain but you can also use `/turf/open/misc/grass/random` or subtypesof `/obj/effect/spawner/random/flora` for finer control or places you want a specific area type.
