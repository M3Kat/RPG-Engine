/// @description Initiate enum for text box

#macro TE_CHAR_HEIGHT 12
#macro TE_DEFAULT_TEXT_SOUND sfxTE_Text_Default
#macro TE_BORDER_SIZE 8

#region Enum containing commands

enum _teSpdBufferMode
{
	normal,																							// Normal speed
	fast,																							// Fast speed
	enum_end
}

enum _teCmdArray
{
	charDelete,																						// Number of characters to delete
	charReplace,																					// String to insert after execution of command
	charData,																						// Data to put inside character
	enum_end
}

enum _teBoxType
{
	Message,																						// Normal message box
	Choice,																							// Choice between numbers of values
	enum_end
}

enum _teCharData
{
	character,
	color,
	font,
	setX,
	setY,
	setW1,
	setW2,
	halign,
	enum_end
}

#endregion

draw_set_font(fDefault);