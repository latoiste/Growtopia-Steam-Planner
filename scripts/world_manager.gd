extends Node2D

var selected_block: String;
var block_scene: Resource;

var block_pos: Vector2;
var block: Node2D;
var is_occupied: bool;

func _process(_delta: float) -> void:
	block_pos = Grid.get_grid_pos(get_global_mouse_position());
	block = Grid.get_block_at(block_pos)
	is_occupied = true if block else false
	
func place_block() -> void:
	var new_block: Block = block_scene.instantiate();
	var world_pos = Grid.get_world_pos(block_pos);
	
	new_block.set_block_position(world_pos)
	add_child(new_block);
	
	Grid.set_grid(block_pos, new_block);
	#new_block.get_surrounding_blocks();
	#print("up: ", new_block.get_up())
	#print("down: ", new_block.get_down())
	#print("left: ", new_block.get_left())
	#print("right: ", new_block.get_right())
	
func delete_block() -> void:
	block.queue_free()
	Grid.set_grid(block_pos)
		
func replace_block() -> void:
	delete_block();
	place_block();

func can_place() -> bool:
	if not block_scene:
		return false;

	if is_occupied:
		return false;
		
	return true

func can_delete() -> bool:
	if not is_occupied:
		return false;
		
	if selected_block != block.block_name:
		return false;
		
	if block.interactable:
		var interact_button = block.get_node("InteractButton");
		if interact_button.mouse_hovering:
			return false;
		
	return true;

func can_replace() -> bool:
	if not is_occupied:
		return false;
	
	if selected_block == block.block_name:
		return false;
	
	if block.interactable:
		var interact_button = block.get_node("InteractButton");
		if interact_button.mouse_hovering:
			return false;
	
	return true

func set_block_scene() -> void:
	match (selected_block):
		"stomper":
			block_scene = preload(ScenePaths.STOMPER_SCENE);
		"tubes":
			block_scene = preload(ScenePaths.TUBES_SCENE);
		_:
			print("SELECTED BLOCK RUSAK CUY")

func _on_ui_selected_block(block_name: String) -> void:
	selected_block = block_name;
	
	set_block_scene();
	#print(block_scene)
	#print(selected_block)
