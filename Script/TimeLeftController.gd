extends Control

@export var initial_time_left : int = 120
@export var ticking_clock_sound : AudioStreamPlayer = null

var time_left : int = initial_time_left  
var timer : Timer

var texture_progress_bar : TextureProgressBar = null

signal on_time_out

func _ready():
	
	texture_progress_bar = get_node("TextureProgressBar")
	
	timer = get_node("Timer")
	
	timer.wait_time = initial_time_left
	timer.connect("timeout", _on_timer_timeout, 0)

	timer.start(1)  

func _on_timer_timeout():
	time_left -= 1
	texture_progress_bar.value = time_left
	#label.text = "Time Left To Win: " + str(time_left)
	
	if time_left == 16:
		ticking_clock_sound.play()

	if time_left <= 0:
		on_time_out.emit()
		timer.stop()

