extends Node

#grid[block_pos] = block
var grid: Dictionary = {}

##TODO: ADD CHECKER FOR GRID AND TREE MISMATCH

##If block argument isn't given, it will be set to null
func set_grid(grid_pos: Vector2, block: Block = null) -> void:
	if block:
		grid[grid_pos] = block;
	else:
		grid.erase(grid_pos);

##Use grid pos
func get_block_at(grid_pos: Vector2) -> Block:
	#print("Hi from get_block_at: ", grid.get(grid_pos))
	return grid.get(grid_pos);

##From world to grid
func get_grid_pos(world_pos: Vector2) -> Vector2:
	return floor(world_pos / Constants.BLOCK_SIZE);

##From grid to world
func get_world_pos(grid_pos: Vector2) -> Vector2:
	return grid_pos * Constants.BLOCK_SIZE;
