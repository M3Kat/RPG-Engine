/// @description Returns quantity of item inside inventory
/// @arg item_id

#region Temp variables

var itemID = argument0;

var quantity = 0;
var invLength = ds_list_size(global.INV_items);

var invArray;

var i;

#endregion

// Search inventory if item slot exists
for (i = 0; i < invLength; i++)
{
	// Search for item inside the list
	invArray = global.INV_items[| i];													// Copy item array from DS_LIST
	if (invArray[@ _invItemData.id] == itemID)											// Does ID correspond?
	{
		quantity = invArray[@ _invItemData.quantity];									// Copy quantity of existing item
		break;
	}		
}

return quantity;																		// Return result