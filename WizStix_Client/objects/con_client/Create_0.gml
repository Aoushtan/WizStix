enum network
{
	player_establish,
	player_connect,
	player_joined,
	player_disconnect,
	move,
	chat
}

client = network_create_socket(network_socket_tcp);
port = 65432;
//127.0.0.1 for laptop local dev
//174.81.255.120 for desktop dev
network_connect(client,"174.81.255.120",port);

client_buffer = buffer_create(1024,buffer_fixed,1);

socket_to_instanceid = ds_map_create();