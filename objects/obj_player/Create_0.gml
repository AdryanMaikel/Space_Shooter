/// @description Movimentação e tiro
// Função de movimentação do player
_speed = 5;
movement = function() {
	var _left,_right,_up,_down;
	_left = keyboard_check(ord("A"));
	_right = keyboard_check(ord("D"));
	_up = keyboard_check(ord("W"));
	_down = keyboard_check(ord("S"));
	
	x += (_right - _left)*_speed;
	y += (_down - _up)*_speed;
}
// Função para atirar frequentemente
speed_shot = 30;
was_fired = false;
shot_level = 1;
shooting = function() {
	var _space = keyboard_check(vk_space);
	var _y = y-sprite_height/2;
	if _space and not was_fired {
		was_fired = true;
		switch shot_level {
			default:
				instance_create_layer(x, _y, "Instances", obj_shot_player);
			break;
			case 2:
				// Tiro da esquerda
				var _shot_one = instance_create_layer(x-45, _y, "Instances", obj_shot_player_two);
				_shot_one.hspeed = -10;
				// Tiro da direita
				var _shot_two = instance_create_layer(x+45, _y, "Instances", obj_shot_player_two);
				_shot_two.hspeed = 10;
			
			break;
			case 3:
			  // Tiro da esquerda
				
				var _shot_one = instance_create_layer(x-45, _y, "Instances", obj_shot_player_two);
				_shot_one.hspeed = -10;
				// Tiro do meio
				instance_create_layer(x, y, "Instances", obj_shot_player);
				// Tiro da direita
				var _shot_two = instance_create_layer(x+45, _y, "Instances", obj_shot_player_two);
				_shot_two.hspeed = 10;
				
			break;
		}
		if alarm[0] <= 0 alarm[0] = speed_shot;
	}
	//teste
	if keyboard_check_pressed(vk_up) shot_level++; else if keyboard_check_pressed(vk_down) shot_level--;
}
