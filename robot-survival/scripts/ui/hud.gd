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

@onready var level_up_menu: Panel = $LevelUpMenu
@onready var level_up_sound: AudioStreamPlayer2D = $LevelUpMenu/LevelUpSound

var tween: Tween

@onready var upgrade_options: VBoxContainer = $LevelUpMenu/UpgradeOptions
var upgrade_options_children: Array[Node]
var item_option: PackedScene = preload("res://scenes/ui/item_option.tscn")

var upgrade_option: TextureRect
var options: float = 0.0
var options_max: float = 3.0

var experience_max_new_level: float

@onready var pause: TextureRect = $Pause
@onready var endgame_screen: Panel = $EndgameScreen


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
	
	experience_max_new_level = experience_to_next_level
	
	level_up()


func enemies_kill_counter_update(new_enemies_kill: float) -> void:
	enemy_death_counter.text = str(int(new_enemies_kill))


func level_up() -> void:
	level_up_sound.play()
	
	options = 0
	
	while options < options_max:
		options += 1
		
		upgrade_option = item_option.instantiate()
		
		upgrade_option.selected_upgrade.connect(selected_upgrade)
		
		upgrade_options.add_child(upgrade_option)
	
	level_up_menu.visible = true
	
	tween = level_up_menu.create_tween()
	
	tween.tween_property(
		level_up_menu,
		"position",
		Vector2(310,180),
		0.2
		).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
		
	tween.play()
	
	pause.visible = true
	
	get_tree().paused = true


func selected_upgrade(_upgrade: Variant) -> void:
	upgrade_options_children = upgrade_options.get_children()
	
	for i in upgrade_options_children:
		i.queue_free()
	
	level_up_menu.visible = false
	
	level_up_menu.position = Vector2(1210.0, 155.0)
	
	get_tree().paused = false
	
	pause.visible = false
	
	experience_bar.max_value = experience_max_new_level


func _input(event: InputEvent) -> void:
	if !level_up_menu.visible:
		if event.is_action_pressed("pause") and get_tree().paused == false:
			pause.visible = true
			
			get_tree().paused = true
		elif event.is_action_pressed("pause") and get_tree().paused == true:
			pause.visible = false
			
			get_tree().paused = false
