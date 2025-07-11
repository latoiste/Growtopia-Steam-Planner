extends Conductor
var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = Constants.ALL_DIR;

func _ready() -> void:
	block_name = "tubes";
	block_type = "conductor"
	interactable = false;
	set_direction(input_dir, output_dir);
