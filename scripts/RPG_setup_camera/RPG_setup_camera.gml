/// @description Setup new camera

if (variable_global_exists("camera")) camera_destroy(global.camera);

global.camera = camera_create_view(0,0,320,240,0,oNPC_Player,-1,-1,160,120);

//Enable the use of views
view_enabled = true;

//Make view 0 visible
view_set_visible(0, true);

//Set the port bounds of view 0 to 640x480
view_set_wport(0, 320);
view_set_hport(0, 240);

view_set_camera(0, global.camera);

