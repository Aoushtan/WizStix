enum network
{
	player_establish,
	player_connect,
	player_joined,
	player_disconnect,
	move
}

client = network_create_socket(network_socket_tcp);
port = 65432;
network_connect(client,"174.81.255.120",port);

client_buffer = buffer_create(1024,buffer_fixed,1);

socket_to_instanceid = ds_map_create();