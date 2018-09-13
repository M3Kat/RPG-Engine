/// @description Setup a choice window
/// @arg choicearray

#region Temp var

//var array				= argument0;																		// Array containing list of choices
var arraywidth			= 0;
var arrayheight			= 0;

var choiceid			= noone;																			// ID of choice textbox to be created
var choicestring		= "";																				// String to send inside the textbox

var bordersize			= 8;																				// REPLACE THIS

var i,j,k;

#endregion

#region Setup textbox

// Get full height of box
arrayheight = TE_CHAR_HEIGHT * array_length_1d(argument0);

// Get full width of box WITHOUT ARGUMENTS
for (i = 0; i < array_length_1d(argument0); i++)
{
	var ws = argument0[@ i];
	var wd = 0;
	for (j = 1; j <= string_length(wd); j++)
	{
		k = 1;
		while (string_char_at(ws, j) == "&")
		{
			if (string_char_at(ws, j+k) == "&")
			{
				ws = string_delete(ws, j, k);
				break;
			}
			else if (j+k >= string_length(ws))
			{
				break;
			}
			else
			{
				k++
			}
		}
	}
	wd = string_width(ws);
	if (wd > arraywidth) arraywidth = wd;																// Set new maximal width if WS is higher
}

// Copy arguments
for (i = 0; i < array_length_1d(argument0); i++)
{
	choicestring = string_insert(argument0[@i] + "\n", choicestring, string_length(choicestring)+1);
}
//choicestring = string_insert("%INSTANT%", choicestring, 1);											// CMD NOT INSTANT Set text speed to instant
choicestring = TE_convert_arguments(choicestring);														// Convert arguments inside choice

choiceid = TE_create(surface_width-arraywidth-bordersize*2,surface_y-arrayheight-bordersize*2,surface_width,surface_y);			// Create new textbox
TE_add_line(choiceid, choicestring);
choiceid.box_type	= _teBoxType.Choice;
choiceid.cursor_options	= array_length_1d(argument0);													// Set number of choices inside textbox
choiceid.speed_buffer = string_length(choicestring);													// Set text speed to instant
choiceid.parent		= id;																				// Set new textbox's parent to our ID

child				= choiceid;																			// Set our child to new textbox's ID

#endregion

