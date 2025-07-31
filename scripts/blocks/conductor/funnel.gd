extends Conductor

@onready var sprite = $Sprite2D;

var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = [Constants.RIGHT];

func enter():
	super();
	new_block("funnel", "conductor", output_dir, input_dir);

func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	if sprite.flip_h:
		output_direction = [Constants.LEFT];
	else:
		output_direction = [Constants.RIGHT];
		
	return super();

#func on_flipped() -> void:
	#print("flipped!!!!")
