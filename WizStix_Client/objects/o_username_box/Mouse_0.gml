if(con_game.username != "")
{
	exit;
}
con_game.username = get_string("Enter your username","");
if(string_length(con_game.username) > 24)
{
	show_message("Username too long");
	con_game.username = "";
}