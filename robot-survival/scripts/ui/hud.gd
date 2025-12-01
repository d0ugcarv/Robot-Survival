extends CanvasLayer


@onready var experience_bar: TextureProgressBar = $ExperienceBar
@onready var level_display: Label = $LevelDisplay

func _ready() -> void:
	level_display.text = "Level: " + str(1)
	experience_bar.value = 0.0
	experience_bar.max_value = 20
	
	Global.expereince_bar_update.connect(experience_bar_update)
	
	Global.level_counter_update.connect(level_counter_update)
	
	#Global.enemies_kill_counter_update(enemies_kill_counter_update)


func experience_bar_update(new_experience: float) -> void:
	experience_bar.value = int(new_experience)


func level_counter_update(new_level: float, experience_to_next_level) -> void:
	level_display.text = "Level: " + str(int(new_level))
	
	experience_bar.max_value = experience_to_next_level
