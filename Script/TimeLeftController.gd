extends Control

@export var initial_time_left : int = 60
var time_left : int = initial_time_left  
var timer : Timer
var label  : Label = null

signal on_time_out

func _ready():
	# Encuentra el nodo Timer y TextEdit en tu escena
	timer = get_node("Timer")
	label = get_node("Label")
	
	timer.wait_time = initial_time_left

	# Conecta la señal 'timeout' del temporizador a la función '_on_timer_timeout'
	timer.connect("timeout", _on_timer_timeout, 0)

	# Configura el tiempo inicial en el TextEdit
	label.text = "Time Left To Win: " + str(time_left)

	# Inicia el temporizador
	timer.start(1)  # Empezará a contar cada segundo

func _on_timer_timeout():
	# Actualiza el tiempo restante y el TextEdit
	time_left -= 1
	label.text = "Time Left To Win: " + str(time_left)

	# Si el tiempo llega a 0, emite la señal 'on_time_out' y detiene el temporizador
	if time_left <= 0:
		on_time_out.emit()
		timer.stop()

