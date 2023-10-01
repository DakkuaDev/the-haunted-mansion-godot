extends Control

@export var game_over_menu : TextureRect = null
@export var win_menu : TextureRect = null
@export var main_menu : TextureRect = null
@export var pause_menu : TextureRect = null

@export var game_over_sound : AudioStreamPlayer = null
@export var win_sound : AudioStreamPlayer = null

var _inicialice = false;
var on_pause = false;
var on_end_game = false;


func _ready():
	main_menu.visible = true
	get_tree().paused = true


func _process(delta):
	
	if (Input.is_action_just_pressed("ui_pause_menu") && on_end_game != true && _inicialice == true):
		if(on_pause):
			on_pause = false
			pause_menu.visible = false
			get_tree().paused = false		
		else:
			on_pause = true
			pause_menu.visible = true
			get_tree().paused = true
	
	if (Input.is_action_just_pressed("ui_accept") && get_tree().paused == true && on_pause != true):
		if(_inicialice == true):
			get_tree(). reload_current_scene()
		else:
			main_menu.visible = false
			_inicialice = true
			
		get_tree().paused = false			
		

func on_game_over_menu(value):
	if(value):
		game_over_menu.visible = true
		get_tree().paused = true
		on_end_game = true
		game_over_sound.play()
		
	else: 
		game_over_menu.visible = false
	
func on_win_menu(value):
	if(value): 
		win_menu.visible = true
		get_tree().paused = true
		on_end_game = true
		win_sound.play()
		
	else: win_menu.visible = false
	
