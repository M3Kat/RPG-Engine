/// @description Set default values for NPC

#macro NPC_SCRIPT_ONTALK "onTalk"
#macro NPC_SCRIPT_ONTOUCH "onTouch"
#macro NPC_SCRIPT_ONSTART "onStart"
#macro NPC_SCRIPT_ONEACHFRAME "onEachFrame"

enum _npcAnimState
{
	idle,
	walk,
	run,
	jump,
	enum_end
}

enum _npcAnimData
{
	sprite,
	animSpeed,
	enum_end
}

enum _npcOrientation
{
	up,
	right,
	down,
	left,
	enum_end
}

enum _npcScript
{
	onTalk,
	onTouch,
	onStart,
	onEachFrame,
	enum_end
}