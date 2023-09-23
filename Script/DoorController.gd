extends Node3D


@export var id : int = 0 # 0 is the default value
@export var previous_door : Node3D = null
@export var next_door : Node3D = null

var information_label : Label3D = null
var next_door_action : bool = false
var previous_door_action : bool = false

var player : Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	information_label = get_node("Label3D")
	if information_label != null:
		information_label.text = ""	
	pass

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up") && previous_door_action == true :
		print("ui_up")
		
		if(player != null):
			player.transform = previous_door.transform
			
	if Input.is_action_just_pressed("ui_down") && next_door_action == true :
		print("ui_down")
		
		if(player != null):
			player.transform = next_door.transform
		
	
# Called when the body enters the collision shape.
func _on_body_entered(body:Node3D):
	print("body entered")

	if(previous_door != null):
		information_label.text += "Subir (W) \n"
		previous_door_action = true
	if(next_door != null):
		information_label.text += "Bajar (S) \n"
		next_door_action = true
		
	player = body
			



func _on_body_exited(body:Node3D):
	print("body entered")
		
	information_label.text = ""		
		
	previous_door_action = false
	next_door_action = false
	
	player = null
	
