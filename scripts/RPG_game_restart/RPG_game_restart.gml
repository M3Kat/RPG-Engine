/// @description Destroys all data correctly

// Reset surface target
surface_reset_target();

#region NPC Graphics data


#region Sprite Grids

var dsmap = global.actorSpriteMap;
while (!ds_map_empty(dsmap))
{
	var dskey = ds_map_find_first(dsmap);
	ds_map_destroy(dsmap[? dskey]);
	ds_map_delete(dsmap, dskey);
}
ds_map_destroy(dsmap);

#endregion
#region Sprite ID
var dsmap = global.actorSpriteUniqueID;
while (!ds_map_empty(dsmap))
{
	var dskey = ds_map_find_first(dsmap);
	sprite_delete(dsmap[? dskey]);
	ds_map_delete(dsmap, dskey);
}
ds_map_destroy(dsmap);
#endregion

#endregion