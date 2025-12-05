extends TextureRect

var mouse_over: bool = false

var item: Area2D = null
var player: Player

signal selected_upgrade(upgrade)


func _input(event: InputEvent) -> void:
	if event.is_action("left_click"):

		if mouse_over:
			emit_signal("selected_upgrade", item)


func _on_mouse_entered() -> void:
	mouse_over = true


func _on_mouse_exited() -> void:
	mouse_over = false
