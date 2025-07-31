extends Conductor

@onready var sprite = $Sprite2D;

const CRANK_TEXTURES = [
	preload("res://block sprites/Conductor/crank_vertical.png"),
	preload("res://block sprites/Conductor/crank_horizontal.png"),
]

var is_switched: bool = false;
const input_dir: Array[Vector2] = [Constants.UP, Constants.DOWN];
const output_dir: Array[Vector2] = [Constants.UP, Constants.DOWN];

func enter():
	super();
	new_block("crank", "conductor", output_dir, input_dir);
	
func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR):
	output_direction = [_prev_dir];
	return super();
	
func interact():
	rotate_dir(input_direction);
	is_switched = not is_switched;
	
	sprite.texture = CRANK_TEXTURES[1 if is_switched else 0];

func rotate_dir(directions: Array[Vector2]):
	for i in range(directions.size()):
		var dir = directions[i];
		directions[i] = Vector2(dir.y, -dir.x);
