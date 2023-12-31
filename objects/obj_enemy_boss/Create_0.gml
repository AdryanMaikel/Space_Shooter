/// @description 
//
state_actual = choose("state_one", "state_two", "state_three");
reset_delay =  game_get_speed(gamespeed_fps);
delay_shot = reset_delay;
delay_shot_two = game_get_speed(gamespeed_fps);
delay_state = game_get_speed(gamespeed_fps)*10;
next_state = delay_state;
speed_horizontal = 3;
goto_center = false;
left = true;
right = false;
maximum_life = 2000;
life = maximum_life;
created_children = false;

#region Tiros
///@method shot_one();
shot_one = function() {
	if not instance_exists(obj_enemy_boss) or not instance_exists(obj_player) exit;
	instance_create_layer(x, y+80, "Instances_shot_boss", obj_shot_alien);
	audio_play_sound(snd_laser_one, 1, 0);
}
///@method shot_two(bool);
shot_two = function(_direction) {
	if not instance_exists(obj_enemy_boss) or not instance_exists(obj_player) exit;
	var _position_x = 0;
	if _direction == left _position_x = -161 
	if _direction == right _position_x = 161;
	var _shot = instance_create_layer(x+_position_x, y+22, "Instances_shot_boss", obj_shot_octopus);
	_shot.image_xscale/=2; _shot.image_yscale/=2;
	audio_play_sound(snd_laser_two, 1, 0);
/* 
	var _shot_one = instance_create_layer(x-161, y+22, "Instances_shot_boss", obj_shot_octopus);
	_shot_one.image_xscale/=2; _shot_one.image_yscale/=2;
	var _shot_two = instance_create_layer(x+161, y+22, "Instances_shot_boss", obj_shot_octopus);
	_shot_two.image_xscale/=2; _shot_two.image_yscale/=2;
*/
		
}
#endregion

#region funções dos estados do boss
///@method state_one();
state_one = function() {
	delay_shot--;
	if delay_shot <= 0 {
		delay_shot = reset_delay/2;
		shot_one();
	}
}
///@method state_two();
state_two = function() {
	// Movimentação do boss
	x+=speed_horizontal;
	if x + sprite_width/2 >= room_width - 5 or x - sprite_width/2 <= 5 speed_horizontal*=-1;
	// Tiro
	delay_shot--;
	if delay_shot <= 0 {
		delay_shot = reset_delay;
		shot_two(left); shot_two(right);
	}
}
///@method state_three();
state_three = function() {
	delay_shot--;
	if delay_shot <= 0 {
		delay_shot = reset_delay;
		shot_one();
	}
	delay_shot_two--;
	if delay_shot_two <= 0 {
		delay_shot_two = reset_delay*2;
		shot_two(left); shot_two(right);
		
	}
}
///@method state_four();
state_four = function() {
	sprite_index = spr_enemy_boss_shield;
	if created_children {
		instance_create_layer(243, 573.639, "Instances", obj_children_boss);
		instance_create_layer(1680, 568.479, "Instances", obj_children_boss);
		created_children = false;
	}
}
#endregion
