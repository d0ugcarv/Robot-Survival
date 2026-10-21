extends CanvasLayer

@onready var world: Node2D = $"../.."

@onready var experience_bar: TextureProgressBar = $ExperienceBar
@onready var level_display: Label = $ExperienceBar/LevelDisplay
@onready var timer_display: Label = $ExperienceBar/TimerDisplay
@onready var enemy_death_counter: Label = $ExperienceBar/EnemyDeathCounter
@onready var level_clock: Timer = $LevelClock


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
	if !level_clock.is_stopped():
		timer_display.text = level_clock.time_string()


func experience_bar_update(new_experience: float) -> void:
	experience_bar.value = int(new_experience)


func level_counter_update(new_level: float, experience_to_next_level) -> void:
	experience_max_new_level = experience_to_next_level
	
	experience_bar.max_value = experience_max_new_level
	
	level_up()
	
	level_display.text = "Level: " + str(int(new_level))


func enemies_kill_counter_update(new_enemies_kill: float) -> void:
	enemy_death_counter.text = str(int(new_enemies_kill))


func level_up() -> void:
	level_up_sound.play()
	print("trs")
	options = 0
	
	while options < options_max:
		options += 1
		
		upgrade_option = item_option.instantiate()
		
		upgrade_option.item = UpgradeDb.get_random_upgrade()
		
		upgrade_option.selected_upgrade.connect(selected_upgrade) # connects instance
		
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
	
	get_tree().paused = true


func selected_upgrade(upgrade: Variant) -> void:
	# clean list of upgrades
	upgrade_options_children = upgrade_options.get_children()
	
	UpgradeDb.upgrades_options.clear()
	
	UpgradeDb.update_collected_upgrades(upgrade)

	for i in upgrade_options_children:
		i.queue_free()
	
	level_up_menu.visible = false
	
	level_up_menu.position = Vector2(1210.0, 155.0)
	
	get_tree().paused = false
