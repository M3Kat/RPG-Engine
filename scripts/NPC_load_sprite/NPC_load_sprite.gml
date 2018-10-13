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
if (file_exists("actor/"+jsonname+"/data.json"))
{
	// Has sprite already been loaded before?
	if (global.npcSpriteMap[?string(jsonname)])
	{
		#region Load JSON data parameters
	
		jsonfile = file_text_open_read("actors/"+jsonname+"/data.json");		// Open json file
		while (!file_text_eof(jsonfile))
		{
			jsonstring = string_insert(file_text_readln(jsonfile), jsonstring, string_length(jsonstring));
		}
		file_text_close(jsonfile);
	
		#endregion
	
		#region Decode JSON file
	
		jsonmap = json_decode(jsonstring);
	
		#endregion
		
		#region Build "Sprite_Grid" && Load sprites into game if new.
		
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
		// Load every sprites
		for (i = 0; i < _npcAnimState.enum_end; i++)
		{
			var token = global.tokenNPCAnimState[i];
			if (ds_map_exists(jsonmap, token))
			{
				// Access child map entry inside main DS
				jsonmapchild = jsonmap[? token];
				// Create sprite array
				spritearray = spritearraytemplate;
				// Copy parameters into array
				for (j = 0; j < _npcAnimData.enum_end; j++)
				{
					var tokenchild = global.tokenNPCAnimData[j];					// Fetch token name
					if (ds_map_exists(jsonmapchild, tokenchild))					// Does JSON contains entry for token?
					{
						spritearray[j] = jsonmapchild[? tokenchild];				// Copy parameter into array
					}
				}
				// Copy sprite list to "tmpspritelist"
				tmpspritelist = spritearray[0];
				// Load-in sprites
				for (j = 0; j < _npcOrientation.enum_end; j++)
				{
					sprfilename = string(jsonname) + "/" + string(tmpspritelist[| j]);
					// Does file exists?
					if (file_exists("actor/"+jsonname+"/"+sprfilename))
					{
						// Has file already been loaded before?
						if (!ds_map_exists(global.actorSpriteUniqueID, sprfilename))
						{
							// File was never loaded before; Create new sprite
							var tfimg	= spritearray[_npcAnimData.animFrames];
							var tfspd	= spritearray[_npcAnimData.animSpeed];
							var tfox	= spritearray[_npcAnimData.originX];
							var tfoy	= spritearray[_npcAnimData.originY];
							sprfileid	= sprite_add("actor/"+sprfilename, tfimg, false, false, tfox, tfoy);
							
							// Add unique sprite ID inside global map
							global.actorSpriteUniqueID[? sprfilename] = sprfileid;
						}
						else
						{
							// Get stored sprite ID from global map
							sprfileid = global.actorSpriteUniqueID[? sprfilename];
						}
					}
					else
					{
						show_error("ERROR : File does not exists. Using failsafe instead.", false);
						sprfileid = sNPC_Failsafe;
					}
					// Set 
				}
				// Copy sprite data into 
				// Destroy child DS_MAP
				ds_map_destroy(jsonmapchild);
			}
		}
		
		#endregion
		
		
	}
	else
	{
		#region Copy indexed data
	
	
	
		#endregion
	}
}
