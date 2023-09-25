extends CharacterBody3D

var animated_sprite : AnimatedSprite3D = null
var spot_light : SpotLight3D = null

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var is_going_right = false
var is_going_left = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	animated_sprite = get_node("AnimatedSprite3D")
	animated_sprite.play("idle")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
		
	## sprite animation
	if(direction.x == 0):
		animated_sprite.play("idle")
	
	if(direction.x < 0):
		animated_sprite.play("walk")
		animated_sprite.flip_h = true
			
	else: 
		if (direction.x > 0):
			animated_sprite.play("walk")
			animated_sprite.flip_h = false

	move_and_slide()
	
	
