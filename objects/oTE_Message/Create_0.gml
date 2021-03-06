/// @description Init variables

surface_width		= 320;																											// Default width
surface_height		= 64; //TE_CHAR_HEIGHT*4;																						// Default height
surface_x			= 0;																											// Default x
surface_y			= 176;																											// Default y
surface				= noone;																										// Create empty surface variable
TE_create_surface();																												// Create New surface

surface_stretch_w	= 1;																											// Surface strecth 
surface_stretch_h	= 0;																											// Surface stretch

active				= false;																										// Is the window active?

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
char_halign			= fa_left;																										// Current alignment of characters

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

ask_char_array		= array_create(6,0); 

parent_caller		= noone;																										// Original parent (NPC) of textbox
parent				= noone;																										// Parent of textbox
child				= noone;																										// Children of textbox

condition[0]		= false;																										// Set result of condition on each bracket level

arrayreturn			= undefined;

initiated			= false;																										// Do open animation if false
finished			= false;																										// Do closure animation if true