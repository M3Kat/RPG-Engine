/// @description Draw textbox
// You can write your code in this editor

event_user(0);																									// TEMP RESIZE SURFACE
surface_set_target(surface);																					// Set target to textbox surface
draw_rectangle_color(0, 0, surface_width, surface_height, $ff8822, $ff6611, $aa6622, $aa6611, false);
//draw_text_ext(0,0,string_display, 16, surface_width);															// Draw string inside surface
#region Draw border

	TE_draw_frame();

#endregion


#region Draw text

	#region Temp variables

	var swidth	= 8;																							// Current width
	var sheight = 8;
	var slength = ds_list_size(char_list);																		// Size of dslist 
	
	var c_array;																								// Array containing character data
	var c_char;
	var c_font;
	var c_color;
	
	var f_width = 0;																							// Width of face sprite
	var f_side	= face_side;
	var f_flip	= face_hflip;

	var i;
	
	#endregion
	
	// Draw face
	if (!is_undefined(face_sprite))
	{
		f_width = sprite_get_width(face_sprite);
		if (f_side == 0)
		{
			if (f_flip == 0)
			{
				draw_sprite_ext(face_sprite, face_subsprite, 0, 0, 1, 1, 0, c_white, 1);
			}
			else
			{
				draw_sprite_ext(face_sprite, face_subsprite, f_width, 0, -1, 1, 0, c_white, 1);
				
			}
		}
		else
		{
			if (f_flip == 0)
			{
				draw_sprite_ext(face_sprite, face_subsprite, surface_width-f_width, 0, 1, 1, 0, c_white, 1);
			}
			else
			{
				draw_sprite_ext(face_sprite, face_subsprite, surface_width, 0, -1, 1, 0, c_white, 1);
				
			}
		}
	}
	
	for (i = 0; i < slength; i++)
	{
		// Get character data
		c_array = char_list[| i];
		c_char	= c_array[_teCharData.character];																// Copy character
		c_font	= c_array[_teCharData.font];																	// Copy font
		c_color	= c_array[_teCharData.color];																	// Copy color
		
		// If total width is over surface width, roll back and go to new line
		if (swidth >= surface_width - f_width - 8 || c_char == "\n")
		{
			swidth = 8;
			sheight += TE_CHAR_HEIGHT;
		}
		// Draw character
		switch (f_side)
		{
			case 0	:
				draw_text_color(swidth + f_width , sheight, c_char, c_color,c_color,c_color,c_color, 1);
				break;
			case 1	:
				draw_text_color(swidth , sheight, c_char, c_color,c_color,c_color-$444444,c_color-$444444, 1);
				break;
		}
		
		
		// Add up width
		swidth += string_width(c_char);
	}

#endregion

if (box_type == _teBoxType.Message && !instance_exists(child) && pause)
{
	draw_sprite(TE_Cursor_Down, image_index, surface_width / 2, surface_height - 8);
}
if (box_type == _teBoxType.Choice)
{
	draw_set_color($ffffff);
	draw_rectangle(8,TE_CHAR_HEIGHT*(cursor_pos)+8,surface_width-1-8,TE_CHAR_HEIGHT*(cursor_pos+1)-1+8, true);
}
surface_reset_target();																							// Return to application surface
draw_surface(surface, surface_x, surface_y);																	// Draw surface