extends OmniLight3D

@export var default_energy_value : float = 5

func _ready():
	light_energy = default_energy_value

func _on_room_light_on_ghost_disabled():
	light_energy = default_energy_value


func _on_room_light_on_ghost_enabled():
	light_energy = 0
