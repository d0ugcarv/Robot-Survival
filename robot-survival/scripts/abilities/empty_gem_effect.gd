extends Area2D


var level: float = 0.0

func upgrade(levelup: float) -> void:
	level = levelup
	
	match levelup:
		1.0:
			scale = Vector2.ONE
		2.0:
			scale = Vector2.ONE * (1 + 0.4)
		3.0:
			scale = Vector2.ONE * (1 + 0.4 * 2)
		4.0:
			scale = Vector2.ONE * (1 + 0.4 * 4)
		5.0:
			scale = Vector2.ONE * (1 + 0.4 * 8)
