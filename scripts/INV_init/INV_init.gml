/// @description Init inventory & stats

// Enums

enum _invStatData
{
	hp,
	mp,
	maxhp,
	maxmp,
	attack,
	intelligence,
	defense,
	speed,
	level,
	xp,
	xpmod,
	equipWeapon,
	equipShield,
	equipHat,
	equipChest,
	equipAccessory,
	enum_end
}

global.tokenINVStat = array_create(_invStatData.enum_end, "");
global.tokenINVStat[_invStatData.hp]				= "hp";
global.tokenINVStat[_invStatData.mp]				= "mp";
global.tokenINVStat[_invStatData.maxhp]				= "maxhp";
global.tokenINVStat[_invStatData.maxmp]				= "maxmp";
global.tokenINVStat[_invStatData.attack]			= "atk";
global.tokenINVStat[_invStatData.intelligence]		= "int";
global.tokenINVStat[_invStatData.defense]			= "def";
global.tokenINVStat[_invStatData.speed]				= "spd";
global.tokenINVStat[_invStatData.level]				= "lvl";
global.tokenINVStat[_invStatData.xp]				= "xp";
global.tokenINVStat[_invStatData.xpmod]				= "xpmod";
global.tokenINVStat[_invStatData.equipWeapon]		= "eWeapon";
global.tokenINVStat[_invStatData.equipShield]		= "eShield";
global.tokenINVStat[_invStatData.equipHat]			= "eHat";
global.tokenINVStat[_invStatData.equipChest]		= "eChest";
global.tokenINVStat[_invStatData.equipAccessory]	= "eAccessory";

enum _invItemData
{
	id,
	quantity,
	uses,
	enum_end
}

global.INV_items	= ds_list_create();													// Create list of items

global.INV_stats	= ds_list_create();													// Create list of hero stats

var tmpDSMap;																			// Create tmp variable
for (var i = 0; i < RPG_HERO_NUM; i++)
{
	tmpDSMap = ds_map_create();															// Setup fresh DS MAP
	for (var j = _invStatData.hp; j <= _invStatData.xpmod; j++)
	{
		tmpDSMap[?j] = 1;																// Insert stat nums
	}
	for (var j = _invStatData.equipWeapon; j <= _invStatData.equipAccessory; j++)
	{
		tmpDSMap[?j] = undefined;														// Insert equipment id (undefined)
	}
	global.INV_stats[|i] = tmpDSMap;													// Insert DS map inside DS list
}