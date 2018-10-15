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

global.tokenNPCAnimState = array_create(_npcAnimState.enum_end,"");
global.tokenNPCAnimState[_npcAnimState.idle]	= "idle";
global.tokenNPCAnimState[_npcAnimState.walk]	= "walk";
global.tokenNPCAnimState[_npcAnimState.run]		= "run";
global.tokenNPCAnimState[_npcAnimState.jump]	= "jump";

enum _npcAnimData
{
	sprite,
	originX,
	originY,
	animFrames,
	animSpeed,
	enum_end
}

global.tokenNPCAnimData = array_create(_npcAnimData.enum_end,"");
global.tokenNPCAnimData[_npcAnimData.sprite]		= "sprites";
global.tokenNPCAnimData[_npcAnimData.originX]		= "originX";
global.tokenNPCAnimData[_npcAnimData.originY]		= "originY";
global.tokenNPCAnimData[_npcAnimData.animFrames]	= "animFrames";
global.tokenNPCAnimData[_npcAnimData.animSpeed]		= "animSpeed";

global.defaultNPCAnimData = array_create(_npcAnimData.enum_end,	undefined);
global.defaultNPCAnimData[_npcAnimData.sprite]		= sNPC_Failsafe;
global.defaultNPCAnimData[_npcAnimData.originX]		= 12;
global.defaultNPCAnimData[_npcAnimData.originY]		= 32;
global.defaultNPCAnimData[_npcAnimData.animFrames]	= 1;
global.defaultNPCAnimData[_npcAnimData.animSpeed]	= 1;

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