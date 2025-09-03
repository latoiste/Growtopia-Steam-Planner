extends Conductor

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter() -> void:
	super();
	new_block("Steam Scrambler", Constants.BLOCK_ID["scrambler"], output_dir, input_dir);

func get_next_dir(prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	var valid_dirs: Array[Vector2];
	var random_index: int;
	
	for dir in Constants.ALL_DIR:
		if dir_is_valid(dir):
			valid_dirs.append(dir);
	valid_dirs.erase(prev_dir * -1);
	
	if valid_dirs.size() == 0:
		return Vector2.ZERO;
		
	random_index = randi_range(0, valid_dirs.size() - 1);
	
	return valid_dirs[random_index];
