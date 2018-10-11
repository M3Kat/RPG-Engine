/// @description Parse command to script
/// @arg argarray(itemID,quantity)

var itemID		= TE_get_variable(argument0[@0]);
var quantity	= TE_get_variable(argument0[@1]);

INV_add_item(itemID, quantity);