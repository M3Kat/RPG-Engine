/// @description Set new color for text
/// @arg array
/*
The array should contain 1 or 3 arguments

IF CONTAINING 1 ARGUMENT
arg[0] = name of color

IF CONTAINING 3 ARGUMENTs
arg[0] = red
arg[1] = green
arg[2] = blue
*/

#region Temp variables

var arg1,arg2,arg3;
var result = $ffffff;

#endregion


if (array_length_1d(argument0) == 1)
{
	arg1 = argument0[@ 0];
	switch (arg1)
	{
		case "c_white" :
			result = $ffffff;
			break;
		case "c_red" :
			result = $0000ff;
			break;
		case "c_green" :
			result = $00ff00;
			break;
		case "c_blue" :
			result = $ff0000;
			break;
		case "c_yellow" :
			result = $00ffff;
			break;
		case "c_cyan" :
			result = $ffff00;
			break;
		case "c_purple" :
			result = $ff00ff;
			break;
		case "c_black" :
			result = $000000;
			break;
		default			:
			result = $ffffff;
	}
}
else
{
	arg1 = real(argument0[@0]);
	arg2 = real(argument0[@1]);
	arg3 = real(argument0[@2]);
	
	result = make_color_rgb(arg1, arg2, arg3);
}
char_color	= result;