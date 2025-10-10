extends Conductor

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block(BlockID.TUBES, output_dir, input_dir);
