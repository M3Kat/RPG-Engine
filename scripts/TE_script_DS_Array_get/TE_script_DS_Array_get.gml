/// @description Get a value inside array
/// @arg var_name
/// @arg index

#region Temp var

var varname	= TE_get_variable(argument0);
var dspos	= real(argument1);
var dsarray;

#endregion

// Copy value of DS_Array inside DS_RETURN
global.nspDsMap[?"DSA_RETURN"] = varname[@ dspos];