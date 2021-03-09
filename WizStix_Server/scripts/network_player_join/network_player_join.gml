function network_player_join(_username){
	
	//Create object player in server
	var _player = instance_create_depth(playerSpawn_x,playerSpawn_y,depth,o_player);
	_player.username = _username; //Give player username
	
	//Add instanceId of object player to socket map
	ds_map_add(socket_to_instanceid,socket,_player);
	
	#region Create object player for connecting client
	buffer_seek(server_buffer,buffer_seek_start,0);
	buffer_write(server_buffer,buffer_u8,network.player_connect);
	buffer_write(server_buffer,buffer_u8,socket);
	buffer_write(server_buffer,buffer_u16,_player.x);
	buffer_write(server_buffer,buffer_u16,_player.y);
	buffer_write(server_buffer,buffer_string,_player.username);
	network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
	#endregion
	
	#region Send player data for connected clients to connecting client
	var i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list,i);
		if _sock != socket
		{
			var _slave = ds_map_find_value(socket_to_instanceid,_sock);
			buffer_seek(server_buffer,buffer_seek_start,0);
			buffer_write(server_buffer,buffer_u8,network.player_joined);
			buffer_write(server_buffer,buffer_u8,_sock);
			buffer_write(server_buffer,buffer_u16,_slave.x);
			buffer_write(server_buffer,buffer_u16,_slave.y);
			buffer_write(server_buffer,buffer_string,_slave.username);
			network_send_packet(socket,server_buffer,buffer_tell(server_buffer));
		}
		i+=1;
	}
	#endregion
		
	#region Send connected clients data for connecting client
	var i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list,i);
		if _sock != socket
		{
			buffer_seek(server_buffer,buffer_seek_start,0);
			buffer_write(server_buffer,buffer_u8,network.player_joined);
			buffer_write(server_buffer,buffer_u8,socket);
			buffer_write(server_buffer,buffer_u16,_player.x);
			buffer_write(server_buffer,buffer_u16,_player.y);
			buffer_write(server_buffer,buffer_string,_player.username);
			network_send_packet(_sock,server_buffer,buffer_tell(server_buffer));
		}
		i+=1;
	}
	#endregion
}