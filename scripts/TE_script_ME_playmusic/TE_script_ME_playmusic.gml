/// @description Call ME to play music

var file = argument0[@ 0];
var argsize = array_length_1d(argument0);
if (argsize >= 2)
{
	global.nspDsMap[? "ME_VOLUME"] = real(argument0[@ 1])
}
if (argsize >= 3)
{
	global.nspDsMap[? "ME_PITCH"] = real(argument0[@ 2])
}

with (oME_System)
{
	ME_play_music(file, true);
}