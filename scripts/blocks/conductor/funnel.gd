extends Conductor

@onready var sprite = $Sprite2D;

var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = [Constants.RIGHT];

func enter():
	new_block("funnel", "conductor", false, true, output_dir, input_dir);

func get_next_dir(prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	print(prev_dir);
	if sprite.flip_h:
		return Constants.LEFT;
	return Constants.RIGHT;

#func on_flipped() -> void:
	#print("flipped!!!!")
