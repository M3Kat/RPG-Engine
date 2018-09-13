/// @description Skips bracket

var tmp_bracket	= index_bracket;
var tmp_line	= index_line;

var i;

for (i = tmp_line + 1; i < ds_list_size(line); i++)
{
	switch (string_char_at(line[| i], 2))
	{
		case "{" :
			tmp_bracket++;
			break;
		case "}" :
			tmp_bracket--;
			break;
	}
	if (tmp_bracket == index_bracket)
	{
		index_line = i;
		break;
	}
}
TE_script_newline();