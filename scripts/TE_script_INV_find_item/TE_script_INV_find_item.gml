/// @description Parse command to script
/// @arg argarray(itemID)

var itemID		= TE_get_variable(argument0[@0]);

global.nspDsMap[?"INV_ITEMQUANTITY"] = INV_find_item(itemID);