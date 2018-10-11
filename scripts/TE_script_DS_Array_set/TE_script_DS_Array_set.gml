/// @description Get a value inside array
/// @arg var_name
/// @arg index
/// @arg value

#region Temp var

var varname	= TE_get_variable(argument0);
var dsindex	= real(argument1);
var dsval	= TE_get_variable(argument2);

#endregion

// Set value of DS_List on specific index
varname[@dsindex] = dsval;