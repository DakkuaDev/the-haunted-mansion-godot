extends OmniLight3D

@export var default_energy_value : float = 5

var is_down = false;

func _ready():
	on_turn_off_light()
	GlobalManager.electrical_supply.connect("on_electrical_turn_off", _on_electrical_supply_turn_off, 0)
	
func on_turn_on_light():
	is_down = false;
	light_energy = default_energy_value
	GlobalManager.electrical_supply.check_electrical_system(1)

func on_turn_off_light():
	is_down = true;
	light_energy = 0
	GlobalManager.electrical_supply.check_electrical_system(-1)
	
	
## events
func _on_ghost_enabled_signal():
	on_turn_off_light()

func _on_ghost_disabled_signal():
	on_turn_on_light()

func _on_electrical_supply_turn_off():
	on_turn_off_light()
