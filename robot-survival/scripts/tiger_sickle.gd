extends CharacterBody2D

@export var health: float
@export var speed: float
@export var attack_damage: float

var is_alive: bool = true

@onready var player: Player = get_tree().get_first_node_in_group("Player")
var direction_to_player: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if is_alive:
		direction_to_player = (player.position - position).normalized()
		
		velocity = direction_to_player * speed * delta
		
		update_animation()
		
		move_and_slide()

func update_animation() -> void:
	# invert direction do sprite righ to lefts
	if direction_to_player.x > 0:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true
	
	# manage sprite animation	
	animation_player.play("moving")
