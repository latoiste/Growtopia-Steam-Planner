extends Conductor

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = [Constants.DOWN];

func enter():
	super();
	new_block(BlockID.FUNNELDOWN, output_dir, input_dir);
	
func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR):
	return super();
