package main

import "core:fmt"
import "core:mem"
import "core:os"
import "core:strings"
import "core:unicode"

/*
	every procedure has a context. It inherits the callers context automatically.
	context.allocator contains the procedure (function pointer) & data (pointer to allocator state)
*/

main :: proc() {
	// https://pkg.odin-lang.org/core/mem/#tracking_allocator
	// memory leak warnings
	track: mem.Tracking_Allocator
	mem.tracking_allocator_init(&track, context.allocator)
	context.allocator = mem.tracking_allocator(&track)
	defer {
		for _, leak in track.allocation_map {
			fmt.printf("%v leaked %m\n", leak.location, leak.size)
		}
		mem.tracking_allocator_destroy(&track)
	}


	data, err := os.read_entire_file("input", context.allocator)
	defer delete(data, context.allocator)
	if err != nil {
		return
	}

	dataStr := string(data)
	lines := strings.split_lines(dataStr)
	defer delete(lines, context.allocator)

	coords: [2]int
	for line, y in lines {
		for char, x in line {
			if char == '^' {
				coords = {x, y}
			}
		}
	}

	fmt.println(coords)
}
