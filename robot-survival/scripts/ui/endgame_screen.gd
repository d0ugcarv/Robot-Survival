extends Panel

@onready var message: Label = $Message

func _ready() -> void:
	Global.end_game.connect(end_game)

func end_game(victory: bool) -> void:
	if victory:
		message.text = "Stage Complete"
	else:
		message.text = "Game Over"
	
	visible = true
	
	get_tree().paused = true
	
