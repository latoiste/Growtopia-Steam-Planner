extends Block
class_name Source

var output_direction: Array[Vector2] = [];

func set_direction(output_dir: Array[Vector2]) -> void:
	if output_dir.is_empty():
		output_direction = Constants.ALL_DIR;
	else:
		output_direction = output_dir.duplicate();

func provide_power() -> void:
	var index = get_dir_index(output_direction);
	
	if index == -1:
		return;
	
	var surrounding_blocks: Array[Block] = get_surrounding_blocks();
	var conductor: Conductor = surrounding_blocks[index];
	var prev_dir: Vector2 = Constants.ALL_DIR[index];
	print("sent to!!", conductor)
	
	conductor.recieve_power.connect(conductor._on_recieve_power);
	conductor.recieve_power.emit(prev_dir);
