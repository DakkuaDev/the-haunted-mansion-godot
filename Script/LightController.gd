extends OmniLight3D

@export var default_energy_value : float = 5

func _ready():
	on_turn_on_light()
	
	
func on_turn_on_light():
	light_energy = default_energy_value
	ElectricalSupplySystem.check_electrical_system(1)

func on_turn_off_light():
	light_energy = 0
	ElectricalSupplySystem.check_electrical_system(-1)
	
	
## events
func _on_room_light_on_ghost_disabled():
	on_turn_on_light()

func _on_room_light_on_ghost_enabled():
	on_turn_off_light()

