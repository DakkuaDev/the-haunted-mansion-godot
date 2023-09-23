extends Node3D

@export var max_light_switched_on : int = 4

var actual_light_switched_on : int = 0
var light_array = []

var is_down : bool = false;


# Called when the node enters the scene tree for the first time.
func _ready():
	add_light(get_tree().root)
	print("Total Lights in Scene: " + str(light_array.size()))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func check_electrical_system(light_switched):
	actual_light_switched_on += light_switched
	if(actual_light_switched_on > max_light_switched_on):
		print("max_light_switched_on")
		turn_off_electrical_supply()

		
func add_light(node):
	# Recorre todos los hijos del nodo actual.
	for child in node.get_children():
		# Comprueba si el hijo es un nodo OmniLight3D.
		if child is OmniLight3D:
			# Si es un OmniLight3D, agrégalo a la lista.
			light_array.append(child)
		# Llama recursivamente a la función para continuar la búsqueda en los hijos de este nodo.
		add_light(child)
		
func turn_off_electrical_supply():
	for light in light_array:
		light.light_energy = 0
	
