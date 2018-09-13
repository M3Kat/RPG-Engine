/// @description Set the face to display inside textbox

#region Temp variables

var vsprite	= asset_get_index(argument0);
var vframe	= real(argument1);

#endregion

if (!is_undefined(vsprite))
{
	face_sprite		= vsprite;
	face_subsprite	= vframe;
}