extends Node3D

@export var previous_door : Node3D = null
@export var next_door : Node3D = null
@export var previous_door_label : String = "default text"
@export var next_door_label : String = "default text"
@export var debug : bool = false


var information_label : Label3D = null
var next_door_action : bool = false
var previous_door_action : bool = false

var player : Node3D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	information_label = get_node("Label3D")
	if information_label != null:
		information_label.text = ""	
		
	if debug != true:
		get_node("CollisionShape3D/MeshInstance3D").visible = false
	

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_up") && previous_door_action == true :
		print("ui_up")
		
		if(player != null):
			player.position = previous_door.position
			
	if Input.is_action_just_pressed("ui_down") && next_door_action == true :
		print("ui_down")
		
		if(player != null):
			player.position = next_door.position
		
	
# Called when the body enters the collision shape.
func _on_body_entered(body:Node3D):
	print("body entered")

	if(previous_door != null):
		information_label.text += previous_door_label + "\n"
		previous_door_action = true
	if(next_door != null):
		information_label.text += next_door_label + "\n"
		next_door_action = true
		
	player = body
			


# Called when the body exits the collision shape
func _on_body_exited(body:Node3D):
	print("body exit")
		
	information_label.text = ""		
		
	previous_door_action = false
	next_door_action = false
	
	player = null
	
