extends CanvasLayer


@onready var experience_bar: TextureProgressBar = $ExperienceBar
@onready var level_display: Label = $ExperienceBar/LevelDisplay
@onready var timer_display: Label = $ExperienceBar/TimerDisplay
@onready var enemy_death_counter: Label = $ExperienceBar/EnemyDeathCounter

var time: float
var time_seconds: float
var time_seconds_str: String
var time_minutes: float
var time_minutes_str: String


func _ready() -> void:
	level_display.text = "Level: " + str(1)
	
	enemy_death_counter.text = str(0)
	
	experience_bar.value = 0.0
	
	experience_bar.max_value = 20
	
	Global.expereince_bar_update.connect(experience_bar_update)
	
	Global.level_counter_update.connect(level_counter_update)
	
	Global.enemies_kill_counter_update.connect(enemies_kill_counter_update)

func _process(_delta: float) -> void:
	time = Global.time_max - Global.timer.time_left
	
	time_seconds = fmod(time, 60.0)
	time_minutes = time / 60
	
	if time_seconds < 10.0:
		time_seconds_str = "0" + str(int(time_seconds))
	else:
		time_seconds_str = str(int(time_seconds))
		
	if time_minutes < 10.0:
		time_minutes_str = "0" + str(int(time_minutes))
	else:
		time_minutes_str = str(int(time_minutes + Global.hour_counter * 60))
	
	if !Global.timer.is_stopped():
		timer_display.text = time_minutes_str + " : " + time_seconds_str


func experience_bar_update(new_experience: float) -> void:
	experience_bar.value = int(new_experience)


func level_counter_update(new_level: float, experience_to_next_level) -> void:
	level_display.text = "Level: " + str(int(new_level))
	
	experience_bar.max_value = experience_to_next_level


func enemies_kill_counter_update(new_enemies_kill: float) -> void:
	enemy_death_counter.text = str(int(new_enemies_kill))
