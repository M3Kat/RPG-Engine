/// @description Goto specific tag & set new bracket level
// @arg tag_name
// @arg bracket_level

#region Temp Variablels

var tagname		= argument0;
var bracketlvl	= real(argument1);

#endregion

// Goto tag

TE_script_goto(tagname, false);

// Set new bracket level

index_bracket = bracketlvl;

// Remove macro from macro_list

var size = ds_list_size(macro_list);
ds_list_delete(macro_list, size-1);