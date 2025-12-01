extends Node

var level: float = 1.0
var expereince: float = 0.0

var enemies_kill: float = 0.0

signal expereince_bar_update(new_experience:float)
signal level_counter_update(new_level: float, experience_to_next_level: float)
signal enemies_kill_counter_update()


func expereince_update(new_experience:float) -> void:
	expereince = new_experience
	
	expereince_bar_update.emit(new_experience)


func level_counter(new_level: float, experience_to_next_level: float) -> void:
	level = new_level
	
	level_counter_update.emit(new_level, experience_to_next_level)


func enemies_kill_counter() -> void:
	enemies_kill += 1
	
	enemies_kill_counter_update.emit(enemies_kill)
	
