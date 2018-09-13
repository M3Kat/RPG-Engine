/// @description Returns all the arguments from a ds list into an array
/// @arg arg_list

#region Temp var

var dslist	= argument0;
var dssize	= ds_list_size(dslist)-1;
var array   = array_create(dssize,-1);

var i;

#endregion

#region Copy arguments

for (i = 0; i < dssize; i++)
{
	array[i] = argument0[| i+1];
}
#endregion

return array;