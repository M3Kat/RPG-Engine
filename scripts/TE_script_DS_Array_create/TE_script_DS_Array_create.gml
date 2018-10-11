/// @description Creates a new array inside variable
/// @arg var_name
/// @arg array_size

#region Temp var

var varname	= TE_get_variable(argument0);
var dsarray;
var dssize	= real(argument1);

#endregion

// Insert dslist inside variable
dsarray	= array_create(dssize, undefined);
TE_set_variable(argument0, dsarray);
global.nspDsMap[?"DSA_RETURN"] = dsarray;