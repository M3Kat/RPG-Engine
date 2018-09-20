/// @description Creates new surface if older one doesn't exists anymore
if (!surface_exists(surface))
{
	surface = surface_create(surface_width, surface_height);
}