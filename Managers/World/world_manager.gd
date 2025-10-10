extends Node2D
class_name WorldManager

var mouse_grid_pos: Vector2;
var selected_block_id: int;
var BlockScene: PackedScene;
var block_instance: Block;
var block: Block;

signal block_placed(block: Block);
signal block_deleted(block: Block);

func _process(_delta: float) -> void:
	mouse_grid_pos = Grid.get_grid_pos(get_global_mouse_position());
	block = Grid.get_block_at(mouse_grid_pos)

func set_selected_block(selected_block_id: int) -> void:
	BlockScene = Block.get_block_scene_by_id(selected_block_id);

func place_block(placed_block: PackedScene = BlockScene, grid_pos: Vector2 = mouse_grid_pos, register_action: bool = true) -> void:
	if Grid.get_block_at(grid_pos): #fix multiple block in the same tile
		prints("meeeeep", grid_pos, Grid.get_block_at(grid_pos));
		return;
	
	var world_pos := Grid.get_world_pos(grid_pos);
	block_instance = placed_block.instantiate();
	add_child(block_instance);
	
	Grid.set_grid(grid_pos, block_instance);
	
	block_instance.set_block_position(world_pos);
	block_instance.enter();
	
	if register_action:
		block_placed.emit(block_instance);
		print("block_placed emitted");

func delete_block(grid_pos: Vector2 = mouse_grid_pos, register_action: bool = true) -> void:
	var deleted_block := Grid.get_block_at(grid_pos);
	if not deleted_block:
		return;
		
	Grid.set_grid(grid_pos);
	deleted_block.delete();
	
	if register_action:
		block_deleted.emit(deleted_block);
		print("block deleted emitted");
	
func replace_block(placed_block: PackedScene = BlockScene, grid_pos: Vector2 = mouse_grid_pos) -> void:
	delete_block(grid_pos);
	place_block(placed_block, grid_pos);

func clear_world() -> void:
	var grid := Grid.get_grid();
	for grid_pos in grid.keys():
		delete_block(grid_pos, false);

func can_place() -> bool:
	if mouse_grid_pos.x < 0 or mouse_grid_pos.y > 53:
		return false;
	
	if not BlockScene:
		return false;

	if block:
		return false;
		
	return true

func can_delete() -> bool:
	if not block:
		return false;
		
	return true;

func can_replace() -> bool:
	if not block:
		return false;
	
	if selected_block_id == block.block_id:
		return false;
	
	return true
