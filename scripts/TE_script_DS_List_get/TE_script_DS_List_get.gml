/// @description Get a value inside dslist
/// @arg var_name
/// @arg index

#region Temp var

var varname	= TE_get_variable(argument0);
var dspos	= real(argument1);
var dslist;

#endregion

// Copy value of DS_List inside DSL_RETURN
global.nspDsMap[?"DSL_RETURN"] = ds_list_find_value(varname, dspos);