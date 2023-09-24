extends Node3D

var id : int # 0 is the default value

#@export var enabled_probability : int = 100
@export var enabled_timer_seconds = 10
@export var initial_ghost_state = 0
@export var stress_increase = 0
@export var label_text : String = "default text"
@export var enabled_sound : AudioStream = null
@export var ghost_dependency : Node3D = null
@export var debug : bool = false


var obj_anim : AnimatedSprite3D = null
var enabled_sound_player : AudioStreamPlayer3D = null
var disabled_sound_player : AudioStreamPlayer3D = null

var has_ghost_dependency = false;
var information_label : Label3D = null
var ghost_obj_action : bool = false
var ghost_obj_state : int = 0 # 0: disabled, 1: enabled
var on_timer = false
var actual_timer : Timer = null

var player : Node3D = null

signal on_ghost_enabled
signal on_ghost_disabled
signal on_add_stress(int)

func _ready():
	information_label = get_node("Label3D")
	obj_anim = get_node("AnimatedSprite3D")
	enabled_sound_player = get_node("AudioStreamPlayer3D_Enabled")
	disabled_sound_player = get_node("AudioStreamPlayer3D_Disabled")
	
	GlobalManager.electrical_supply.connect("on_electrical_turn_on", _on_electrical_supply, 0)
	
	
	if(enabled_sound_player != null): # sound plaº_on_interact_object
		enabled_sound_player.stream = enabled_sound
		
	if(ghost_dependency != null):
		has_ghost_dependency = true	
	ghost_obj_state = initial_ghost_state

	if information_label != null:
		information_label.text = ""	
		
	if debug != true:
		get_node("CollisionShape3D/MeshInstance3D").visible = false
		
	id = UtilsManager._generate_random_id()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") && ghost_obj_action == true) :
		print("_on_interact_object")
		_on_interact_object()
		
	#var val = UtilsManager._generate_random_value_between(0, 100000)
	#if(val < enabled_probability):
	if(ghost_obj_state == 0 && on_timer == false):
		if(has_ghost_dependency == true):
			if(ghost_dependency.ghost_obj_state == 1):			
				start_timer()			
		else:
			start_timer()
				
			
	#_process_ghost_dependency()
	
func start_timer():
	on_timer = true
	
	var timer = Timer.new()
	actual_timer = timer
	actual_timer.connect("timeout",_process_ghost_dependency, 0) 
	actual_timer.wait_time = enabled_timer_seconds
	actual_timer.one_shot = true
	add_child(actual_timer)
	actual_timer.start()

func _process_ghost_dependency():
	actual_timer.stop()	
	on_timer = false
	
	if(has_ghost_dependency == true):
			if(ghost_dependency.ghost_obj_state == 1):
				_on_enabled_object()
	else:
			_on_enabled_object()

func _on_electrical_supply():
	#actual_timer.stop()
	if(has_ghost_dependency == false):
		ghost_obj_state = 1
	
func _on_enabled_object():
	if(ghost_obj_state == 0):	
		print("_on_enabled_object")
		ghost_obj_state = 1
		
		if(enabled_sound != null):
			enabled_sound_player.play()
			
		obj_anim.play("on_enabled")
		
		on_ghost_enabled.emit()
		on_add_stress.emit(stress_increase)
	
func _on_interact_object():
	if(ghost_obj_state == 1):
		print("_on_interact_object")
		ghost_obj_state = 0
	
		disabled_sound_player.play()
		obj_anim.play("on_disabled")
	
		enabled_sound_player.stop()
		
		on_ghost_disabled.emit()
		on_add_stress.emit(stress_increase * -1)
	
	
## events
func _on_body_entered(body:Node3D):
	print("body entered")

	if(ghost_obj_state == 1):
		information_label.text += label_text + "\n"
		ghost_obj_action = true
		
	player = body
	
func _on_body_exited(body:Node3D):
	print("body exit")
		
	information_label.text = ""		
	ghost_obj_action = false
	
	player = null
