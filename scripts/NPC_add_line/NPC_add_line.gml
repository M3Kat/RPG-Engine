/// @description Add line to script list
/// @arg NPC ID
/// @arg DSMAP
/// @arg String

#region Temp variabes

var _id = argument0;
var _ds = argument1;
var txt	= argument2;

#endregion

#region Insert content

var _list = script_map[? _ds];
var _size = ds_list_size(_list);
_list[| _size] = txt;

#endregion