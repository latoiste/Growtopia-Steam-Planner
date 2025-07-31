extends Conductor

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = [Constants.UP];

func enter():
	super();
	new_block("funnelup", "conductor", output_dir, input_dir);
	
func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR):
	return super();
