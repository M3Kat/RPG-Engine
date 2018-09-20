/// @description Loop music track if it ended
// You can write your code in this editor

var meLoopMode		= global.nspDsMap[?"ME_LOOP"];
var meLoopCount		= global.nspDsMap[?"ME_LOOPCOUNT"];
var meSongName		= global.nspDsMap[?"ME_MUSIC"];
var meStream		= global.nspDsMap[?"ME_STREAM"];
var meStreamPlay	= global.nspDsMap[?"ME_STREAMPLAY"];

var streamLength	= global.nspDsMap[?"ME_LENGTH"];
var streamPos		= audio_sound_get_track_position(meStreamPlay);
//show_message("L : "+string(streamLength)+" - P : "+string(streamPos));

//if (meStream != undefined)
//{
	//if (streamPos > streamLength)
	if (!audio_is_playing(meStream))
	{
		global.nspDsMap[?"ME_LOOPCOUNT"]++;
		ME_play_music(meSongName, false);
	}
//}