/// @description Creates a new textbox with content of JSON and set children variable to new ID
/// @arg cmdarray[json_name,arg0,arg1,arg2...]
/// @arg is_async

#region Temp variables

var jsonname = argument0[@0];										// Name of JSON file
/*
var teX1 = argument0[@1];											// X pos of textbox
var teY1 = argument0[@2];											// Y pos of textbox
var teX2 = undefined;												// X2 pos of textbox
var teY2 = undefined;												// X2 pos of textbox
*/
var teID = noone;

var jsonmap;
var jsonlist;

var async = argument1;

var i,j;

#endregion
/*
#region Get optional arguments

if (array_length_1d(argument0) > 3) teX2 = argument0[@3];
if (array_length_1d(argument0) > 4) teY2 = argument0[@4];

#endregion
*/
#region Create textbox

// Does JSON exists?
if (file_exists("scripts/"+jsonname+".json"))
{
	// Create textbox
	teID = TE_create(teX1, teY1, teX2, teY2);
	teID.parent = ID;
	
	// Insert data inside textbox
	TE_add_script_json(teID, jsonname);
	
	// Replace arguments inside textbox
	with (teID)
	{
		for (i = 1; i < array_length_1d(argument0); i++)
		{
			// Swipe each line of textbox
			for (j = 0; j < ds_list_size(line); j++)
			{
				line[|j] = string_replace_all(line[|j], "$ARG"+i+"$", argument0[i]);	// Replace placeholders with argument
			}
		}
	}

	// Set children
	if (!async) child = teID;
}

#endregion