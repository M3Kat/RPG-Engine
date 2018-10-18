test = 125
/*NPC_add_line_json(id, NPC_SCRIPT_ONTALK,
	"[test]");*/
NPC_add_line(id, NPC_SCRIPT_ONTALK, "Music?%CHOICE[Windows MIDI,Dragon Force,Solstice,Eternity,Bad Company]%");
NPC_add_line(id, NPC_SCRIPT_ONTALK, "%IF[VAR.TE_CHOICE,==,0]%%ME_PLAYMUSIC[_test]%%NEWLINE%");
NPC_add_line(id, NPC_SCRIPT_ONTALK, "%IF[VAR.TE_CHOICE,==,1]%%ME_PLAYMUSIC[_ttfaf]%%NEWLINE%");
NPC_add_line(id, NPC_SCRIPT_ONTALK, "%IF[VAR.TE_CHOICE,==,2]%%ME_PLAYMUSIC[_solstice]%%NEWLINE%");
NPC_add_line(id, NPC_SCRIPT_ONTALK, "%IF[VAR.TE_CHOICE,==,3]%%ME_PLAYMUSIC[_boss_eternity]%%NEWLINE%");
NPC_add_line(id, NPC_SCRIPT_ONTALK, "%IF[VAR.TE_CHOICE,==,4]%%ME_PLAYMUSIC[_badcompany]%%NEWLINE%");
NPC_add_line(id, NPC_SCRIPT_ONTALK, "All done!");