draw_set_halign(fa_left);
draw_set_valign(fa_middle);


for(var i = 0;i<chat_size;i++)
{
	draw_set_color(ds_list_find_value(global.chat_color,i));
	draw_text(100,360-(16*i),ds_list_find_value(global.chat,i));
}

if active = true
{
	draw_set_color(c_lime);
	draw_text(100,400,"> " + chat_text);
}
else
{
	draw_set_color(c_gray);
	draw_text(100,400,"> ");
}