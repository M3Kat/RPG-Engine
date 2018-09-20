/// @description Stream music!!! :D
/// @arg filename
/// @arg is_new_song

#region Temp variables

var file	= string(argument0);
var new		= argument1;

#endregion

global.nspDsMap[? "ME_MUSIC"] = file;

var pitch		= real(global.nspDsMap[? "ME_PITCH"])
var volume		= real(global.nspDsMap[? "ME_VOLUME"])
var loopcnt		= real(global.nspDsMap[? "ME_LOOPCOUNT"])

var streamid	= global.nspDsMap[? "ME_STREAM"];
var streamplay	= global.nspDsMap[? "ME_STREAMPLAY"];
var streamlength= global.nspDsMap[? "ME_LENGTH"];

// Stop & destroy stream if it exists
if (streamid != undefined)
{
	audio_stop_sound(streamid);
	audio_destroy_stream(streamid);
	streamid = undefined;
}

// Create stream
if (new && file_exists("music/"+file+"_intro.ogg"))
{
	streamid		= audio_create_stream("music/"+file+"_intro.ogg");
	//streamlength	= audio_sound_length(streamid);
}
else if (file_exists("music/"+file+".ogg"))
{
	streamid		= audio_create_stream("music/"+file+".ogg");
	//streamlength	= audio_sound_length(streamid);
}
else
{
	streamid	= undefined;
}

// If stream is created, play sound
if (streamid != undefined)
{
	streamplay	= audio_play_sound(streamid, 100, false);
	streamlength	= audio_sound_length(streamid);
	audio_sound_gain(streamplay, volume, 0);
	audio_sound_pitch(streamplay, pitch);
}

global.nspDsMap[? "ME_STREAM"]		= streamid;
global.nspDsMap[? "ME_STREAMPLAY"]	= streamplay;
global.nspDsMap[? "ME_LENGTH"]		= streamlength;

/*if (global.nspDsMap[? "ME_STREAM"] != undefined)
{
	audio_destroy_stream(global.nspDsMap[? "ME_STREAM"]);
}
var snd		= global.nspDsMap[? "ME_STREAM"];
var pitch	= real(global.nspDsMap[? "ME_PITCH"]);
var vol		= real(global.nspDsMap[? "ME_VOLUME"]);
var loopcnt	= real(global.nspDsMap[? "ME_LOOPCOUNT"]);
var play    = 0;
var length	= 0;
// Play intro if it exists
if (new && file_exists("music/"+file+"_intro.ogg"))
{
	loopcnt	= -1;
	snd		= audio_create_stream("music/"+file+"_intro.ogg");
}
else
{
	snd = audio_create_stream("music/"+file+".ogg");
}
play = audio_play_sound(snd, 100, false);
audio_sound_pitch(snd, pitch);
audio_sound_gain(snd, vol, 0);
length = audio_sound_length(play);

global.nspDsMap[? "ME_LOOPCOUNT"]	= loopcnt;
global.nspDsMap[? "ME_STREAM"]		= snd;
global.nspDsMap[? "ME_STREAMPLAY"]	= play;
global.nspDsMap[? "ME_LENGTH"]		= length;*/