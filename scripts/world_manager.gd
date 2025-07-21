extends Node2D

var BlockScene: PackedScene;
var block_instance: Block;
var block: Node2D;
var selected_block: String;
var block_pos: Vector2;
var is_occupied: bool;

func _process(_delta: float) -> void:
	block_pos = Grid.get_grid_pos(get_global_mouse_position());
	block = Grid.get_block_at(block_pos)
	is_occupied = true if block else false
	#if is_occupied:
		#print("occupied");
	
func place_block() -> void:
	block_instance = BlockScene.instantiate();
	add_child(block_instance);
	
	var world_pos = Grid.get_world_pos(block_pos);
	Grid.set_grid(block_pos, block_instance);
	
	block_instance.set_block_position(world_pos);
	block_instance.enter();
	
func delete_block() -> void:
	Grid.set_grid(block_pos);
	block.exit();
	block.queue_free();
		
func replace_block() -> void:
	delete_block();
	place_block();

func can_place() -> bool:
	if not BlockScene:
		return false;

	if is_occupied:
		return false;
		
	return true

func can_delete() -> bool:
	if not is_occupied:
		#print("dawg")
		return false;
		
	if selected_block != block.block_name:
		#print("bro what")
		return false;
		
	return true;

func can_replace() -> bool:
	if not is_occupied:
		return false;
	
	if selected_block == block.block_name:
		return false;
	
	return true

func set_block_scene() -> void:
	match (selected_block):
		"stomper":
			BlockScene = preload(ScenePaths.STOMPER_SCENE);
		"tubes":
			BlockScene = preload(ScenePaths.TUBES_SCENE);
		"funnel":
			BlockScene = preload(ScenePaths.FUNNEL_SCENE);
		"crossover":
			BlockScene = preload(ScenePaths.CROSSOVER_SCENE);
		"pipe":
			BlockScene = preload(ScenePaths.PIPE_SCENE);
		"door":
			BlockScene = preload(ScenePaths.DOOR_SCENE);
		"crank":
			BlockScene = preload(ScenePaths.CRANK_SCENE);
		_:
			print("SELECTED BLOCK RUSAK CUY")

func _on_ui_selected_block(block_name: String) -> void:
	selected_block = block_name;
	set_block_scene();
