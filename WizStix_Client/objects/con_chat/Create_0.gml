global.chat = ds_list_create();
global.chat_color = ds_list_create();

ds_list_add(global.chat,"Welcome to the multiplayer test!","","","","");
ds_list_add(global.chat_color,c_aqua,c_white,c_white,c_white,c_white);

active = false; //on and off switch
chat_size = 5; //how many chat messages are displayed
chat_text = ""; //chat message
