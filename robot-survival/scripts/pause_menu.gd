extends Control


@onready var pause_menu: Control = $"."
@onready var pause_buttons: VBoxContainer = $PauseButtons


func _ready() -> void:
	pause_menu.visible = false
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and get_tree().paused == false:
		pause()
	elif event.is_action_pressed("pause") and get_tree().paused == true:
		resume()


func pause() -> void:
	get_tree().paused = true
	
	pause_menu.visible = true


func resume() -> void:
	get_tree().paused = false
	
	pause_menu.visible = false


func _on_resume_pressed() -> void:
	resume()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	TransitionControler.change_scene("res://scenes/ui/main_menu.tscn")
	
	

func _on_exit_pressed() -> void:
	get_tree().quit()
