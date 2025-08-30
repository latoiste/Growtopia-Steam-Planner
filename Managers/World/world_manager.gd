extends Node2D

var block_instance: Block;
var block: Block;
var block_pos: Vector2;
var is_occupied: bool;

func _process(_delta: float) -> void:
	block_pos = Grid.get_grid_pos(get_global_mouse_position());
	block = Grid.get_block_at(block_pos)
	is_occupied = true if block else false
	
func place_block() -> void:
	block_instance = Editor.BlockScene.instantiate();
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
	if not Editor.BlockScene:
		return false;

	if is_occupied:
		return false;
		
	return true

func can_delete() -> bool:
	if not is_occupied:
		return false;
		
	if Editor.selected_block_id != block.block_id:
		return false;
		
	return true;

func can_replace() -> bool:
	if not is_occupied:
		return false;
	
	if Editor.selected_block_id == block.block_id:
		return false;
	
	return true
