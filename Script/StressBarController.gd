extends Control

@export var streess_bar_max_value : float = 100.0
@export var process_stress_time : float = 0.1
@export var stress_decrease : float = 0.25

var texture_progress_bar : TextureProgressBar = null

var actual_stress_value : float = 0.0
var timer : Timer = null

signal on_time_over


# Called when the node enters the scene tree for the first time.
func _ready():
	texture_progress_bar = get_node("TextureProgressBar")
	
	if(texture_progress_bar != null):
		texture_progress_bar.max_value = streess_bar_max_value
		texture_progress_bar.value = 0.0
	
		
	timer = Timer.new()
	timer.set_wait_time(process_stress_time)  
	timer.set_one_shot(false) 
	timer.connect("timeout", _process_stress, 0)
	add_child(timer)
	timer.start()
	
func _process_stress():
	if(texture_progress_bar.value < 100.0):
		texture_progress_bar.value += actual_stress_value - stress_decrease
	else:
		print("GAME OVER")
		timer.stop()
		on_time_over.emit(true)
		
func set_actual_stress(value : float):
	actual_stress_value += value

