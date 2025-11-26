class_name Player extends CharacterBody2D

@export var health: float
@export var speed: float

var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO

@onready var health_bar: ProgressBar = $HealthBar
var health_max: float
var is_alive: bool = true

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	health_max = health
	
	health_bar.max_value = health_max
	health_bar.value = health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_alive:
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
		velocity = direction * speed * delta
		
		if direction != last_direction:
			last_direction = direction
		
		update_animation()
	
		move_and_slide()


func update_animation() -> void:
	# invert direction do sprite righ to left
	if direction.y == 0:
		if direction.x > 0:
			animated_sprite.flip_h = true
		elif direction.x < 0:
			animated_sprite.flip_h = false
	
		# manage sprite animation	
	if direction.y != 0 or direction.x != 0:
		animated_sprite.play("moving")
	else:
		animated_sprite.play("idle")

func update_health(value: float) -> void:
	if health <= health_max and health >= 0.0:
		if (health + value) > health_max:
			health = health_max
		elif (health + value) < 0:
			health = 0.0
			
			die()
		else:
			health += value
		
		health_bar.value = health

func die() -> void:
	is_alive = false
	
	animation_player.play("death")
