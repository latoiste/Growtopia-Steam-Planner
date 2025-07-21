extends Block
class_name Conductor

signal force_update_sprite;

func enter() -> void:
	connect_force_update_sprite();
	
func exit() -> void:
	connect_force_update_sprite();

func connect_force_update_sprite() -> void:
	var surrounding_blocks = get_surrounding_blocks();
	for block in surrounding_blocks:
		if block is Pipe:
			if not force_update_sprite.is_connected(block.update_sprite):
				force_update_sprite.connect(block.update_sprite, CONNECT_ONE_SHOT);
			force_update_sprite.emit()

func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	if _prev_dir:
		change_dir_order(_prev_dir);
	return super();

func change_dir_order(prev_dir: Vector2) -> void:
	if output_direction.is_empty():
		return;
		
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
