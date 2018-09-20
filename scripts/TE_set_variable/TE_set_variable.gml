/// @description Set value of specific variable
/// @arg NPC###.||VAR.
/// @arg value

#region Temp Variable

var varname	= argument0;
var vartype	= undefined;

var i;

#endregion

#region NPC TAG

if (string_copy(varname, 1, 3) == "NPC")
{
	var npctag = "";
	var npcchar;
	var npclength = 0;
	var npcid = noone;																					// NPC ID
	var npcvar = "";																					// Name of NPC variable
	var npcval = 0;																						// Value of NPC variable
	i = 4;
	// Get tag name
	while (string_char_at(varname, i) != ".")
	{
		npcchar		= string_char_at(varname, i);														// Get current char
		npclength	= string_length(npctag);															// Get current length
		npctag		= string_insert(npcchar, npctag, npclength+1);										// Add current char to end of string
		i++
	}
	// Get varname
	for (i = i+1; i <= string_length(varname); i++)
	{
		npcchar		= string_char_at(varname, i);														// Get current char
		npclength	= string_length(npcvar);															// Get current length
		npcvar		= string_insert(npcchar, npcvar, npclength+1);										// Add current char to end of string
	}
	npctag = real(npctag);																				// Convert npctag to real
	with (oNPC_Actor)
	{
		// Does the npctag correspond?
		if (npctag = npc_tag)
		{
			npcid = id;																					// Set NPC tag to ID
			break;
		}
	}
	npcval = variable_instance_set(npcid, npcvar, argument1);											// Set Variable ID
	return;
}

#endregion

#region VAR TAG (Default)

//if (string_copy(varname, 1, 4) == "VAR."  || string_count("VAR.", varname) == 0)
//{
	var varstring	= "";																				// Name of variable
	if (string_count("VAR.", varname) > 0) varname = string_delete(varname, 1, 4);						// Delete VAR tag if found
	varstring = varname;
	global.nspDsMap[? varstring] = argument1;
	return;
//}

#endregion