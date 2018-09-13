/// @description Clear data structures & surface

ds_list_destroy(line);																				// Destroy line ds list
ds_list_destroy(char_list);																			// Destroy character ds list
ds_list_destroy(macro_list);																		// Destroy macro ds list

surface_free(surface);																				// Destroy surface