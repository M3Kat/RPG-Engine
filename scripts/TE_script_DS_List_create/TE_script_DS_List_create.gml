/// @description Create a new ds list inside variable
/// @arg var_name

#region Temp var

var varname	= TE_get_variable(argument0);
var dslist;

#endregion

// Insert dslist inside variable
dslist	= ds_list_create();
TE_set_variable(argument0, dslist);
global.nspDsMap[?"DSL_RETURN"] = dslist;