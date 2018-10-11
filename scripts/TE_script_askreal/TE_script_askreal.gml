/// @description Setup a choice window
/// @arg choicearray

#region Temp var

///var array				= argument0;																		// Array containing list of choices
var arraywidth			= 0;
var arrayheight			= 0;

var choiceid			= noone;																			// ID of choice textbox to be created
var choicestring		= "";																				// String to send inside the textbox

var reallength			= real(argument0[@ 0]);																// Get max length of variable
var realdefault			= 0;																				// Set default value
var realstring;

var realchararray		= array_create(reallength, 0);

//var bordersize			= 8;																			// REPLACE THIS

var i,j,k;

#endregion

#region Setup textbox

// If there is 2 arguments, set default value of choice
if (array_length_1d(argument0) >= 2) realdefault = real(TE_get_variable(argument0[@ 1]));
realstring = string_format(realdefault, reallength, 0);
realstring = string_replace_all(realstring, " ", "0");


// Set full width of box
arraywidth = TE_CHAR_HEIGHT * reallength;
// Set height of box
arrayheight = TE_CHAR_HEIGHT;

// Insert value inside array
for (i = 0; i < reallength; i++)
{
	realchararray[i]	= string_char_at(realstring, i+1);
}

choiceid = TE_create(surface_width-arraywidth-TE_BORDER_SIZE*2,surface_y-arrayheight-TE_BORDER_SIZE*2,surface_width,surface_y);			// Create new textbox
TE_add_line(choiceid, "");
choiceid.box_type	= _teBoxType.AskReal;
choiceid.ask_char_array = realchararray;																// Set array
choiceid.cursor_options	= reallength;																	// Set number of choices inside textbox
choiceid.index_speed	= string_length(choicestring);													// Set text speed to instant
choiceid.index_speed_fast = string_length(choicestring);												// Set text speed to instant
choiceid.parent		= id;																				// Set new textbox's parent to our ID

child				= choiceid;																			// Set our child to new textbox's ID

#endregion

