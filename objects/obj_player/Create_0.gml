/// @description Movimentação e tiro
#region Função de vidas do player
// Vidas do player
lifes_player = 3;
///@method lose_life();
lose_life = function() {
	if lifes_player > 0 {
		lifes_player--;
		global.times_died++;	
		screenshake(5);
	} else {
		instance_destroy();
		screenshake(20);
	}
}
#endregion

#region Função de movimentação do player
_speed = 5;
movement = function() {
	var _left,_right,_up,_down;
	_left = keyboard_check(ord("A"));
	_right = keyboard_check(ord("D"));
	_up = keyboard_check(ord("W"));
	_down = keyboard_check(ord("S"));
	
	x += (_right - _left)*_speed;
	y += (_down - _up)*_speed;
	
	// Limitando o player para não sair da tela
	//if x <= 64 x = 64 else if x >= 1856 x = 1856
	//if y <= 64 y = 64 else if y >= 1024 y = 1024
	x = clamp(x, 64, 1856); y = clamp(y, 64, 1024);
}
#endregion

#region Funções de tiros
// Variáveis de tiro
speed_shot = 30;
was_fired = false;
shot_level = 1;

// Função de tiro
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
				double_shot();
			break;
			case 3:
				double_shot();
				instance_create_layer(x, _y, "Instances", obj_shot_player);
			break;
			case 4:
			 triple_shot();
			break;
			case 5:
				double_shot();
				triple_shot();
			break;
		}
		audio_play_sound(snd_laser_two, 1, 0)
		if alarm[0] <= 0 alarm[0] = speed_shot;
	}
	//testes
	//if keyboard_check_pressed(vk_up) level_up(); else if keyboard_check_pressed(vk_down) shot_level--;
	//if keyboard_check_pressed(vk_left) shot_speed_up() else if keyboard_check_pressed(vk_right) speed_shot *= 1.1;
}

// Função de tiro duplo
double_shot = function() {
	var _y = y-sprite_height/2;
	// Tiro da esquerda
	var _shot_one = instance_create_layer(x-45, _y, "Instances", obj_shot_player_two);
	_shot_one.hspeed = -10;
	// Tiro da direita
	var _shot_two = instance_create_layer(x+45, _y, "Instances", obj_shot_player_two);
	_shot_two.hspeed = 10;
}

// Função do tiro triplo
triple_shot = function() {
	var _y = y-sprite_height/2;
	/*	 Primeira maneira de fazer
	var _shot = instance_create_layer(x, _y+10, "Instances", obj_shot_player);
	_shot.direction = 90;_shot.image_angle = _shot.direction-90;
	var _shot_two = instance_create_layer(x, _y+10, "Instances", obj_shot_player);
	_shot_two.direction = 90+45;_shot_two.image_angle = _shot_two.direction-90;
	var _shot_three = instance_create_layer(x, _y+10, "Instances", obj_shot_player);
	_shot_three.direction = 90-45; _shot_three.image_angle = _shot_three.direction-90;
	*/ //E o mesmo resultado
	var _direction = 90+20;
	repeat 3 {
		var _shot = instance_create_layer(x, _y+10, "Instances", obj_shot_player);
		_shot.direction = _direction;_direction-=20;_shot.image_angle = _shot.direction-90;
	}
}
#endregion

#region Funções para upgrades
// Função para aumentar a velocidade do tiro
if instance_exists(obj_controller) {
	shot_speed_up = function() {
		if speed_shot >= 20 speed_shot *= .9; else obj_controller.earn_points(10);
	}

	// Função para aumentar a velocidade da nave
	player_speed_up = function() {
		if _speed < 8 _speed++; else obj_controller.earn_points(10);
	}

	// Função para subir de nivel
	level_up = function() {
		if shot_level < 5 shot_level++; obj_controller.earn_points(100);
	}
}
#endregion

#region Função do escudo
shields = 3;
actived_shield = false;
active_shield = function() {
	if keyboard_check_pressed(ord("E")) and shields > 0 and not actived_shield {
		instance_create_layer(x, y, "Instance_shield", obj_shield);
		obj_shield.target = id;
		actived_shield = true;
		shields--;
	}
}
#endregion
