extends Block
class_name Conductor
signal recieve_power

var input_direction: Array[Vector2] = [];
var output_direction: Array[Vector2] = [];

func _on_recieve_power(prev_dir: Vector2):
	pass;

func set_direction(input_dir: Array[Vector2], output_dir: Array[Vector2]):
	input_direction = input_dir.duplicate();
	output_direction = output_dir.duplicate();

func toggle() -> void:
	pass

func get_next_direction() -> Vector2:
	
	return Vector2.ZERO;
