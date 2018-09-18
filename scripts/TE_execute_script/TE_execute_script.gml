/// @description Execute commands in the current line and returns an array containing how many characters to delete and a replacement string
/// @param string
/// @param index_char

#region Temp variables

var str			= argument0;
var index		= argument1;
var substr		= "";

var cmdstate	= 0;																										// Number of "%" found

var cmdarglist	= ds_list_create();																							// Create list of arguments
var cmdstr		= "";																										// Full substring
var cmdsub		= "";																										// Individual argument strings

//var arrayreturn = array_create(_teCmdArray.enum_end, undefined);															// Array to return when finishing executing cmd

arrayreturn[_teCmdArray.charDelete]		= 0;																				// # of characters to delete (if set to -1, don't delete characters)
//arrayreturn[_teCmdArray.charReplace]	= undefined;																		// String to insert after deletion
//arrayreturn[_teCmdArray.charData]		= undefined;																		// String to insert after deletion

var i,j;																													// Loop variables

#endregion

#region Get script command

// Get substring
for (i = index; i <= string_length(str); i++)
{
	if (string_char_at(str, i) != "%")
	{
		substr = string_insert(string_char_at(str, i), substr, i - index);													// Insert character inside sub
	}
	else
	{
		cmdstate++;																											// Increment # of "%" found
		if (cmdstate >= 2) break;																							// If 2 "%" are found, break loop
	}
}
// Make a duplicate of full substring
cmdstr = substr;

TE_get_arguments(cmdarglist, cmdstr);																						// Divide arguments

#endregion

#region Execute script

switch (cmdarglist[| 0])
{
	case "PAUSE"		:
		TE_script_pause();
		break;
	case "WAIT"			:
		var arg1	= cmdarglist[| 1];
		TE_script_wait(arg1);
		break;
	case "INSTANT"		:
		TE_script_instant();
		break;
	case "FACE"		:
		var arg1	= cmdarglist[| 1];
		var arg2	= cmdarglist[| 2];
		TE_script_face(arg1, arg2);
		break;
	case "COLOR"		:
		var argarray = array_create(ds_list_size(cmdarglist) - 1, 0);
		// Copy number of arguments inside array
		for (i = 0; i < array_length_1d(argarray); i++)
		{
			argarray[i] = cmdarglist[| i+1];
		}
		TE_script_color(argarray);
		break;
	case "CHARPOS"		:
		var argarray	= array_create(ds_list_size(cmdarglist) - 1, -1);
		// Copy number of arguments inside array
		for (i = 0; i < array_length_1d(argarray); i++)
		{
			argarray[i] = cmdarglist[| i+1];
		}
		TE_script_charpos(argarray);
		break;
	case "CHARW"		:
		var argarray = TE_get_script_arguments(cmdarglist);
		TE_script_charwidth(argarray);
		break;
	case "CHARHALIGN"	:
		var arg1	= cmdarglist[| 1];
		TE_script_charhalign(arg1);
		break;
	case "LONGCHAR"		:
		// arg1 = Full string
		var argarray = TE_get_script_arguments(cmdarglist);
		TE_script_longchar(argarray);
		break;
	case "GOTO"			:
		var arg1	= cmdarglist[| 1];
		var arg2	= false;
		if (ds_list_size(cmdarglist) > 2)
		{
			if (string_upper(cmdarglist[| 2] != "FALSE"))
			arg2	= true;
		}
		TE_script_goto(arg1, arg2);
		TE_arrayreturn_nodeletion();
		break;
	case "TAG"			:
	case "NEWLINE"		:
		TE_script_newline();
		TE_arrayreturn_nodeletion();
		break;
	case "MATH"			:
		var arg1	= cmdarglist[| 1];
		var arg2	= cmdarglist[| 2];
		var arg3	= cmdarglist[| 3];
		TE_script_math(arg1, arg2, arg3);
		break;
	case "VARIABLE"		:
		var arg1	= cmdarglist[| 1];
		arrayreturn[_teCmdArray.charReplace] = TE_script_variable(arg1);
		break;
	case "IF"			:
		var arg1	= cmdarglist[| 1];
		var arg2	= cmdarglist[| 2];
		var arg3	= cmdarglist[| 3];
		TE_script_if(arg1, arg2, arg3);
		break;
	case "ELSE"			:
		TE_script_else();
		TE_arrayreturn_nodeletion();
		break;
	case "LOOP"			:
		// No code really
		TE_script_newline();
		break;
	case "LOOPEND"		:
		TE_script_loopend();
		break;
	case "LOOPBREAK"	:
		TE_script_loopbreak();
		break;
	case "{"			:
		TE_script_bracket_in();
		TE_arrayreturn_nodeletion();
		break;
	case "}"			:
		TE_script_bracket_out();
		TE_arrayreturn_nodeletion();
		break;
	case "CHOICE"		:
		var choicearray;
		for (i = 0; i < ds_list_size(cmdarglist) - 1; i++)
		{
			choicearray[i] = cmdarglist[| i+1];
		}
		TE_script_choice(choicearray);
		break;
	case "MACRO"		:
		var argarray	= TE_get_script_arguments(cmdarglist);
		TE_script_macro(argarray);
		break;
	case "MACROGOTO"	:
		var arg1	= cmdarglist[| 1];
		var arg2	= cmdarglist[| 2];
		TE_script_macrogoto(arg1, arg2);
		break;
	case "END"			:
		TE_script_end();
		break;
}

#endregion

// Set distance to move character index
if (arrayreturn[_teCmdArray.charDelete] != -1)
{
	arrayreturn[_teCmdArray.charDelete] = string_length(substr) + 2;														// Return how many characters to move the index
}

//show_message(substr);																										// DEBUG VIEW COMMAND DATA

ds_list_destroy(cmdarglist);																								// Destroy ds list of arguments

return arrayreturn;
