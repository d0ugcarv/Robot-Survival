class_name Enemy extends CharacterBody2D

@export var health: float
@export var speed: float
@export var attack_damage: float

var health_max: float
var is_alive: bool = true

@onready var player: Player = get_tree().get_first_node_in_group("player")
var direction_to_player: Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

@onready var hurt_box: Area2D = $HurtBox

var damage_indicator: PackedScene = preload("res://scenes/utils/damage_indicator.tscn")
var indicator: Node2D

@onready var drop_item: DropItens = $DropItem


func _ready() -> void:
	health_max = health


func _physics_process(delta: float) -> void:
	if is_alive and player != null:
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


func update_health(value: float) -> void:
	if health <= health_max and health >= 0.0:
		if (health + value) > health_max:
			health = health_max
		elif (health + value) <= 0:
			health = 0.0
			
			die()
		else:
			health += value


func die() -> void:
	is_alive = false
	
	Global.enemies_kill_counter()
	
	drop_item.drop_item()
	
	queue_free()


func _on_hurt_box_area_entered(area: Area2D) -> void:
	if !hurt_box.is_invincible:
		update_health(-area.attack_damage)
		
		area.hitbox_body_entered()
		
		spwan_attack_damage(area.attack_damage)


func spwan_attack_damage(damage: float) -> void:
	indicator = damage_indicator.instantiate()
	
	indicator.position = global_position
	
	get_tree().current_scene.add_child(indicator)
	
	indicator.play_damage(damage)
