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
	/*// Set first line_copy if we setup it first
	if (ds_list_size(line) == 1)
	{
		line_copy = line[|0];																	// Set line_copy to newly created line
	}*/
}