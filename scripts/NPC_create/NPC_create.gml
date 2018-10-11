/// @description Create a new NPC

sprite_grid			= ds_grid_create(_npcAnimState.enum_end, _npcOrientation.enum_end);

script_map			= ds_map_create();

// TEMP SPRITES (SET ALL TO ALEX)
var i,j;
var arraycopy;
for (i = 0; i < _npcAnimState.enum_end; i++)
{
	for (j = 0; j < _npcOrientation.enum_end; j++)
	{
		arraycopy = array_create(_npcAnimData.enum_end, undefined)
		switch (j)
		{
			case _npcOrientation.up		:
				arraycopy[_npcAnimData.sprite]	= sNPC_Default_Up
				break;
			case _npcOrientation.right		:
				arraycopy[_npcAnimData.sprite]	= sNPC_Default_Right
				break;
			case _npcOrientation.down		:
				arraycopy[_npcAnimData.sprite]	= sNPC_Default_Down
				break;
			case _npcOrientation.left		:
				arraycopy[_npcAnimData.sprite]	= sNPC_Default_Left
				break;
		}
		switch (i)
		{
			case _npcAnimState.idle		:
				arraycopy[_npcAnimData.animSpeed] = 0;
				break;
			case _npcAnimState.walk		:
				arraycopy[_npcAnimData.animSpeed] = 1;
				break;
		}
		sprite_grid[# i, j] = arraycopy;
	}
}

npc_state			= _npcAnimState.idle;
npc_face_direction	= _npcOrientation.down;

#region Prevent NPC having same tag
/*
var tagdiff = true;																											// Create temp variable boolean to break loop
while (tagdiff)
{
	tagdiff = false;																										// Set tagdiff to false to break loop
	// Scan every NPC
	with (oNPC_Actor)
	{
		// Does another NPC has the same tag?
		if (npc_tag == other.npc_tag && id != other.id)
		{
			other.npc_tag++;																								// Increment other tag
			tagdiff = true;
			break;
		}
	}
}
*/

// Setup scripts
script_map[? NPC_SCRIPT_ONTALK]			= ds_list_create();
script_map[? NPC_SCRIPT_ONTOUCH]		= ds_list_create();
script_map[? NPC_SCRIPT_ONSTART]		= ds_list_create();
script_map[? NPC_SCRIPT_ONEACHFRAME]	= ds_list_create();
#endregion
