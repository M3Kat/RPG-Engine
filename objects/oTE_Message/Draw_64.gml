/// @description Draw textbox
// You can write your code in this editor

TE_create_surface();																							// Recreate surface incase it's gone
event_user(0);																									// TEMP RESIZE SURFACE
surface_set_target(surface);																					// Set target to textbox surface
draw_rectangle_color(0, 0, surface_width, surface_height, $ff8822, $ff6611, $aa6622, $aa6611, false);
//draw_text_ext(0,0,string_display, 16, surface_width);															// Draw string inside surface
#region Draw border

	TE_draw_frame();

#endregion


#region Draw text

	#region Temp variables

	var swidth	= TE_BORDER_SIZE;																							// Current width
	var sheight = TE_BORDER_SIZE;
	var slength = ds_list_size(char_list);																		// Size of dslist 
	
	var swidthx1	= TE_BORDER_SIZE;
	var swidthx2	= surface_width - TE_BORDER_SIZE;
	
	var c_array;																								// Array containing character data
	var c_char;
	var c_font;
	var c_color;
	var c_halign;																								// How we draw character
	
	var f_width = 0;																							// Width of face sprite
	var f_side	= face_side;
	var f_flip	= face_hflip;

	var i;
	
	#endregion
	
	#region Normal Message & Choice
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
		c_array		= char_list[| i];
		c_char		= c_array[_teCharData.character];															// Copy character
		c_font		= c_array[_teCharData.font];																// Copy font
		c_color		= c_array[_teCharData.color];																// Copy color
		c_halign	= c_array[_teCharData.halign];																// Copy halignment
		
		// Set new character index if it contains data
		if (c_array[_teCharData.setX] != undefined)
		{
			swidth = c_array[_teCharData.setX];
		}
		if (c_array[_teCharData.setY] != undefined)
		{
			sheight = c_array[_teCharData.setY];
		}
		
		// Set new widtd if it contains data
		if (c_array[_teCharData.setW1] != undefined)
		{
			swidthx1 = c_array[_teCharData.setW1];
		}
		if (c_array[_teCharData.setW2] != undefined)
		{
			swidthx2 = c_array[_teCharData.setW2];
		}
		
		// If char width < widthx1
		if (swidth < swidthx1 && c_halign != fa_right) swidth = swidthx1;
		
		if (swidth > swidthx2 && c_halign == fa_right) swidth = swidthx2;
		
		// If character is overlapping left border, advance char by 8
		if (swidth < TE_BORDER_SIZE)	swidth = TE_BORDER_SIZE;
		if (sheight < TE_BORDER_SIZE)	sheight = TE_BORDER_SIZE;
		if (c_halign == fa_right && swidth >= surface_width - TE_BORDER_SIZE)
		{
			swidth = surface_width - TE_BORDER_SIZE;
		}
		
		if (c_halign != fa_right)
		{
			// If total width is over surface width, roll back and go to new line
			if (swidth >= swidthx2 - f_width || c_char == "\n")
			{
				swidth = swidthx1;
				sheight += TE_CHAR_HEIGHT;
			}
		}
		else
		{
			// If halign is from right to left and threspassing widthx1, roll back to widthx2
			if (swidth < swidthx1 - f_width || c_char == "\n")
			{
				swidth = swidthx2;
				sheight += TE_CHAR_HEIGHT;
			}
		}
		
		// Draw character
		var swidthmod = 0;																						// If halign is from right to left, move begining of character to the left
		if (c_halign == fa_right) swidthmod = string_width(c_char);
		switch (f_side)
		{
			case 0	:
				draw_text_color(swidth + f_width - swidthmod , sheight, c_char, c_color,c_color,c_color,c_color, 1);
				break;
			case 1	:
				draw_text_color(swidth - swidthmod , sheight, c_char, c_color,c_color,c_color-$444444,c_color-$444444, 1);
				break;
		}
		
		// Add up width
		if (c_halign != fa_right)
		{
			swidth += string_width(c_char);
		}
		else
		{
			swidth -= string_width(c_char);
		}
		
		
	}
	#endregion
	
	#region Ask Real
	
	if (box_type = _teBoxType.AskReal)
	{
		for (i = 0; i < array_length_1d(ask_char_array); i++)
		{
			c_char	= ask_char_array[i];
			draw_text(TE_BORDER_SIZE+i*TE_CHAR_HEIGHT,TE_BORDER_SIZE,c_char);
		}
	}
	
	#endregion
	
#endregion
	

if (box_type == _teBoxType.Message && !instance_exists(child) && pause)
{
	draw_sprite(sTE_Cursor_Down, image_index, surface_width / 2, surface_height - 8);
}
if (box_type == _teBoxType.Choice)
{
	draw_set_color($ffffff);
	draw_rectangle(8,TE_CHAR_HEIGHT*(cursor_pos)+8,surface_width-1-TE_BORDER_SIZE,TE_CHAR_HEIGHT*(cursor_pos+1)-1+8, true);
}
if (box_type == _teBoxType.AskReal)
{
	draw_set_color($ffffff);
	draw_rectangle(TE_CHAR_HEIGHT*cursor_pos+TE_BORDER_SIZE-4,TE_BORDER_SIZE-4,TE_CHAR_HEIGHT*(cursor_pos+1)-1+TE_BORDER_SIZE-4,TE_CHAR_HEIGHT+TE_BORDER_SIZE, true);
}
surface_reset_target();																												// Return to application surface

var ssw = surface_width * surface_stretch_w;																						// Stretch w
var ssh = surface_height * surface_stretch_h;																						// Stretch h

draw_surface_stretched(surface, surface_x, surface_y, ssw, ssh);																	// Draw surface