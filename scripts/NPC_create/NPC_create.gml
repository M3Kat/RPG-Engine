/// @description Create a new NPC

sprite_grid			= ds_grid_create(_npcAnimState.enum_end, _npcOrientation.enum_end);

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
	}
}

npc_state			= _npcAnimState.idle;
npc_face_direction	= _npcOrientation.down;
