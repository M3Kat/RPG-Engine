/// @description Checks if previous condition is false
/// @arg variable
/// @arg condition
/// @arg equation

#region Temp variables

var result = false;																						// Temp var

#endregion

if (condition[index_bracket] == false)
{
	condition[index_bracket] = true;																	// Go inside bracket if previous condition is false
	TE_script_newline();																				// Go into new line
}
else
{
	TE_script_bracket_skip();																			// Skip brackets
}
return result;