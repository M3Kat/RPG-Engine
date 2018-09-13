/// @description Goto specific tag
/// @arg tag_name
/// @arg no_skip

var tagname		= argument0;
var noskip		= argument1;																					// Do we skip line?
var taglist		= ds_list_create();																				// Get argum

var i;

index_bracket	= 0;																							// Reset index bracket

for (i = 0; i < ds_list_size(line); i++)
{
	// Go inside and outside brackets
	switch (string_char_at(line[| i], 2))
	{
		case "{"	:
			index_bracket++;
			break;
		case "}"	:
			index_bracket--;
			break;
	}
	
	if (string_copy(line[| i], 1, 4) == "%TAG")
	{
		ds_list_clear(taglist);																					// Clear ds list
		TE_get_arguments(taglist, line[| i])																	// Get command from line
		// If tag name is matching, set our line index to new position
		if (taglist[| 1] == tagname)
		{
			index_line = i;
			if (!noskip) TE_script_newline();																	// If no skip is false, skip a line
			break;
		}
	}
}

ds_list_destroy(taglist);