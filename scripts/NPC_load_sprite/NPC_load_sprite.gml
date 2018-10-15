/// @description Loads an actor JSON file containing sprite data
/// @arg actor_name

#region Temp variables

var jsonname	= string(argument0);										// Name of folder
var jsonfile	= undefined;												// File ID if loaded
var jsonstring	= "";														// Full one-line string

var jsonmap;																// Decoded JSON
var jsonmapchild;															// Access DS_MAP entries ontained in main DS_MAP

var spritegrid;																// Grid containing sprite data
var spritearray;															// Tmp array for Sprite Grid, copied from template
var spritearraytemplate;													// Template for TMP array

var tmpspritelist;															// Tmp list containing sprite filenames

var sprfilename;															// Sprite name
var sprfileid;																// ID of loaded sprite

var i,j;

#endregion


// Does file exists?
if (file_exists(JSON_ACTORS_DIRECTORY+jsonname+"/data.json"))
{
	// Has sprite already been loaded before?
	if (!ds_map_exists(global.actorSpriteMap, jsonname))
	{
		#region Load JSON data parameters
	
		jsonfile = file_text_open_read(JSON_ACTORS_DIRECTORY+jsonname+"/data.json");		// Open json file
		while (!file_text_eof(jsonfile))
		{
			jsonstring = string_insert(file_text_readln(jsonfile), jsonstring, string_length(jsonstring));
		}
		file_text_close(jsonfile);
		
		// Remove all \n & \b & spaces
		
		jsonstring = string_replace_all(jsonstring, "\n", "");
		jsonstring = string_replace_all(jsonstring, "\b", "");
		jsonstring = string_replace_all(jsonstring, " ", "");
	
		#endregion
	
		#region Decode JSON file
	
		jsonmap = json_decode(jsonstring);
	
		#endregion
		
		#region Setup global data for "Sprite_Grid"    //     "Sprite_Grid" && load sprites into game if new.
		
		// Create grid
		spritegrid = ds_grid_create(_npcAnimState.enum_end, _npcOrientation.enum_end);
		
		// Create template array and fill it with content of "global" key
		spritearraytemplate = global.defaultNPCAnimData;
		if (ds_map_exists(jsonmap, "global"))
		{
			jsonmapchild = jsonmap[? "global"];
			// Copy parameters into array
			for (j = 0; j < _npcAnimData.enum_end; j++)
			{
				var tokenchild = global.tokenNPCAnimData[j];					// Fetch token name
				if (ds_map_exists(jsonmapchild, tokenchild))					// Does JSON contains entry for token?
				{
					spritearraytemplate[j] = jsonmapchild[? tokenchild];		// Copy parameter into array
				}
			}
			// Destroy DSMAP from "global" key
			ds_map_destroy(jsonmapchild);
		}
		
		#endregion
		
		#region Load sprites
		
		// Load every sprites
		for (i = 0; i < _npcAnimState.enum_end; i++)
		{
			var token = global.tokenNPCAnimState[i];
			// Does sprite entry exists?
			if (ds_map_exists(jsonmap, token))
			{
				#region Sprite entry exists : Load-in graphics and generate data
				
				// Access child map entry inside main DS
				jsonmapchild = jsonmap[? token];
				
				// Create sprite array
				spritearray = spritearraytemplate;										// Create new array using template
				
				// Copy parameters into array
				for (j = 0; j < _npcAnimData.enum_end; j++)
				{
					var tokenchild = global.tokenNPCAnimData[j];						// Fetch token name
					if (ds_map_exists(jsonmapchild, tokenchild))						// Does JSON contains entry for token?
					{
						spritearray[j] = jsonmapchild[? tokenchild];					// Copy parameter into array
					}
				}
				
				// Copy sprite list to "tmpspritelist"
				tmpspritelist = spritearray[0];
				
				// Insert sprite entries inside inside DS GRID
				for (j = 0; j < _npcOrientation.enum_end; j++)
				{
					sprfilename = string(jsonname) + "/" + string(tmpspritelist[| j]);
					// Does sprite file exists?
					if (file_exists(JSON_ACTORS_DIRECTORY+sprfilename))
					{
						#region Sprite file exists
						
						// Has file already been loaded before?
						if (!ds_map_exists(global.actorSpriteUniqueID, sprfilename))
						{
							#region File has not been loaded before : Load it
							
							// File was never loaded before : Create new sprite
							var tfimg	= spritearray[_npcAnimData.animFrames];										// Number of frames
							var tfspd	= spritearray[_npcAnimData.animSpeed] / tfimg;								// Speed of animation
							var tfox	= spritearray[_npcAnimData.originX];										// X origin
							var tfoy	= spritearray[_npcAnimData.originY];										// Y origin
							
							sprfileid	= sprite_add(JSON_ACTORS_DIRECTORY+sprfilename, tfimg, false, false, tfox, tfoy);		// Add new sprite to the game
							sprite_set_speed(sprfileid, tfspd, spritespeed_framespersecond);						//MAGICNUMBER// Set sprite speed
							
							// Add unique sprite ID inside global map
							global.actorSpriteUniqueID[? sprfilename] = sprfileid;
							
							#endregion
						}
						else
						{
							#region Sprite has been loaded before : Fetch sprite ID
							
							// Get stored sprite ID from global map
							sprfileid = global.actorSpriteUniqueID[? sprfilename];
							
							#endregion
						}
						
						#endregion
					}
					else
					{
						#region Sprite file doesn't exists : Use failsafe sprite instead
						
						show_error("ERROR : File does not exists. Using failsafe instead.", false);
						sprfileid = sNPC_Failsafe;
						
						#endregion
					}
					
					// Set array content
					spritearray[_npcAnimData.sprite] = sprfileid;
					
					// Paste data into DS GRID slot (Animation : Orientation)
					spritegrid[# i, j] = array_create(_npcAnimData.enum_end, undefined);		// Create new empty array inside DSGRID
					var len = array_length_1d(spritearray);										// Get length of current array
					array_copy(spritegrid[# i, j], 0, spritearray, 0, len);						// Copy array
					
				}
				// Copy sprite data into 
				// Destroy child DS_MAP
				ds_map_destroy(jsonmapchild);													// Destroy child map
				if (ds_exists(tmpspritelist, ds_type_list)) ds_map_destroy(tmpspritelist);		// Destroy sprite file list
				
				#endregion
			}
			else
			{
				#region Sprite entry does not exists : Generate failsafe data
				
				spritearray = spritearraytemplate;															// Get data template
				
				for (j = 0; j < _npcOrientation.enum_end; j++)
				{
					spritegrid[# i, j] = spritearray;
				}
				
				#endregion
			}
		}
		
		#endregion
		
		#region Paste grid into DS MAP
		
		global.actorSpriteMap[?jsonname] = spritegrid;
		
		#endregion
	}
	
	// Load sprite on this NPC
	sprite_grid = global.actorSpriteMap[?jsonname];						// Reference grid stored in global variable

}
else
{
	
	show_error("ERROR : Loading non-existant sprite.", false);				// Error message
	
}
