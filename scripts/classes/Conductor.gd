extends Block
class_name Conductor
signal recieve_power

var input_direction: Array[Vector2] = [];
var output_direction: Array[Vector2] = [];

func _on_recieve_power(prev_dir: Vector2):
	toggle();
	provide_power(prev_dir);

func set_direction(input_dir: Array[Vector2], output_dir: Array[Vector2]):
	input_direction = input_dir.duplicate();
	output_direction = output_dir.duplicate();

func toggle() -> void:
	pass;

func provide_power(prev_dir: Vector2) -> void:
	var prev_dir_index = output_direction.find(prev_dir);
	if prev_dir_index == -1:
		return;
	output_direction[prev_dir_index] = Constants.NO_DIR;
	#TODO STORE LATEST HORIZONTAL AND VERTICAL DIR OR JUST CHECK IDK LMAO
	var index = get_dir_index(output_direction);
	if index == -1:
		return;
	
	var surrounding_blocks = get_surrounding_blocks();
	var conductor: Conductor = surrounding_blocks[index];
	var new_prev_dir = Constants.ALL_DIR[index] * -1;
	
	send_power(conductor, new_prev_dir);
