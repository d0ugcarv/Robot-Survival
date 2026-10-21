extends Control

@onready var main_buttons: VBoxContainer = $MainButtons


func _ready() -> void:
	TransitionControler.first_fade()
	
	main_buttons.visible = true


func _on_start_game_pressed() -> void:
	TransitionControler.change_scene("res://scenes/world.tscn")


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit()
