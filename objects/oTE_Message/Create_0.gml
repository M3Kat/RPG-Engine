/// @description Init variables

surface_width		= 320;																											// Default width
surface_height		= 64; //TE_CHAR_HEIGHT*4;																						// Default height
surface_x			= 0;																											// Default x
surface_y			= 176;																											// Default y
surface				= surface_create(surface_width,surface_height);																	// Create New surface

line				= ds_list_create();																								// Create ds list containing game lines
line_copy			= undefined;																									// String containg copy of current line

index_line			= 0;																											// Current line
index_char			= 1;																											// Current char
index_bracket		= 0;																											// Current bracket level
index_speed			= 0.5;																											// Normal text speed
index_speed_fast	= 1.5;																											// Fast text speed when pressing space
//index_speed_dif	= 0;																											// Buffer speed decimal

text_sound			= TE_DEFAULT_TEXT_SOUND;																						// Set sound for text

macro_list			= ds_list_create();																								// DS List containing all names of currently active macros

speed_buffer		= 0;
speed_buffer_mode	= _teSpdBufferMode.normal;																						// Current mode of 

char_list			= ds_list_create();																								// Create list containing all characters and their parameters
char_color			= $ffffff;																										// Current character color

face_sprite			= undefined;																									// Face sprite to display in tbe corner
face_subsprite		= 0;																											// Frame to use
face_side			= 0;																											// Is face sprite on the left or on the right of textbox
face_hflip			= false;

border_sprite		= sTE_BorderA

string_display		= "";																											// TO REMOVE Set string to display inside textbox

wait				= 0;																											// If > 0, text does not increment
pause				= false;																										// If set to true, player has to press space to advance text

box_type			= _teBoxType.Message;																							// Type of box

cursor_pos			= 0;																											// Cursor position
cursor_options      = 0;																											// Number of options available for selection

parent				= noone;																										// Textbox's original caller
child				= noone;																										// Textbox's newly executed

condition[0]		= false;																										// Set result of condition on each bracket level

arrayreturn			= 0;

finished			= false;																										// Destroy instance if true