extends Area2D

var level: float 
var penetretion: float 
var speed: float 
var attack_damage: float 
var knock_back: float 

var attack_size: float = 1.0

var target: Vector2 = Vector2.ZERO
var direction: Vector2 = Vector2.ZERO

@onready var player: Player = get_tree().get_first_node_in_group("player")

var tween: Tween 


func _ready() -> void:
	direction = global_position.direction_to(target)
	
	rotation = direction.angle()
	
	match level:
		1.0:
			level = 1.0
			penetretion = 1.0
			speed = 200.0
			attack_damage = 5.0
			knock_back = 100.0

	tween = create_tween()
	
	tween.tween_property(
		self, "scale", Vector2(0.4, 0.4) * attack_size, 1
		).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.play()


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func enemy_hit(charge: float = 1.0) -> void:
	penetretion -= charge 
	
	if penetretion <= 0:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
