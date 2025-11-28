extends Area2D

const coloren_duration: float = 0.2
@export var coloren_material: ShaderMaterial
#@onready var coloren_material: ShaderMaterial = "res://shaders/whiten.tres"

var is_invincible = false
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		coloren_material.set_shader_parameter("redden", true)
		
		await get_tree().create_timer(coloren_duration).timeout
		
		coloren_material.set_shader_parameter("redden", false)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("attack"):
		coloren_material.set_shader_parameter("whiten", true)
		
		await get_tree().create_timer(coloren_duration).timeout
		
		coloren_material.set_shader_parameter("whiten", false)


func start_invincibility(invincibility_duration: float) -> void:
	is_invincible = true
	
	collision_shape_2d.disabled = true
	
	await get_tree().create_timer(invincibility_duration).timeout
	
	collision_shape_2d.disabled = false
	
	is_invincible = false
	
