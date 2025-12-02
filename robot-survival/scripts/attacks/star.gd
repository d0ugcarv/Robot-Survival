extends Area2D

var level: float = 1.0
var attack_damage: float
var speed: float 
var knock_back: float

@export var angle: float = 0.0 # in degrees
@export var radius: float = 80.0

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	angle = deg_to_rad(angle)
	print("tsrs")
	match level:
		1.0:
			level = 1.0
			speed = 0.8
			attack_damage = 2.0


func _physics_process(delta: float) -> void:
	angle += PI * delta * speed
	
	#animated_sprite_2d.rotation += rad_to_deg(angle * delta)
	
	position = Vector2(
		sin(angle) * radius,
		cos(angle) * radius
		)


func hitbox_body_entered() -> void:
	pass
