extends Conductor

func _ready() -> void:
	block_name = "tubes";
	block_type = "conductor"
	interactable = false;
	var input_dir: Array[Vector2] = Constants.ALL_DIR;
	var output_dir: Array[Vector2] = Constants.ALL_DIR;
	set_direction(input_dir, output_dir);

func _on_recieve_power(prev_dir: Vector2):
	get_next_direction();
