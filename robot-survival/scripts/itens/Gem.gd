class_name Gem extends Area2D

@export var expirience: float
@export var health: float

@export var knockback_force: float
@export var knockback_timer: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var knockback: Vector2
var knockback_on: bool = false
var knockback_timer_max: float


func _physics_process(delta: float) -> void:
	if knockback_timer > 0.0 and knockback_on:
		knockback_timer -= delta
		
		if knockback_timer < (knockback_timer_max / 2):
			
			position += knockback * delta
		else:
			position -= knockback * delta


func _on_body_entered(body: Node2D) -> void:
	if is_in_group("blue_gems"):
		body.update_experience(expirience)
	else:
		body.update_health(health)
	
	knockback_on = true
	
	knockback_timer_max = knockback_timer
	
	animation_player.play("pick_up")
	
	knockback = global_position.direction_to(body.position) * knockback_force
