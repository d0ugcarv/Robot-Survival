extends Timer

var time_max: float
var time: float

var time_seconds: float
var time_seconds_str: String
var time_minutes: float
var time_minutes_str: String

var hour_counter: float = 0.0
var hour_counter_is_active: bool

@export var victory_time: float # in seconds


func _ready() -> void:
	time_max = wait_time


func _process(_delta: float) -> void:
	hour_calculator()
	
	time = time_max - time_left
	
	if victory_time < (time + hour_counter):
		Global.end_game(true)


func time_string() -> String:
	time_seconds = fmod(time, 60.0)
	time_minutes = time / 60
	
	if time_seconds < 10.0:
		time_seconds_str = "0%d" %time_seconds
	else:
		time_seconds_str = "%d" %time_seconds
	
	if time_minutes < 10.0:
		time_minutes_str = "0%d" %time_minutes
	else:
		time_minutes_str = "%d" %(time_minutes + hour_counter * 60)
		
	return time_minutes_str + " : " + time_seconds_str


func hour_calculator() -> void:
	if time_left <= 1.0 and !hour_counter_is_active:
		hour_counter_is_active = true
		
		hour_counter += 1.0
	elif (time_left >= time_max - 1.0) and hour_counter_is_active:
		hour_counter_is_active = false
