/// @description Set new coordinate for text
/// @arg array
/*
The array should contain 1 or 2 arguments

IF CONTAINING 1 ARGUMENT
arg[0] = Char W2

IF CONTAINING 2 ARGUMENTS
arg[0] = Char W1
arg[1] = Char W2
*/

#region Temp variables

var arg1,arg2;
var chararraycopy	= arrayreturn[_teCmdArray.charData];										// Copy array data

#endregion

if (array_length_1d(argument0) == 1)
{
	arg1 = 8;																					// TEMP CHANGE MAGIC NUMBER
	arg2 = real(argument0[@ 0]);
}
else
{
	arg1 = real(argument0[@0]);
	arg2 = real(argument0[@1]);
}
chararraycopy[@_teCharData.setW1]	= arg1;
chararraycopy[@_teCharData.setW2]	= arg2;

//arrayreturn[_teCmdArray.charData]	= chararraycopy;
//charlist