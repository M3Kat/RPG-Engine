/// @description Add new lines coming from txt file at the end of dslist and jumps to it. Returns to original position after execution
/// @arg txt_file_name

#region Temp variables

var txtid			= id;
var txtline			= index_line;
var txtname			= argument0[@ 0];

var arglength		= array_length_1d(argument0);

var fileid;
var fileline;

var oldline			= -1;

var str_begin		= "MACROBEGIN_";
var str_macro		= "MACRO_";
var str_return		= "MACRORETURN_";

var str_macrolist	= "";																					// String containing all macro names

// New code

var txtid			= id;

var jsonname = argument0[@ 0];												// Name of JSON

var jsonmap;																// DS MAP of JSON
var jsonlist;																// List containing lines of text
var jsonstring;																// String of one line

var oldline			= -1;

var i,j;

#endregion

#region New code (Using JSON files in scripts folder)

// Get script data from JSON
jsonmap = json_decode_file("scripts/"+jsonname+".json");

// Is JSON valid?
if (jsonmap != -1)
{
	// Copy list of text from JSON.
	jsonlist = jsonmap[?"default"];
	/*
	NOTE : 
	We'll be using %MACROTAG[]
	*/
	// Add macro name to macro_list
	ds_list_add(macro_list, jsonname);
	// Get string containing all macros
	for (i = 0; i < ds_list_size(macro_list); i++)
	{
		str_macrolist = string_insert(macro_list[| i], str_macrolist, string_length(str_macrolist)+1);
	}
	// Delete macro data if it exists
	oldline	= ds_list_find_index(line, "%TAG["+str_return+str_macrolist+"]%");
	if (oldline != -1)
	{
		ds_list_delete(line, oldline);																			// Remove old return tag
		if (index_line >= oldline) index_line--;																	// Decrement index_line if old return tag was before it
		var indexold = index_line;																				// Create backup of index line
		//TE_insert_line(txtid, txtline+1, "%TAG["+str_return+txtname+"]%");									// Insert new return tag
		TE_script_goto(str_macro+str_macrolist, true);															// Goto already pasted script
		index_line--;																							// Go back 1 line to delete end flag
		// Delete lines until the goto return command is shown
		while (!string_count("%MACROGOTO["+str_return+str_macrolist, line[| index_line]))
		{
			ds_list_delete(line, index_line);																// Delete current line
			//index_line++;																					// Increment index_counter
		}	
		ds_list_delete(line, index_line);																		// Delete last line
		index_line	= indexold;																					// Return to old index
		txtline		= index_line
	}
	
	#region Insert macro

	//TE_insert_line(txtid, txtline, "%GOTO[MACRO_"+str_macrolist+"]%");												// Insert goto command
	TE_insert_line(txtid, txtline+1, "%TAG["+str_return+str_macrolist+"]%");											// Insert return command
	TE_add_line(txtid, "%END%");																						// Insert end command if accidentally going inside macro
	TE_add_line(txtid, "%MACROBEGIN["+str_macrolist+","+string(index_bracket)+"]%");										// Insert begin command for goto command (with bracket size parameter)
	TE_add_line(txtid, "%TAG["+str_macro+str_macrolist+"]%");															// Insert tag command to jump to the macro
	
	
	// Copy each lines inside line list
	for (i = 0; i < ds_list_size(jsonlist); i++)
	{
		// Get line
		jsonstring = jsonlist[| i];
		
		// Replace arguments inside string
		for (j = 0; j < arglength-1; j++)
		{
			jsonstring	= string_replace_all(fileline, "$ARG"+string(i)+"$", string(argument0[@ +1]));			// Replace all placeholders
		}
		
		// Add new line in script
		TE_add_line(txtid, jsonstring);																			// Add new line at the end of line list
		/*
		file_text_readln(fileid);			*/																	// Advance line
	}
		
	TE_add_line(txtid, "%MACROGOTO["+str_return+str_macrolist+","+string(index_bracket)+"]%");					// Add macrogoto command at the end

	#endregion
	
	TE_script_goto(str_macro+str_macrolist, false, true);
	
	// Destroy DS LIST and MAP
	ds_list_destroy(jsonlist);
	ds_map_destroy(jsonmap);
}

#endregion

#region Old code (Using TXT files in MACRO folder)
/*
// Get instance

// Open file if it exists, or else open dummy file
if (!file_exists("macro/"+txtname+".txt"))
{
	txtname = "_ErrorNoMacro";
}
// Add macro name to macro_list
ds_list_add(macro_list, txtname);
// Get string containing all macros
for (i = 0; i < ds_list_size(macro_list); i++)
{
	str_macrolist = string_insert(macro_list[| i], str_macrolist, string_length(str_macrolist)+1);
}

fileid = file_text_open_read("macro/"+txtname+".txt");
// Delete macro data if it exists
oldline	= ds_list_find_index(line, "%TAG["+str_return+str_macrolist+"]%");
if (oldline != -1)
{
	ds_list_delete(line, oldline);																			// Remove old return tag
	if (index_line >= oldline) index_line--;																	// Decrement index_line if old return tag was before it
	var indexold = index_line;																				// Create backup of index line
	//TE_insert_line(txtid, txtline+1, "%TAG["+str_return+txtname+"]%");									// Insert new return tag
	TE_script_goto(str_macro+str_macrolist, true);															// Goto already pasted script
	index_line--;																							// Go back 1 line to delete end flag
	// Delete lines until the goto return command is shown
	while (!string_count("%MACROGOTO["+str_return+str_macrolist, line[| index_line]))
	{
		ds_list_delete(line, index_line);																// Delete current line
		//index_line++;																					// Increment index_counter
	}	
	ds_list_delete(line, index_line);																		// Delete last line
	index_line	= indexold;																					// Return to old index
	txtline		= index_line
}

#region Insert macro

//TE_insert_line(txtid, txtline, "%GOTO[MACRO_"+str_macrolist+"]%");												// Insert goto command
TE_insert_line(txtid, txtline+1, "%TAG["+str_return+str_macrolist+"]%");											// Insert return command
TE_add_line(txtid, "%END%");																				// Insert end command if accidentally going inside macro
TE_add_line(txtid, "%TAG["+str_macro+str_macrolist+"]%");															// Insert tag command to jump to the macro
		
// Copy each lines inside line list
while (!file_text_eof(fileid))
{
	fileline	= file_text_read_string(fileid);															// Copy current line
	fileline	= string_replace_all(fileline, "\\n", "\n");												// Replace all faulty \\n with \n
	// Replace arguments inside line
	for (i = 0; i < arglength-1; i++)
	{
		fileline	= string_replace_all(fileline, "$ARG"+string(i)+"$", string(argument0[@ i+1]));			// Replace all placeholders
	}
	TE_add_line(txtid, fileline);																			// Add new line at the end of line list
	file_text_readln(fileid);																				// Advance line
}
		
TE_add_line(txtid, "%MACROGOTO["+str_return+str_macrolist+","+string(index_bracket)+"]%");					// Add macrogoto command at the end
	
file_text_close(fileid);																					// Close text file

#endregion

TE_script_goto(str_macro+str_macrolist, false);
*/
#endregion