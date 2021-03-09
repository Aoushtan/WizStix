enum network
{
	player_establish,
	player_connect,
	player_joined,
	player_disconnect,
	move,
	chat
}

port = 65432;
max_clients = 12;

//TCP for now but _us later if we want to do the browser game
network_create_server(network_socket_tcp,port,max_clients);

server_buffer = buffer_create(1024,buffer_fixed,1);
//DS list  for client data
socket_list = ds_list_create();
//System to hold all of the sockets of the player to get the instanceId
socket_to_instanceid = ds_map_create();

playerSpawn_x = 100 + irandom(10);
playerSpawn_y = 100 - irandom(10);