/// @description Get arguments from string
/// @arg cmdarglist
/// @arg cmdstr

// Temp var

var cmdarglist	= argument0;																								// Argument list
var cmdstr		= argument1;																								// Command string
var cmdsub		= "";																										// Command substring

var subarg		= false;																									// Is inside a recursive argument (&)?

var i,j;																													// Loop variables

// Divide substring into arguments
j = 0;																														// Init j variable
for (i = 1; i <= string_length(cmdstr); i++)
{
	switch (string_char_at(cmdstr, i))
	{
		case "&"	:
			if (!subarg) subarg = true;
			else subarg = false;
			cmdsub	= string_insert(string_char_at(cmdstr, i), cmdsub, i);
			break;
		case "["	:
		case ","	:
		case "]"	:
			// If inside sub argument, don't create new argument
			if (!subarg)
			{
				cmdarglist[| j] = cmdsub;
				cmdstr	= string_delete(cmdstr, 1, i);
				cmdsub	= "";
				i = 0;
				j++;
			}
			else
			{
				cmdsub	= string_insert(string_char_at(cmdstr, i), cmdsub, i);	
			}
			break;
		default		:
			cmdsub	= string_insert(string_char_at(cmdstr, i), cmdsub, i);
	}
}
// Insert full string if there is no special chars
if (ds_list_size(cmdarglist) == 0)
{
	cmdarglist[| j] = cmdstr;
}