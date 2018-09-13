/// @description Goto start of current loop

var bracket;																									// Level of bracket
var brackettmp	= index_bracket;

var i;

for (i = index_line; i < ds_list_size(line); i++)
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
	
	// Set new index_line if we find LOOPEND
	if (string_copy(line[| i], 1, 8) == "%LOOPEND")
	{
		index_line = i;
		TE_script_newline();																					// Skip a line
		break;
	}
}