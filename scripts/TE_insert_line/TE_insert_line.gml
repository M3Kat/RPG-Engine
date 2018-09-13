/// @description Insert new line at specific position inside the textbox
/// @param textbox_id
/// @param index_line
/// @param line

#region Temp variables

var txtid	= argument0;
var linenum	= argument1;
var txtln	= argument2;

#endregion

with (txtid)
{
	ds_list_insert(line, linenum, txtln);														// Insert new line inside
}