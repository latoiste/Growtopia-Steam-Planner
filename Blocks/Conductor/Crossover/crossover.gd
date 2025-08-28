extends Conductor

@onready var sprite: Sprite2D = $Sprite2D;

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block("crossover", "conductor", output_dir, input_dir);

func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	# if prev dir is vertical
	if _prev_dir.x == 0:
		output_direction = [Vector2(_prev_dir.y, -_prev_dir.x)];
	else:
		output_direction = [Vector2(-_prev_dir.y, _prev_dir.x)];
	
	if sprite.flip_h:
		output_direction[0] *= -1;
	
	return super();
