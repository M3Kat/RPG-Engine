/// @description Decode JSON and add it at the end of script DSLIST
/// @arg NPC ID
/// @arg DSMAP
/// @arg JSON String

#region Temp variabes

var _id		= argument0;
var _ds		= argument1;
var jsonname	= argument2;
var jsonmap;
var jsonlist;
var i;

#endregion

#region Insert content

with (_id)
{
	var	_list = script_map[? _ds];
	jsonmap = json_decode_file("scripts/"+jsonname+".json");
	if (jsonmap != -1)
	{
		jsonlist = jsonmap[?"default"];
		for (i = 0; i < ds_list_size(jsonlist); i++)
		{
			ds_list_add(_list, jsonlist[|i]);
		}
		ds_list_destroy(jsonlist);
		ds_map_destroy(jsonmap);
	}
}

#endregion