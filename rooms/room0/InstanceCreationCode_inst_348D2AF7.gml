test = 2
NPC_add_line(id, NPC_SCRIPT_ONTALK, "Am I a man or a woman?%CHOICE[Male,Female]%");
NPC_add_line(id, NPC_SCRIPT_ONTALK, "%IF[VAR.TE_CHOICE,==,0]%%NPC_LOAD_SPRITE[_default]%%NEWLINE%");
NPC_add_line(id, NPC_SCRIPT_ONTALK, "%IF[VAR.TE_CHOICE,==,1]%%NPC_LOAD_SPRITE[_woman]%%NEWLINE%");
NPC_add_script_json(id, NPC_SCRIPT_ONTALK,"_ralph");