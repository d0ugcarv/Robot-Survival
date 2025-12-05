extends Area2D

const coloren_duration: float = 0.2

@onready var sprite_2d: Sprite2D
@onready var animated_sprite_2d: AnimatedSprite2D 

var is_invincible = false

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	animated_sprite_2d = $"../AnimatedSprite2D"
	
	if body.is_in_group("enemies"):
		animated_sprite_2d.material.set_shader_parameter("redden", true)

		await get_tree().create_timer(coloren_duration).timeout
		
		animated_sprite_2d.material.set_shader_parameter("redden", false)


func _on_area_entered(area: Area2D) -> void:
	sprite_2d = $"../Sprite2D"
	
	if area.is_in_group("attack"):
		sprite_2d.material.set_shader_parameter("whiten", true)
		
		await get_tree().create_timer(coloren_duration).timeout
		
		sprite_2d.material.set_shader_parameter("whiten", false)


func start_invincibility(invincibility_duration: float) -> void:
	is_invincible = true
	
	collision_shape_2d.set_deferred("disabled", true)
	
	await get_tree().create_timer(invincibility_duration).timeout
	
	collision_shape_2d.set_deferred("disabled", false)
	
	is_invincible = false
	
