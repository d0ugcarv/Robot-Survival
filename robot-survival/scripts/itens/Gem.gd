class_name Gem extends Area2D

@export var gem_type: String
@export var expirience: float
@export var health: float

@export var knockback_force: float
@export var knockback_timer: float

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var knockback: Vector2 = Vector2.ZERO
var knockback_on: bool = false
var knockback_timer_max: float

@onready var player: Player = get_tree().get_first_node_in_group("player")
var direction_to_player: Vector2 = Vector2.ZERO
var FOLLOW_SPEED: float = 4


func _physics_process(delta: float) -> void:
	if knockback_on:
		direction_to_player = (player.position - position).normalized()
		
		if knockback_timer > (knockback_timer_max / 2):
			if knockback_timer <= 0:
				knockback = Vector2.ZERO
			
			knockback_timer -= delta
			
			position -= knockback * delta
		else:
			var weight = 1 - exp(-FOLLOW_SPEED * delta)

			position = position.lerp(player.position + Vector2.UP * 32, weight)


func _on_body_entered(body: Node2D) -> void:
	if gem_type == "blue_gem":
		body.update_experience(expirience)
	elif gem_type == "red_gem":
		body.update_health(health)
	else:
		for i in get_tree().get_nodes_in_group("itens"):
			i._on_area_entered(self)
	
	animation_player.play("pick_up")


func _on_area_entered(_area: Area2D) -> void:
	if !knockback_on:
		knockback_on = true

		knockback_timer_max = knockback_timer
		
		knockback = global_position.direction_to(player.position) * knockback_force
