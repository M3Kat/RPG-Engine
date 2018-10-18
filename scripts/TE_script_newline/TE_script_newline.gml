/// @description Goto new line
index_line++;
index_char = 1;
speed_buffer = 0;

// Don't copy line if after end of text?
if (index_line < ds_list_size(line))
{
	line_copy = line[| index_line];
}
else
{
	line_copy = "";
	finished = true;
}
string_display = "";
char_halign	= fa_left;
ds_list_clear(char_list);
TE_arrayreturn_nodeletion();
pause	   = false;