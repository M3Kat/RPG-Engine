/// @description Returns JSON data map or list
/// @arg file_location

#region Temp variables

var jsonname = argument0;
var jsonfile = undefined;
var jsonstring = "";

#endregion

// Does file exists?
if (file_exists(jsonname))
{
	
	#region Load JSON data parameters
	
	jsonfile = file_text_open_read(jsonname);		// Open json file
	while (!file_text_eof(jsonfile))
	{
		jsonstring = string_insert(file_text_readln(jsonfile), jsonstring, string_length(jsonstring));
	}
	file_text_close(jsonfile);
		
	// Remove all \n & \b & spaces
		
	jsonstring = string_replace_all(jsonstring, "\n", "");
	jsonstring = string_replace_all(jsonstring, "\b", "");
	//jsonstring = string_replace_all(jsonstring, " ", "");
	
	#endregion
	
	#region Decode JSON file
	
	return json_decode(jsonstring);
	
	#endregion	
	
	}
else
{
	show_error ("ERROR : File does not exist.", false);
}