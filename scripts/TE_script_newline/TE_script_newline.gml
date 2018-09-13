/// @description Goto new line
index_line++;
index_char = 1;
speed_buffer = 0;
line_copy = line[| index_line];
string_display = "";
ds_list_clear(char_list);
TE_arrayreturn_nodeletion();
pause	   = false;