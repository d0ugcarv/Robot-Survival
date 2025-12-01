extends Node2D

var laser: PackedScene = preload("res://scenes/attacks/laser.tscn")

@onready var laser_timer: Timer = $LaserTimer
@onready var laser_attack_timer: Timer = $LaserTimer/LaserAttackTimer

#Laser
var laser_ammo: float = 0.0
var laser_baseamno: float = 1.0
@export var laser_attack_speed: float = 0.8
var laser_level: float = 1.0
var laser_attack: Area2D

#Enemy Related
var enemy_close: Array[Enemy] = []


func attack() -> void:
	if laser_level > 0:
		laser_timer.wait_time = laser_attack_speed
		
		laser_attack_timer.wait_time = laser_attack_speed / 10
		
		if laser_timer.is_stopped():
			laser_timer.start()


func _on_laser_timer_timeout() -> void:
	laser_ammo += laser_baseamno

	laser_attack_timer.start()


func _on_laser_attack_timer_timeout() -> void:
	if enemy_close.size() == 0:
		_on_player_attack_stop()
	
	if laser_ammo > 0:
		laser_attack = laser.instantiate()
		
		laser_attack.position = position
		
		laser_attack.target = get_random_target()
		
		laser_attack.level = laser_level
		
		add_child(laser_attack)
		
		laser_ammo -= 1
		
		if laser_ammo > 0:
			laser_attack_timer.start()
		else:
			laser_attack_timer.stop()


func get_random_target() -> Vector2:
	if enemy_close.size() <= 0:
		return Vector2.UP
	else:
		return enemy_close.pick_random().global_position


func _on_enemy_detection_area_body_entered(body: Enemy) -> void:
	if enemy_close.is_empty():
		attack()
	
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body: Enemy) -> void:
	if enemy_close.has(body):
		enemy_close.erase(body)


func _on_player_attack_stop() -> void:
	laser_timer.stop()
