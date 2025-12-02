extends Node

var level: float = 1.0
var expereince: float = 0.0

var enemies_kill: float = 0.0

var timer: Timer
var time_max: float = 3600 # time in seconds
var hour_counter: float = 0.0
var hour_counter_is_active: bool

var victory_time: float = 600.0 # time need to win de game in seconds

signal expereince_bar_update(new_experience:float)
signal level_counter_update(new_level: float, experience_to_next_level: float)
signal enemies_kill_counter_update(new_enemies_kill: float)


func _ready() -> void:
	timer = Timer.new()
	
	timer.wait_time = time_max
	
	add_child(timer)
	
	timer.start()


func _process(_delta: float) -> void:
	if timer.time_left <= 1.0 and !hour_counter_is_active:
		hour_counter_is_active = true
		
		hour_counter += 1.0
	elif (timer.time_left >= time_max - 1.0) and hour_counter_is_active:
		hour_counter_is_active = false
	
	if get_tree().get_nodes_in_group("player").is_empty():
		if victory_time < (time_max - timer.time_left + hour_counter):
			print("Stage Complete")
		else:
			print("Game Over")
		
		get_tree().quit()


func expereince_update(new_experience:float) -> void:
	expereince = new_experience
	
	expereince_bar_update.emit(new_experience)


func level_counter(new_level: float, experience_to_next_level: float) -> void:
	level = new_level
	
	level_counter_update.emit(new_level, experience_to_next_level)


func enemies_kill_counter() -> void:
	enemies_kill += 1
	
	enemies_kill_counter_update.emit(enemies_kill)
	
