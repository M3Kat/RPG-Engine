/// @description Set new sprite for NPC
/// @arg argarray(sprite_name)

var spriteName	= string(TE_get_variable(argument0[@0]));

with (parent_caller)
{
	NPC_load_sprite(spriteName);
}