extends Node

#_grid[block_pos] = block
var _grid: Dictionary = {};

##Returns dictionary of _grid[pos] = block_id
func get_grid() -> Dictionary:
	var grid_copy: Dictionary = _grid.duplicate();
	for key in grid_copy.keys():
		var block: Block = grid_copy.get(key);
		grid_copy[key] = block.block_id;
	return grid_copy;

##If block argument isn't given, it will be set to null
func set_grid(grid_pos: Vector2, block: Block = null) -> void:
	if block:
		_grid[grid_pos] = block;
	else:
		_grid.erase(grid_pos);
	#print(_grid)
	#print("\n")

##Use _grid pos
func get_block_at(grid_pos: Vector2) -> Block:
	#print("Hi from get_block_at: ", _grid.get(grid_pos))
	return _grid.get(grid_pos);

##From world to _grid
func get_grid_pos(world_pos: Vector2) -> Vector2:
	return floor(world_pos / Constants.BLOCK_SIZE);

##From _grid to world
func get_world_pos(grid_pos: Vector2) -> Vector2:
	return grid_pos * Constants.BLOCK_SIZE;
