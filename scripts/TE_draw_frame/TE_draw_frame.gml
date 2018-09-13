/// @description Draws a frame around the textbox

#region Temp variables

var s_id		= sTE_BorderA;
var s_width		= sprite_get_width(s_id);
var s_height	= sprite_get_height(s_id);

var x1			= 0;
var x2			= surface_width - s_width;
var y1			= 0;
var y2			= surface_height - s_height;

#endregion

#region DRAW SHIT

// Draw corners
draw_sprite(s_id, 0, x1, y1);																				// Up-left
draw_sprite(s_id, 2, x2, y1);																				// Up-right
draw_sprite(s_id, 6, x1, y2);																				// Down-left
draw_sprite(s_id, 8, x2, y2);																				// Down-right

// Draw lines


draw_sprite_pos(s_id, 1, x1+s_width, y1, x2, y1, x2, y1+s_height, x1+s_width, y1+s_height, 1);
draw_sprite_pos(s_id, 7, x1+s_width, y2, x2, y2, x2, y2+s_height, x1+s_width, y2+s_height, 1);
draw_sprite_pos(s_id, 3, x1, y1+s_height, x1+s_width, y1+s_height, x1+s_width, y2, x1, y2, 1);
draw_sprite_pos(s_id, 5, x2, y1+s_height, x2+s_width, y1+s_height, x2+s_width, y2, x2, y2, 1);

//draw_sprite_stretched(s_id, 1, x1+s_width, y1, stretch_w, 1);												// Up
//draw_sprite_stretched(s_id, 7, x1+s_width, y2, stretch_w, 1);												// Down
//draw_sprite_stretched(s_id, 3, x1, y1+s_height, 1, stretch_h);											// Left
//draw_sprite_stretched(s_id, 5, x2, y2+s_height, 1, stretch_h);											// Right
#endregion