/// @description Copy line text inside strings

#region Temp Variables

var cmdarray;																									// Gets value from TE_execute_script and is used to modify the string

#endregion


// Set speed buffer mode when pressing a button

if (keyboard_check_pressed(vk_space) && !pause)	speed_buffer_mode = _teSpdBufferMode.fast;
if (!keyboard_check(vk_space))					speed_buffer_mode = _teSpdBufferMode.normal;

// New line

switch (box_type)
{
	case _teBoxType.Message	:																				// Textbox is a message
		if (keyboard_check_pressed(vk_space))
		{
			if (pause)
			{
				pause = false;																				// Continue text scroll
			}
			// Is on last char or is child textbox exists?
			if (index_char >= string_length(line[| index_line]) - 1 && !instance_exists(child))
			{
				TE_script_newline();
			}
		}
		break;
	case _teBoxType.Choice	:																				// Textbox is a choice
		if (keyboard_check_pressed(vk_space))
		{
			global.nspDsMap[? "TE_CHOICE"] = cursor_pos;													// Set cursor position to val
			with (parent) TE_script_newline();
			instance_destroy();
		}
		if (keyboard_check_pressed(vk_up))
		{
			cursor_pos--;
			if (cursor_pos < 0) cursor_pos = cursor_options - 1;
		}
		if (keyboard_check_pressed(vk_down))
		{
			cursor_pos++;
			if (cursor_pos >= cursor_options) cursor_pos = 0;
		}
		break;
}	

// Set speed buffer
if (!wait)
{
	if (speed_buffer_mode == _teSpdBufferMode.normal) speed_buffer += index_speed;
	if (speed_buffer_mode == _teSpdBufferMode.fast) speed_buffer += index_speed_fast;
}

// Set line_copy to first line if it's undefined
if (line_copy == undefined && ds_list_size(line) != 0) line_copy = line[| 0];

// New code because I'm such a cuck
if (!pause && !wait && !finished)
{
	// Destroy textbox if on last line
	if (index_line >= ds_list_size(line))
	{
		instance_destroy();
	}
	else
	{
		// Increment number of characters
		while (floor(abs(speed_buffer >= 1)))
		{	
			// Execute script if current character in the index is "%"
			while (string_char_at(line_copy, index_char) == "%" && !pause && !wait)
			{
				// Reset array return before executing script
				arrayreturn = array_create(_teCmdArray.enum_end, undefined);
				// Get command
				arrayreturn = array_create(_teCmdArray.enum_end, 0);
				TE_execute_script(line_copy, index_char);
				if (arrayreturn[_teCmdArray.charDelete] != undefined)	index_char	+= clamp(arrayreturn[_teCmdArray.charDelete], 0, string_length(line_copy));			// Advance current cursor position based on length
				if (arrayreturn[_teCmdArray.charReplace] != undefined)	line_copy	= string_insert(arrayreturn[_teCmdArray.charReplace], line_copy, index_char);		// Insert new string inside text
			}
			
			// Stop loop if waiti{ng
			if (pause || wait > 0)
			{
				speed_buffer = 0;
				break;
			}
			
			// Copy char inside string_display
			var charcopy = string_char_at(line_copy, index_char);												// Copy current character
			var chararray = array_create(_teCharData.enum_end, undefined);										// Create empty data array
			var i = ds_list_size(char_list);																	// Get size of ds list
			
			chararray[_teCharData.character]	= charcopy;														// Copy character
			chararray[_teCharData.font]			= undefined;													// Set font
			chararray[_teCharData.color]		= char_color;													// Set color
			
			
			char_list[| i] = chararray;																			// Insert array into ds list
			
			// Increment char count if not at the end of line. Or ekse pause the textbox
			if (index_char < string_length(line_copy))
			{
				index_char++;
				
				// Play SFX
				audio_stop_sound(text_sound);
				audio_play_sound(text_sound, 25, false);
			}
			else
			{
				pause = true;
				speed_buffer = 0;
				break;
			}
			// Decrement loop
			speed_buffer--;																						// Decrement speed buffer

		}
	}
}
/*if (abs(index_speed_dif) >= 1)
{
	speed_buffer	+= floor(abs(index_speed_dif));																// Increment speed buffer
	index_speed_dif -= floor(abs(index_speed_dif)) * sign(index_speed_dif);										// Reset index speed dif
}
// If textbox is not paused or waiting, continue to draw lines
if (!pause && !wait && !finished)
{
	// If line index is trespassing the maximum lin}e limit, destroy instance
	if (index_line >= ds_list_size(line))
	{
		instance_destroy();	
	}
	else
	{
		// Increment number of characters
		while (floor(abs(speed_buffer)) > 0)
		{
			arrayreturn = 0;
			// Execute script if current character is a "%"
			if (string_char_at(line[| index_line], index_char) == "%")
			{
				arrayreturn = TE_execute_script(line[| index_line], index_char);
		
				if (arrayreturn[_teCmdArray.charDelete] >= 0)
				{
					//line[| index_line] = string_delete(line[| index_line], index_char, cmdarray[_teCmdArray.charDelete]);	// Delete characters
					index_char += arrayreturn[_teCmdArray.charDelete];												// Move the character index
				}
				string_display = string_insert(arrayreturn[_teCmdArray.charReplace], line[| index_line], index_char);	// Insert new string
			}
			
			// Stop loop if waiting
			if (pause || wait)
			{
				speed_buffer = 0;
				break;
			}
	
			// Copy string
			string_display = string_insert(string_char_at(line[| index_line], index_char), string_display, string_length(string_display)+1);
			
			// Stop incrementing the char index if at last line
			if (index_char < string_length(line[| index_line]))
			{
				index_char++;
				speed_buffer--;
			}
			else
			{
				pause = true;
				speed_buffer = 0;
				break;
			}
			
			//Decrement speed buffer
			speed_buffer--;
		}
		// Add speed_buffer decimal to index_speed_dif
		index_speed_dif	+= speed_buffer;
		speed_buffer	= 0;
	}
}
*/
// Decrement wait timer
if (wait > 0) wait--;

// Destroy textbox if finished
if (finished) instance_destroy();