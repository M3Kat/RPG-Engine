/// @description Loads an actor JSON file containing sprite data
/// @arg actor_name

#region Temp variables

var jsonname	= string(argument0);										// Name of folder
var jsonfile	= undefined;												// File ID if loaded
var jsonstring	= "";														// Full one-line string

var jsonmap;																// Decoded JSON

#endregion

// Does file exists?
if (file_exists("actor/"+jsonname+"/sprites.json"))
{
	#region Read file
	
	jsonfile = file_text_open_read("actor/"+jsonname+"/sprites.json")		// Open json file
	while (!file_text_eof(jsonfile))
	{
		jsonstring = string_insert(file_text_readln(jsonfile), jsonstring, string_length(jsonstring));
	}
	file_text_close(jsonfile);
	
	#endregion
	
	#region Decode JSON
	
	jsonmap = json_decode(jsonstring);
	
	#endregion
}