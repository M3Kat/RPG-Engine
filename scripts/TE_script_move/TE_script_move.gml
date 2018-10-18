/// @description Move (and resize) location of textbox
/// @arg cmdarray(x,y,[x2,y2])

#region Temp variables

var x1 = real(argument0[@0]);
var y1 = real(argument0[@1]);
var x2 = undefined;
var y2 = undefined;

#endregion

// Move textbox
surface_x	= x1;
surface_y	= y1;

// Resize if fit
if (array_length_1d(argument0) > 3)
{
	x2	= real(argument0[@2]);
	y2	= real(argument0[@3]);
	
	surface_width	= x2-x1;
	surface_height	= y2-y1;
}