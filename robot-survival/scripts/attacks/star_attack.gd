extends Node2D

var star: PackedScene = preload("res://scenes/attacks/star.tscn")

var star_level: float = 1.0
var star_amount: float = 3.0

var star_attack: Area2D

var cluster: Array[Node2D] = []
var cluster_angle: float


func attack() -> void:
	if cluster.size() < star_amount:
		cluster_angle = 0.0
		
		for i in ( star_amount - cluster.size()):
			star_attack = star.instantiate()
			
			star_attack.global_position = position
			
			star_attack.level = star_level
			
			cluster.append(star_attack)
			
			call_deferred("add_child", star_attack)
		
		for i in cluster.size():
			cluster_angle += (2 * PI) / cluster.size()

			cluster[i].angle = cluster_angle
