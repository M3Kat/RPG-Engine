TE/// @description Init the game and goto next room

if (!variable_global_exists("init"))
{
	global.init = true;
	
	// Start the game
	
	NSP_initialize();

	RPG_init();

	INV_init();

	TE_Init();

	NPC_init();

	ME_init();
}

room_goto_next();
