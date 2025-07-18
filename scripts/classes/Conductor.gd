extends Block
class_name Conductor

func enter_steam() -> void:
	pass;

func exit_steam() -> void:
	pass

func get_next_dir(prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	if prev_dir:
		change_dir_order(prev_dir);
		
	for dir in output_direction:
		if dir_is_valid(dir):
			return dir;
	return Constants.NO_DIR;

func change_dir_order(prev_dir: Vector2) -> void:
	match prev_dir:
		Constants.UP:
			output_direction = [Constants.UP, 
								Constants.RIGHT,
								Constants.LEFT];
		Constants.DOWN:
			output_direction = [Constants.DOWN,
								Constants.LEFT,
								Constants.RIGHT];
		Constants.LEFT:
			output_direction = [Constants.LEFT,
								Constants.UP,
								Constants.DOWN];
		Constants.RIGHT:
			output_direction = [Constants.RIGHT,
								Constants.DOWN,
								Constants.UP];

#func _process(_delta: float) -> void:
	#var sprite: Sprite2D = get_child(0);
	#if has_steam:
		#sprite.modulate.a = 0.5;
	#else:
		#sprite.modulate.a = 1.0;
