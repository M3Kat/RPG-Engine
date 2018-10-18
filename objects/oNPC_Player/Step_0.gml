/// @description Insert description here
// You can write your code in this editor

// TEMP CONTROLS
var i;
var butt;
var spritearray;

var TE_activeWindows = false;

with (oTE_Message)
{
	if (active)
	{
		TE_activeWindows = true;
		break;
	}
}
if (!TE_activeWindows)
{
	for (i = 0; i < 4; i++)
	{
		switch (i)
		{
			case 0	:
				butt	= vk_up;
				break;
			case 1	:
				butt	= vk_right;
				break;
			case 2	:
				butt	= vk_down;
				break;
			case 3	:
				butt	= vk_left;
				break;
		}
		if (keyboard_check(butt))
		{
			iswalking = true;
			break;
		}
		else if (i == 3)
		{
			iswalking = false;
			break;
		}
	}

	if (keyboard_check(vk_up))
	{
		y--;
		npc_face_direction = _npcOrientation.up;
	}
	if (keyboard_check(vk_right))
	{
		x++;
		npc_face_direction = _npcOrientation.right;
	}
	if (keyboard_check(vk_down))
	{
		y++;
		npc_face_direction = _npcOrientation.down;
	}
	if (keyboard_check(vk_left))
	{
		x--;
		npc_face_direction = _npcOrientation.left;
	}

	if (!iswalking)
	{
		switch (npc_face_direction)
		{
			case _npcOrientation.up	:
				spritearray = sprite_grid[# _npcAnimState.idle, _npcOrientation.up];
				break;
			case _npcOrientation.right	:
				spritearray = sprite_grid[# _npcAnimState.idle, _npcOrientation.right];
				break;
			case _npcOrientation.down	:
				spritearray = sprite_grid[# _npcAnimState.idle, _npcOrientation.down];
				break;
			case _npcOrientation.left	:
				spritearray = sprite_grid[# _npcAnimState.idle, _npcOrientation.left];
				break;
		}
	}
	if (iswalking)
	{
		switch (npc_face_direction)
		{
			case _npcOrientation.up	:
				spritearray = sprite_grid[# _npcAnimState.walk, _npcOrientation.up];
				break;
			case _npcOrientation.right	:
				spritearray = sprite_grid[# _npcAnimState.walk, _npcOrientation.right];
				break;
			case _npcOrientation.down	:
				spritearray = sprite_grid[# _npcAnimState.walk, _npcOrientation.down];
				break;
			case _npcOrientation.left	:
				spritearray = sprite_grid[# _npcAnimState.walk, _npcOrientation.left];
				break;
		}
	}
	sprite_index	= spritearray[_npcAnimData.sprite];
	//image_speed		= spritearray[_npcAnimData.animSpeed];
	// Talk to NPC
	if (keyboard_check_pressed(vk_space))
	{
		var inst = noone;
		switch (npc_face_direction)
		{
			case _npcOrientation.up :
				inst = instance_position(x, y-16, oNPC_Actor);
				break;
			case _npcOrientation.down :
				inst = instance_position(x, y+16, oNPC_Actor);
				break;
			case _npcOrientation.left :
				inst = instance_position(x-16, y, oNPC_Actor);
				break;
			case _npcOrientation.right :
				inst = instance_position(x+16, y, oNPC_Actor);
				break;
		}
		if (inst != noone && inst != id)
		{
			with (inst)
			{
				var _txtbox = TE_create();
				TE_add_batch(_txtbox, NPC_SCRIPT_ONTALK);
				_txtbox.parent_caller = id;
				_txtbox.active = true;
			}
		}
	}
}