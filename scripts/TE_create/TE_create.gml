/// @description Spawn a texbox inside screen with custom coordinates if needed and returns it's id
/// @param x1
/// @param y1
/// @param x2
/// @param y2


#region Temp variables

var inst	= noone;
var arg		= argument_count;

#endregion

#region Create empty textbox

inst = instance_create_depth(0,0,0,oTE_Message);
// If there is at least 4 arguments, resize text box
if (arg >= 4)
{
	inst.surface_width	= argument[2] - argument[0];														// Set width of textbox
	inst.surface_height	= argument[3] - argument[1];														// Set height of textbox
	inst.surface_x		= argument[0];																		// Set x coordinates of textbox
	inst.surface_y		= argument[1];																		// Set y coordinates of textbox
}

#endregion

return inst;																								// Return ID of textbox