/// @description Goto specific tag
/// @arg tag_name
/// @arg no_skip
/// @arg [bypass_macro]

var tagname		= argument[0];
var noskip		= argument[1];																					// Do we skip line?
var macroskip	= false;																						// Do we bypass macro check?
var taglist		= ds_list_create();																				// Get argum

var macrolist	= "";																							// Current macro position
var macrofound	= false;

var macroarg	= ds_list_create();

var i;

index_bracket	= 0;																							// Reset index bracket

// Fetch argument2
if (argument_count > 2) macroskip = argument[2];

// Get current macro
for (i = 0; i < ds_list_size(macro_list); i++)
{
	macrolist = string_insert(macro_list[|i], macrolist, string_length(macrolist));
}

// If macrolist is empty, set macro found to true
if (string_length(macrolist) == 0) macrofound = true;

for (i = 0; i < ds_list_size(line); i++)
{
	// Go inside and outside brackets
	switch (string_char_at(line[| i], 2))
	{
		case "{"	:
			index_bracket++;
			break;
		case "}"	:
			index_bracket--;
			break;
	}
	
	// Is inside macro?
	if (!macrofound)
	{
		if (string_count("%MACROBEGIN["+macrolist, line[| i]) != 0)
		{
			TE_get_arguments(macroarg, string_replace_all(line[| i], "%", ""));							// Get arguments of MACROBEGIN
			index_bracket = real(macroarg[| 2]);																		// Copy bracket level
			macrofound = true;
		}
	}
	
	if (string_copy(line[| i], 1, 4) == "%TAG" && (macrofound || macroskip))
	{
		ds_list_clear(taglist);																					// Clear ds list
		TE_get_arguments(taglist, line[| i])																	// Get command from line
		// If tag name is matching, set our line index to new position
		if (taglist[| 1] == tagname)
		{
			index_line = i;
			if (!noskip) TE_script_newline();																	// If no skip is false, skip a line
			break;
		}
	}
}

ds_list_destroy(taglist);
ds_list_destroy(macroarg);