extends Node3D

	
func _generate_random_id():
	var id = randi()
	id = abs(id)
	
	return id
	
func _generate_random_value_between(minimum_value:int, max_value:int):
	# Genera un número aleatorio dentro del rango.
	var rnd = randf_range(minimum_value, max_value)

	return rnd
