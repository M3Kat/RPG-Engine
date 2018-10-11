/// @description Copy line text inside strings

#region Temp Variables

var cmdarray;																								// Gets value from TE_execute_script and is used to modify the string
//var arrayreturn;																							// Data to return from a cmd

#endregion

// Break if instance doesn't exists
if (!instance_exists(id)) return undefined;

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
			audio_play_sound(sfxTE_GUI_Confirm, 50, false);													// Cursor sound
		}
		if (keyboard_check_pressed(vk_up))
		{
			cursor_pos--;
			if (cursor_pos < 0) cursor_pos = cursor_options - 1;
			audio_play_sound(sfxTE_GUI_Cursor, 50, false);													// Cursor sound
		}
		if (keyboard_check_pressed(vk_down))
		{
			cursor_pos++;
			if (cursor_pos >= cursor_options) cursor_pos = 0;
			audio_play_sound(sfxTE_GUI_Cursor, 50, false);													// Cursor sound
		}
		break;
	case _teBoxType.AskReal	:
		if (keyboard_check_pressed(vk_space))
		{
			// Convert individual characters into a string
			var fullstring = "";
			for (var i = 0; i < array_length_1d(ask_char_array); i++)
			{
				fullstring = string_insert(ask_char_array[i], fullstring, i+1);								// Insert character one by one
			}
			global.nspDsMap[? "TE_ASKREAL"] = real(fullstring);												// Convert string into real and insert it inside TE_ASKREAL
			with (parent) TE_script_newline();																// Insert new line
			instance_destroy();
			audio_play_sound(sfxTE_GUI_Confirm, 50, false);													// Cursor sound
		}
		if (keyboard_check_pressed(vk_left))
		{
			cursor_pos--;
			if (cursor_pos < 0) cursor_pos = cursor_options - 1;
			audio_play_sound(sfxTE_GUI_Cursor, 50, false);													// Cursor sound
		}
		if (keyboard_check_pressed(vk_right))
		{
			cursor_pos++;
			if (cursor_pos >= cursor_options) cursor_pos = 0;
			audio_play_sound(sfxTE_GUI_Cursor, 50, false);													// Cursor sound
		}
		if (keyboard_check_pressed(vk_up))
		{
			var numconvert = real(ask_char_array[cursor_pos]);												// Get digit
			numconvert++;																						// Increment value
			if (numconvert > 9) numconvert = 0;															// If over 9, loop back to 0
			ask_char_array[cursor_pos] = string(numconvert);												// Reinsert digit into array
			audio_play_sound(sfxTE_GUI_Cursor, 50, false);													// Cursor sound
		}
		if (keyboard_check_pressed(vk_down))
		{
			var numconvert = real(ask_char_array[cursor_pos]);												// Get digit
			numconvert--;																					// Decrement value
			if (numconvert < 0) numconvert = 9;																// If under 0, loop back to 9
			ask_char_array[cursor_pos] = string(numconvert);												// Reinsert digit into array
			audio_play_sound(sfxTE_GUI_Cursor, 50, false);													// Cursor sound
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
if (ds_exists(line, ds_type_list))
{
	if (line_copy == undefined && ds_list_size(line) != 0) line_copy = line[| 0];
}

// New code because I'm such a cuck
if (!pause && !wait && !finished && instance_exists(id))
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
			// Reset array return before executing script
			arrayreturn = array_create(_teCmdArray.enum_end, undefined);
			arrayreturn[_teCmdArray.charData] = array_create(_teCharData.enum_end, undefined);
			// Execute script if current character in the index is "%"
			while (string_char_at(line_copy, index_char) == "%" && !pause && !wait && arrayreturn[_teCmdArray.skipNextCmd] != true)
			{
				// Get command
				arrayreturn = TE_execute_script(line_copy, index_char);
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
			var chararray = arrayreturn[_teCmdArray.charData];													// Copy data array
			var i = ds_list_size(char_list);																	// Get size of ds list
			
			if (chararray[_teCharData.character] == undefined) chararray[_teCharData.character]	= charcopy;		// Copy character
			chararray[_teCharData.font]			= undefined;													// Set font
			chararray[_teCharData.color]		= char_color;													// Set color
			chararray[_teCharData.halign]		= char_halign;													// Set halign
			
			char_list[| i] = chararray;																			// Insert array into ds list
			
			// Increment char count if not at the end of line. Or ekse pause the textbox
			if (index_char < string_length(line_copy))
			{
				// Do we skip next cmd
				if (arrayreturn[_teCmdArray.skipNextCmd] != true)
				{
					index_char++;
					
					// Play SFX
					audio_stop_sound(text_sound);
					audio_play_sound(text_sound, 25, false);
				}
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

// Decrement wait timer
if (wait > 0) wait--;

// Destroy textbox if finished
if (finished) instance_destroy();