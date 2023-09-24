extends Control

@export var game_over_menu : TextureRect = null
@export var win_menu : TextureRect = null
@export var main_menu : TextureRect = null


func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") && get_tree().paused == true):
		get_tree(). reload_current_scene()
		get_tree().paused = false
		

func on_game_over_menu(value):
	if(value):
		game_over_menu.visible = true
		get_tree().paused = true
		
		
	else: 
		game_over_menu.visible = false
	
func on_win_menu(value):
	if(value): win_menu.visible = true
	else: win_menu.visible = false
	
