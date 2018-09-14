/// @description Insert description here
// You can write your code in this editor

// TEMP CONTROLS
var i;
var butt;
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

if (keyboard_check(vk_up)
{
	y--;
	npc_face_direction = _npcOrientation.up;
}
if (keyboard_check(vk_right)
{
	x++;
	npc_face_direction = _npcOrientation.right;
}
if (keyboard_check(vk_down)
{
	y++;
	npc_face_direction = _npcOrientation.down;
}
if (keyboard_check(vk_left)
{
	x--;
	npc_face_direction = _npcOrientation.left;
}

if (iswalking)
{
	switch (npc_face_direction)
	{
		case _npcOrientation.up	:
			sprite_index = sprite_map[? _npcAnimState.idle_up];
			break;
		case _npcOrientation.right	:
			sprite_index = sprite_map[? _npcAnimState.idle_right];
			break;
		case _npcOrientation.down	:
			sprite_index = sprite_map[? _npcAnimState.idle_down];
			break;
		case _npcOrientation.left	:
			sprite_index = sprite_map[? _npcAnimState.idle_left];
			break;
	}
}