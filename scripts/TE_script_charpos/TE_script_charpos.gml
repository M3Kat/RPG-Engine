/// @description Set new coordinate for text
/// @arg array
/*
The array should contain 1 or 2 arguments

IF CONTAINING 1 ARGUMENT
arg[0] = Char X

IF CONTAINING 2 ARGUMENTS
arg[0] = Char X
arg[1] = Char Y
*/

#region Temp variables

var arg1,arg2;
var chararraycopy	= char_list[| char_index];

#endregion


if (array_length_1d(argument0) == 1)
{
	arg1 = argument0[@ 0];
	arg2 = -1;
}
else
{
	arg1 = real(argument0[@0]);
	arg2 = real(argument0[@1]);
}
chararraycopy[_teCharData.setX]	= arg1;
chararraycopy[_teCharData.setY]	= arg2;

//charlist