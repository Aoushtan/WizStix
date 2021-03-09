if active = false
{
	//turn chat on
	active = true;
	//clear chat text
	keyboard_string = "";
	chat_text = "";
}
else
{
	//turn chat off
	active = false;
	
	chat_text = "SERVER: " + chat_text;
	ds_list_insert(global.chat,0,chat_text);
	ds_list_insert(global.chat_color,0,c_yellow);
	
	//send chat to all players
	var i = 0;
	repeat(ds_list_size(con_server.socket_list))
	{
		var _sock = ds_list_find_value(con_server.socket_list,i);
		buffer_seek(con_server.server_buffer,buffer_seek_start,0);
		buffer_write(con_server.server_buffer,buffer_u8,network.chat);
		buffer_write(con_server.server_buffer,buffer_string,chat_text);
		buffer_write(con_server.server_buffer,buffer_u8,2); //Yellow for server text
		network_send_packet(_sock,con_server.server_buffer,buffer_tell(con_server.server_buffer));
		i++;
	}
}