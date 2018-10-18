/// @description Add a dslist inside script content
/// @param textbox_id
/// @param jsonname

/*
#region Temp variables

var txtid = argument0;
var txtds = argument1;

#endregion

with (txtid)
{
	ds_list_copy(line, other.script_map[? txtds]);														// Add new line inside txtid
}*/
#region Temp variabes

var _id		= argument0;
var jsonname	= argument1;
var jsonmap;
var jsonlist;
var i;

#endregion

#region Insert content

with (_id)
{
	var	_list = _id.line;
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