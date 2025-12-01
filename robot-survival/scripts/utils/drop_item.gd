class_name DropItens extends Node2D


@export var item_drop: Array[PackedScene]
@export var item_drop_chance: Array[float]

var total_weight:float

var rand: float
var update_drop_value:float

var item: Node2D


func _fix_item_drop_arrays() -> void:
	if item_drop_chance.size() < item_drop.size():
		item_drop_chance.resize(item_drop.size())
	elif item_drop_chance.size() > item_drop.size():
		item_drop.resize(item_drop_chance.size())
		
	for i in item_drop_chance:
		if i <= 0.0:
			i = 0.1


func drop_item() -> void:
	_fix_item_drop_arrays()
	
	total_weight = 0.0
	
	for weight in item_drop_chance:
		total_weight += weight
	
	rand = randf_range(0.0, total_weight)
	
	update_drop_value = 0.0
	
	for i in item_drop_chance.size():
		update_drop_value += item_drop_chance[i]
		
		if rand <= update_drop_value:
			if item_drop[i] == null:
				return
			
			item = item_drop[i].instantiate()
			
			item.global_position = global_position
			
			get_tree().current_scene.call_deferred("add_child", item)
			
			break
