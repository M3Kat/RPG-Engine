/// @description Add a value inside dslist
/// @arg var_name
/// @arg value

#region Temp var

var varname	= TE_get_variable(argument0);
var dsval	= TE_get_variable(argument1);

#endregion

// Set value of DS_List on specific index
ds_list_add(varname, dsval);