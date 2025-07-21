extends Conductor

@onready var sprite = $Sprite2D;

var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block("crossover", "conductor", false, true, output_dir, input_dir);

func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	# if prev dir is vertical
	if _prev_dir.x == 0:
		output_dir = [Vector2(_prev_dir.y, -_prev_dir.x)];
	else:
		output_dir = [Vector2(-_prev_dir.y, _prev_dir.x)];
	
	if sprite.flip_h:
		output_dir[0] *= -1;
		
	set_direction(output_dir, input_dir);
	return super();
