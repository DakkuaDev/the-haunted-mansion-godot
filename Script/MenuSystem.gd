extends Control

@export var game_over_menu : TextureRect = null
@export var win_menu : TextureRect = null
@export var main_menu : TextureRect = null

var _inicialice = false;


func _ready():
	main_menu.visible = true
	get_tree().paused = true


func _process(delta):
	
	if (Input.is_action_just_pressed("ui_accept") && get_tree().paused == true):
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
		
		
	else: 
		game_over_menu.visible = false
	
func on_win_menu(value):
	if(value): 
		win_menu.visible = true
		get_tree().paused = true
	else: win_menu.visible = false
	
