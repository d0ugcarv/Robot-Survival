extends Panel

@onready var message: Label = $Message

func _ready() -> void:
	Global.end_game_type.connect(end_game)

func end_game(victory: bool) -> void:
	if victory:
		message.text = "Stage Complete"
	else:
		message.text = "Game Over"
	
	visible = true
	
	get_tree().paused = true


func _on_main_menu_pressed() -> void:
	TransitionControler.change_scene("res://scenes/ui/main_menu.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _input(event: InputEvent) -> void:
		if event.is_action_pressed("victory"):
			end_game(true)
		elif event.is_action_pressed("defeat"):
			end_game(false)
