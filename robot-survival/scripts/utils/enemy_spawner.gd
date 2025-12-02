extends Node2D

@export var spawns: Array[SpawnInfo] = []

@onready var player = get_tree().get_first_node_in_group("player")

var time: float = 0.0

var enemy_spawn: Enemy

var counter: float

var view_port: Vector2
var top_left: Vector2
var top_right: Vector2
var botton_left: Vector2
var botton_right: Vector2

var position_side: String

var spawn_position_1: Vector2
var spawn_position_2: Vector2

var x_spawn: float
var y_spawn: float

@onready var timer: Timer = $Timer


func _on_timer_timeout() -> void:
	time += 1
	
	for spawn_info in spawns:
		if time > spawn_info.time_start and time < spawn_info.time_end:
			if spawn_info.spawn_delay_counter < spawn_info.enemy_spawn_delay:
				spawn_info.spawn_delay_counter += 1.0
			else:
				spawn_info.spawn_delay_counter = 0.0
				
				counter = 0
				
				while counter < spawn_info.enemy_num:
					enemy_spawn = spawn_info.enemy.instantiate()
					
					enemy_spawn.global_position = get_random_position()
					
					add_child(enemy_spawn)
					
					counter += 1


func get_random_position() -> Vector2:
	view_port = get_viewport_rect().size * randf_range(0.7, 0.8)

	top_left = Vector2(
		player.global_position.x - view_port.x / 2,
		player.global_position.y - view_port.y / 2)
	top_right = Vector2(
		player.global_position.x + view_port.x / 2,
		player.global_position.y - view_port.y / 2)
	botton_left = Vector2(
		player.global_position.x - view_port.x / 2,
		player.global_position.y + view_port.y / 2)
	botton_right = Vector2(
		player.global_position.x + view_port.x / 2,
		player.global_position.y + view_port.y / 2)
		
	position_side = ["up", "down", "right", "left"].pick_random()
	
	match position_side:
		"up":
			spawn_position_1 = top_left
			spawn_position_2 = top_right
		"down":
			spawn_position_1 = botton_left
			spawn_position_2 = botton_right
		"left":
			spawn_position_1 = top_left
			spawn_position_2 = botton_left
		"right":
			spawn_position_1 = top_right
			spawn_position_2 = botton_right
		
	x_spawn = randf_range(spawn_position_1.x, spawn_position_2.x)
	y_spawn = randf_range(spawn_position_1.y, spawn_position_2.y)
	
	return Vector2(x_spawn, y_spawn)
