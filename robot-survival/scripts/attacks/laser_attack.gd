extends Node2D

var laser: PackedScene = preload("res://scenes/attacks/laser.tscn")

@onready var laser_timer: Timer = $LaserTimer
@onready var laser_attack_timer: Timer = $LaserTimer/LaserAttackTimer

#Lasers
var laser_level: float = 1.0
var laser_baseamno: float = 1.0

var laser_ammo: float = 0.0
var laser_attack_speed: float = 0.8
var laser_attack: Area2D

@onready var enemy_detection_area: Area2D = $"../../EnemyDetectionArea"


func attack() -> void:
	if laser_level > 0:
		laser_timer.wait_time = laser_attack_speed
		
		laser_attack_timer.wait_time = laser_attack_speed / 10.0
		
		if laser_timer.is_stopped():
			laser_timer.start()


func _on_laser_timer_timeout() -> void:
	laser_ammo += laser_baseamno

	laser_attack_timer.start()


func _on_laser_attack_timer_timeout() -> void:
	if enemy_detection_area.enemy_close.size() == 0.0:
		_on_player_stop_attack()
	
	if laser_ammo > 0.0:
		laser_attack = laser.instantiate()
		
		laser_attack.position = position
		
		laser_attack.target = enemy_detection_area.get_random_target()
		
		laser_attack.level = laser_level
		
		add_child(laser_attack)
		
		laser_ammo -= 1.0
		
		if laser_ammo > 0.0:
			laser_attack_timer.start()
		else:
			laser_attack_timer.stop()


func _on_player_stop_attack() -> void:
	laser_timer.stop()
