/// @description Exit loop

var bracket;																									// Level of bracket
var brackettmp	= index_bracket;

var i;

for (i = index_line; i >= 0; i--)
{
	// Go inside and outside brackets
	switch (string_char_at(line[| i], 2))
	{
		case "{"	:
			brackettmp--;
			break;
		case "}"	:
			brackettmp++;
			break;
	}
	
	// Set new index_line if there is LOOP command & we're on the same bracket level
	if (string_copy(line[| i], 1, 6) == "%LOOP%" && brackettmp == index_bracket)
	{
		index_line = i;
		TE_script_newline();																					// Skip a line
		break;
	}
}