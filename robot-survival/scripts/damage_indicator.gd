extends Node2D

@export var speed: float
@export var friction:float

var speed_max: float

@onready var label: Label = $Label
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var shift_direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	speed_max = speed

func _process(delta: float) -> void:
	if animation_player.is_playing():
		global_position += speed * delta * shift_direction
		
		speed = max(speed - friction * delta, 0)


func play_damage(damage: float) -> void:
	shift_direction = Vector2(randf_range(1, -1), randf_range(1, -1))
	
	speed = speed_max
	
	label.text = str(int(damage))
	
	animation_player.play("show_damage")
