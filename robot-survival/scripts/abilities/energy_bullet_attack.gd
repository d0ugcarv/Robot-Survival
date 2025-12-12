extends Node2D

var energy_bullet: PackedScene = preload("res://scenes/abilities/energy_bullet.tscn")

@onready var period_timer: Timer = $PeriodTimer
@onready var frequency_timer: Timer = $PeriodTimer/FrequencyTimer

#energy_bullets
var level: float = 0.0
var baseamno: float = 0.0
var attack_speed: float = 0.0

var ammo: float = 0.0
var energy_bullet_attack: Area2D

@onready var enemy_detection_area: Area2D = $"../../EnemyDetectionArea"


func attack() -> void:
	if level > 0:

		period_timer.wait_time = attack_speed
		
		frequency_timer.wait_time = attack_speed / 10.0
		
		if period_timer.is_stopped():
			period_timer.start()


func _on_period_timer_timeout() -> void:
	ammo += baseamno

	frequency_timer.start()


func _on_frequency_timer_timeout() -> void:
	if enemy_detection_area.enemy_close.size() == 0.0:
		_on_player_stop_attack()
	
	if ammo > 0.0:
		energy_bullet_attack = energy_bullet.instantiate()
		
		energy_bullet_attack.position = position
		
		energy_bullet_attack.target = enemy_detection_area.get_random_target()
		
		energy_bullet_attack.level = level
		
		add_child(energy_bullet_attack)
		
		ammo -= 1.0
		
		if ammo > 0.0:
			frequency_timer.start()
		else:
			frequency_timer.stop()


func _on_player_stop_attack() -> void:
	period_timer.stop()
