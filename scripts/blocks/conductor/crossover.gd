extends Conductor

@onready var sprite = $Sprite2D;

var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	new_block("crossover", "conductor", false, true, output_dir, input_dir);

func get_next_dir(prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	var next_dir: Vector2 = Constants.NO_DIR;
	
	#prev_dir is vertical
	if prev_dir.x == 0:
		next_dir = Vector2(prev_dir.y, -prev_dir.x);
	else:
		next_dir = Vector2(-prev_dir.y, prev_dir.x);
	
	if sprite.flip_h:
		print("hello?")
		next_dir *= -1;
			
	return next_dir;
