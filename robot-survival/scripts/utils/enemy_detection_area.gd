extends Area2D

#Enemy Related
var enemy_close: Array[Enemy] = []

@onready var energy_bullet_attack: Node2D = $"../Abilities/EnergyBulletAttack"
@onready var orbiting_star_attack: Node2D = $"../Abilities/OrbitingStarAttack"


func get_random_target() -> Vector2:
	if enemy_close.size() <= 0:
		return Vector2.UP
	else:
		return enemy_close.pick_random().global_position


func _on_body_entered(body: Node2D) -> void:
	orbiting_star_attack.attack()
	
	if !enemy_close.is_empty(): # To avoid targetless shots
		energy_bullet_attack.attack()
	
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_body_exited(body: Node2D) -> void:
	if enemy_close.has(body):
		enemy_close.erase(body)
