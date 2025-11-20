/// Create colored subtypes for BENCHES
#define COLORED_BENCH(path, color_name, bench_color) \
path/middle/color_name {\
	color = bench_color; \
} \
path/right/color_name {\
	color = bench_color; \
} \
path/left/color_name {\
	color = bench_color; \
} \
path/corner/color_name {\
	color = bench_color; \
}

//Icons by -Jay- (hyphenjayhyphen) 7/30/25

/obj/structure/chair/sofa/bench/wood
	name = "bench"
	desc = "A comfy wooden bench."
	icon_state = "wood"
	icon = 'modular_darkpack/modules/decor/icons/bench.dmi'

/obj/structure/chair/sofa/bench/wood/left
	icon_state = "wood_left"

/obj/structure/chair/sofa/bench/wood/right
	icon_state = "wood_right"

/obj/structure/chair/sofa/bench/metal
	name = "metal bench"
	desc = "An uncomfortable metal bench."
	icon_state = "metal"

/obj/structure/chair/sofa/bench/metal/left
	icon_state = "metal_left"

/obj/structure/chair/sofa/bench/metal/right
	icon_state = "metal_right"

COLORED_BENCH(/obj/structure/chair/sofa/bench/metal, black, COLOR_ALMOST_BLACK)
COLORED_BENCH(/obj/structure/chair/sofa/bench/metal, yellow, "#af7d28")
COLORED_BENCH(/obj/structure/chair/sofa/bench/metal, blue, COLOR_TRAM_BLUE)
COLORED_BENCH(/obj/structure/chair/sofa/bench/metal, puce, "#cc8899") // TODO: Puce #94055

#undef COLORED_BENCH
