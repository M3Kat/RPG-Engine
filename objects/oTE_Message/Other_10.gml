/// @description Resize textbox surface
surface_resize(surface, surface_width, surface_height);									// Set new size for text box
surface_set_target(surface);															// Switch to textbox surface
draw_clear_alpha($000000, 1);															// Fill area with black
surface_reset_target();																	// Return to application surface