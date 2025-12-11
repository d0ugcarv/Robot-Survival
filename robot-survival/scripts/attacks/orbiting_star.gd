extends Area2D

var level: float = 0.0
var attack_damage: float = 0.0
var speed: float = 0.0
var knock_back: float

@export var angle: float = 0.0 # in degrees
@export var radius: float = 70.0

var radius_counter: float = 0.0

@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var tween: Tween
var attack_size: float = 1.0


func _ready() -> void:
	angle = angle

	match level:
		1.0:
			speed = 0.7
			attack_damage = 2.0
		2.0:
			speed = 0.8
			attack_damage = 3.0
		3.0:
			speed = 0.9
			attack_damage = 3.0
	
	tween = create_tween()
	
	tween.tween_property(
		self, "scale", Vector2(1, 1) * attack_size, 0.5
		).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	
	tween.play()


func _physics_process(delta: float) -> void:
	angle += PI * delta * speed
	
	#animated_sprite_2d.rotation += rad_to_deg(angle * delta)
	
	if radius_counter <= radius:
		radius_counter += delta * 50
	
	position = Vector2(
		sin(angle) * radius_counter,
		cos(angle) * radius_counter
		)


func hitbox_body_entered() -> void:
	pass
