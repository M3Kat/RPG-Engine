/// @description Checks if equation is true, then enters or skips brackets
/// @arg variable
/// @arg condition
/// @arg equation

#region Temp variables

var variable = global.nspDsMap[? argument0];
var equation = NSP_evaluate(argument2);																	// Calculate equation

var result = false;																						// Temp var

#endregion

// Get comparator
switch (argument1)
{
	case "=="	:																						// Equals to
		if (variable == equation) result = true;
		break;
	case "<"	:																						// Smaller than
		if (variable < equation) result = true;
		break;
	case ">"	:																						// Greater than
		if (variable > equation) result = true;
		break;
	case "<="	:																						// Smaller or equal than
		if (variable <= equation) result = true;
		break;
	case ">="	:																						// Greater or equal than
		if (variable >= equation) result = true;
		break;
	case "!="	:																						// Not equals to
		if (variable != equation) result = true;
		break;
	default		:																						// Returns false if it's an invalid comparator
		result = false;
}

// Set result bracket
if (result = true)
{
	condition[index_bracket] = true;
}
if (result = false)
{
	condition[index_bracket] = false;
	TE_script_newline();
}