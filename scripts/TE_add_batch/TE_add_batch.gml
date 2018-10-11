/// @description Add a dslist inside script content
/// @param textbox_id
/// @param dsmap

#region Temp variables

var txtid = argument0;
var txtds = argument1;

#endregion

with (txtid)
{
	ds_list_copy(line, other.script_map[? txtds]);														// Add new line inside txtid
}