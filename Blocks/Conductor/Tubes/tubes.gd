extends Conductor

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block("Steam Tubes", Constants.BLOCK_ID["tubes"], output_dir, input_dir);
