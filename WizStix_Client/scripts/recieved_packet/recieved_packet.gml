// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

/// @function recieved_packet(buffer);
/// @param buffer
function recieved_packet(buffer){
	msgid = buffer_read(buffer,buffer_u8);
	
	switch(msgid)
	{
		case network.player_establish:
			var _socket = buffer_read(buffer,buffer_u8);
			global.mysocket = _socket;
			
			buffer_seek(client_buffer,buffer_seek_start,0);
			buffer_write(client_buffer,buffer_u8,network.player_establish);
			buffer_write(client_buffer,buffer_string,con_game.username);
			network_send_packet(client,client_buffer,buffer_tell(client_buffer));
			
			break;
		case network.player_connect:
			var _socket = buffer_read(buffer,buffer_u8);
			var _x = buffer_read(buffer,buffer_u16);
			var _y = buffer_read(buffer,buffer_u16);
			var _username = buffer_read(buffer,buffer_string);
			
			var _player = instance_create_depth(_x,_y,depth,o_player);
			_player.socket = _socket;
			_player.username = _username;
			
			ds_map_add(socket_to_instanceid,_socket,_player);
			
			break;
			
		case network.player_joined:
			var _socket = buffer_read(buffer,buffer_u8);
			var _x = buffer_read(buffer,buffer_u16);
			var _y = buffer_read(buffer,buffer_u16);
			var _username = buffer_read(buffer,buffer_string);
			
			var _slave = instance_create_depth(_x,_y,depth,o_slave);
			_slave.socket = _socket;
			_slave.username = _username;
			
			ds_map_add(socket_to_instanceid,_socket,_slave);
			
			break;
			
		case network.player_disconnect:
			var _socket = buffer_read(buffer,buffer_u8);
			var _player = ds_map_find_value(socket_to_instanceid,_socket);
			
			with(_player)
			{
				instance_destroy();
			}
			
			ds_map_delete(socket_to_instanceid,_socket);
			
			break;
		
		case network.move:
			var _sock = buffer_read(buffer,buffer_u8);
			var move_x = buffer_read(buffer,buffer_u16);
			var move_y = buffer_read(buffer,buffer_u16);
			
			_player = ds_map_find_value(socket_to_instanceid,_sock);
			
			_player.x = move_x;
			_player.y = move_y;
			break;
	}
}