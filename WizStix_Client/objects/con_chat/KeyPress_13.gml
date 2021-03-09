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
	if(chat_text != "")
	{
		//send data to server
		buffer_seek(con_client.client_buffer,buffer_seek_start,0);
		buffer_write(con_client.client_buffer,buffer_u8,network.chat);
		buffer_write(con_client.client_buffer,buffer_string,chat_text);
		network_send_packet(con_client.client,con_client.client_buffer,buffer_tell(con_client.client_buffer));
	}
}