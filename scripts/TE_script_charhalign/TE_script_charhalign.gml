/// @description Set halign variable to the textbox
/// @arg fa_left||fa_right

#region Temp variables

var fa = argument0

#endregion

#region Set variable

switch (fa)
{
	case "fa_right"	:
		char_halign	= fa_right;
		break;
	default	:
		char_halign = fa_left;
}
#endregion