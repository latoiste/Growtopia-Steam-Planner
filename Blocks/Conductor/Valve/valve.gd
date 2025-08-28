extends Conductor

@onready var sprite: Sprite2D = $Sprite2D;

const input_dir: Array[Vector2] = [Constants.UP, Constants.DOWN, Constants.RIGHT];
const output_dir: Array[Vector2] = [Constants.UP, Constants.DOWN, Constants.RIGHT];

func enter():
	super();
	new_block("valve", "conductor", output_dir, input_dir);

func enter_steam(_sender: Steam):
	sprite.flip_h = not sprite.flip_h;
	
	# Constants.RIGHT <=> Constants.LEFT
	input_direction[2] *= -1;

func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	if _prev_dir.x == 0:
		output_direction = [Constants.RIGHT];
	else:
		output_direction = [Constants.UP];
	
	if sprite.flip_h:
		output_direction[0] *= -1;
	
	return super();
