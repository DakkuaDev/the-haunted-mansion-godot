extends Node3D

@export var max_light_switched_on : int = 4
@export var label_text : String = "default text"
@export var turn_off_sound : AudioStream = null
@export var turn_on_sound : AudioStream = null
@export var debug : bool

var information_label : Label3D = null
var turn_off_sound_player : AudioStreamPlayer3D = null
var turn_on_sound_player : AudioStreamPlayer3D = null
var debug_mesh : MeshInstance3D = null

var actual_light_switched_on : int = 0
var light_array = []

var electrical_supply_action : bool = false

var is_down : bool = false;

signal on_electrical_turn_off
signal on_electrical_turn_on


# Called when the node enters the scene tree for the first time.
func _ready():
	
	GlobalManager.register_electrical_supply(self)
	
	information_label = get_node("Label3D")
	turn_off_sound_player = get_node("AudioStreamPlayer3D_turn_off")
	turn_on_sound_player = get_node("AudioStreamPlayer3D_turn_on")
	debug_mesh = get_node("CollisionShape3D/MeshInstance3D")
	
	add_light(get_tree().root)
	print("Total Lights in Scene: " + str(light_array.size()))
	
	if(turn_off_sound != null):
		turn_off_sound_player.stream = turn_off_sound
		
	if(turn_on_sound != null):
		turn_on_sound_player.stream = turn_on_sound
		
	if debug != true:
		debug_mesh.visible = false	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") &&  electrical_supply_action == true :
		print("_on_interact_object")
		_on_interact_object()
	
func check_electrical_system(light_switched):
	actual_light_switched_on += light_switched
	if(actual_light_switched_on < 0): actual_light_switched_on = 0
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
	is_down = true
	turn_off_sound_player.play()
	
	on_electrical_turn_off.emit()
	
	
	#for light in light_array:
		#var ghost_object = light.room_light_obj
		#if(ghost_object):
			#ghost_object._on_enabled_object();
		#light.light_energy = 0
		
func turn_on_electrical_supply():
	is_down = false
	
	turn_on_sound_player.play()
	information_label.text = ""
	
	on_electrical_turn_on.emit()
	
	#for light in light_array:
		#var ghost_object = light.get_node("GhostObject")
		#if(ghost_object):
			#ghost_object._on_interact_object();
		
func _on_interact_object():
	electrical_supply_action = false
	turn_on_electrical_supply()
	
	
func _on_body_entered(body):
	print("body entered")

	if(is_down == true):
		information_label.text += label_text + "\n"
		electrical_supply_action = true


func _on_body_exited(body):
	print("body exit")
	electrical_supply_action = false
