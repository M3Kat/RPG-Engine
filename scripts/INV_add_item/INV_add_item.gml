/// @description Add new item inside inventory
/// @arg item_id
/// @arg quantity

#region Temp variables

var itemID		= real(argument0);														// ID of item
var quantity	= real(argument1);														// Quantity of items

var invLength	= ds_list_size(global.INV_items);										// Length of inventory
var invArray;																			// Array to copy
var i;
#endregion

// Search inventory if item slot already exists
for (i = 0; i <= invLength; i++)
{
	// Search for item if not at the end of list
	if (i < invLength)
	{
		#region Search for item
		
		invArray = global.INV_items[| i];												// Copy item array from DS_LIST
		if (invArray[@ _invItemData.id] == itemID)										// Does ID correspond?
		{
			invArray[@ _invItemData.quantity] += quantity;								// Increase quantity of existing item
			break;
		}
		
		#endregion
	}
	else
	{
		#region Add new item
	
		invArray = array_create(_invItemData.enum_end, 0);								// Create new item array
		invArray[_invItemData.id]		 = itemID;										// Fill itemID data
		invArray[_invItemData.quantity]	+= quantity;									// Fill quantity data
		global.INV_items[| invLength]	 = invArray;									// Insert array inside DS_List
	
		#endregion
	}

}