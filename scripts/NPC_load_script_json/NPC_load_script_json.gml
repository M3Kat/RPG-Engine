/// @description Decode JSON and put it inside script DSLIST
/// @arg NPC ID
/// @arg DSMAP
/// @arg JSON String

#region Temp variabes

var _id		= argument0;
var _ds		= argument1;
var jsonname	= argument2;

#endregion

#region Insert content
/*
var _list = script_map[? _ds];
var _size = ds_list_size(_list);
_list[| _size] = txt;*/
ds_list_destroy(script_map[? _ds]);
script_map[? _ds] = json_decode_file("scripts/"+jsonname);

#endregion