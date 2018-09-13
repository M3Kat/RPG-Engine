/// @description Add a new line inside the textbox
/// @param textbox_id
/// @param line

#region Temp variables

var txtid = argument0;
var txtln = argument1;

#endregion

with (txtid)
{
	ds_list_add(line, txtln);																	// Add new line inside txtid
}