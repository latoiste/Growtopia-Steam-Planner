extends Conductor

@onready var sprite = $Sprite2D;

var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = [Constants.RIGHT];

func enter():
	super();
	new_block("funnel", "conductor", false, true, output_dir, input_dir);

func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	if sprite.flip_h:
		output_dir = [Constants.LEFT];
	else:
		output_dir = [Constants.RIGHT];
		
	set_direction(output_dir, input_dir);
	return super();

#func on_flipped() -> void:
	#print("flipped!!!!")
