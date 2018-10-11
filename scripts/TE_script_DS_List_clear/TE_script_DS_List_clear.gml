/// @description Clears a ds list inside variable
/// @arg var_name

#region Temp var

var varname	= TE_get_variable(argument0);
var dslist;

#endregion

// Destroy dslist inside variable
ds_list_clear(varname);