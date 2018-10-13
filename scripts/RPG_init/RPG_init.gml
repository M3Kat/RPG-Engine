/// @description Initiate RPG values

#macro RPG_HERO_NUM 8														// Set number of heroes

global.actorSpriteGrids		= ds_map_create();								// Global DS_MAP to store grids containing graphics for NPCs
global.actorSpriteUniqueID	= ds_map_create();								// Stores external sprites ID to prevent duplicates