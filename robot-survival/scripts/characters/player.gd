class_name Player extends CharacterBody2D

# health
@export var health: float
@onready var health_bar: ProgressBar = $HealthBar
var health_max: float
var is_alive: bool = true

# level
var level: float = 1.0
var experience: float = 0.0

# level progression
var base_experience: float = 20
var exponent_experience: float = 1.5
var experience_to_next_level: float

# movement
@export var speed: float
var direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# damage to de player
@onready var hurt_box: Area2D = $HurtBox
var invincibility_duration: float = 0.5

signal stop_attack


func _ready() -> void:
	health_max = health
	
	health_bar.max_value = health_max
	health_bar.value = health
	
	experience_to_next_level = next_level_experience()

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
		elif (health + value) <= 0:
			health = 0.0
			
			die()
		else:
			health += value
		
		health_bar.value = health


func experience_update(new_expirience: float) -> void:
	experience += new_expirience
	
	if  experience >= experience_to_next_level:
		experience -= experience_to_next_level
		
		level += 1
		
		experience_to_next_level = next_level_experience()
		
		Global.level_counter(level, experience_to_next_level)
	
	Global.expereince_update(experience)


func next_level_experience() -> float:
	return ceil(base_experience * (level ** exponent_experience))


func die() -> void:
	is_alive = false
	
	emit_signal("stop_attack")
	
	animation_player.play("death")


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if !hurt_box.is_invincible:
		update_health(body.attack_damage)
		
		hurt_box.start_invincibility(invincibility_duration)
