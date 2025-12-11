extends Node2D

var orbiting_star: PackedScene = preload("res://scenes/attacks/orbiting_star.tscn")

var level: float = 0.0
var amount: float = 0.0

var level_base: float = 0.0

var orbiting_star_attack: Area2D

var cluster: Array[Node2D] = []
var cluster_angle: float


func attack() -> void:
	if level_base < level:
		restart_orbity()
		
		level_base = level
	
	if cluster.size() < amount and level > 0.0:
		cluster_angle = 0.0
		
		for i in ( amount - cluster.size()):
			orbiting_star_attack = orbiting_star.instantiate()
			
			orbiting_star_attack.global_position = position
			
			orbiting_star_attack.level = level
			
			cluster.append(orbiting_star_attack)
			
			call_deferred("add_child", orbiting_star_attack)
		
		for i in cluster.size():
			cluster_angle += (2 * PI) / cluster.size()

			cluster[i].angle = cluster_angle

func restart_orbity() -> void:
	for i in cluster:
		i.queue_free()
		
	cluster.clear()
