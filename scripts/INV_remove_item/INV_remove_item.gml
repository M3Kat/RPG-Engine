/// @description Remove item inside inventory
/// @arg item_id
/// @arg quantity

#region Temp variables

var itemID		= real(argument0);														// ID of item
var quantity	= real(argument1);														// Quantity of items

var invLength	= ds_list_size(global.INV_items);										// Length of inventory
var invArray;																			// Array to copy
var i;
#endregion

// Search inventory if item slot exists
for (i = 0; i < invLength; i++)
{
	// Search for item inside the list
	invArray = global.INV_items[| i];													// Copy item array from DS_LIST
	if (invArray[@ _invItemData.id] == itemID)											// Does ID correspond?
	{
		invArray[@ _invItemData.quantity] -= quantity;									// Decrease quantity of existing item
		// Remove item if quantity is at 0
		if (invArray[@ _invItemData.quantity] <= 0)
		{
			ds_list_delete(global.INV_items, i);										// Remove item from list
		}
		break;
	}		
}