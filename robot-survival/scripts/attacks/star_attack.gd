extends Node2D

var star: PackedScene = preload("res://scenes/attacks/star.tscn")

var star_level: float = 1.0
var star_amount: float = 2.0

var star_attack: Area2D

var star_amount_anterior: float = 0.0


func attack() -> void:
	if star_amount_anterior <= star_amount:
		for i in ( star_amount - star_amount_anterior):
			star_attack = star.instantiate()
			
			star_attack.global_position = position
			
			star_attack.level = star_level
			
			star_attack.angle = 0
