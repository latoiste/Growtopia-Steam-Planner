extends Node

#grid[block_pos] = block
var grid: Dictionary = {}

##If block argument isn't given, it will be set to null
func set_grid(pos: Vector2, block: Block = null) -> void:
	if block:
		grid[pos] = block;
	else:
		grid.erase(pos);

##Use grid pos
func get_block_at(pos: Vector2) -> Block:
	#print("Hi from get_block_at: ", grid.get(pos))
	return grid.get(pos);

##From world to grid
func get_grid_pos(pos: Vector2) -> Vector2:
	return Vector2(
		floor(pos.x / Constants.BLOCK_SIZE),
		floor(pos.y / Constants.BLOCK_SIZE)
	)

##From grid to world
func get_world_pos(pos: Vector2) -> Vector2:
	return Vector2(
		floor(pos.x * Constants.BLOCK_SIZE),
		floor(pos.y * Constants.BLOCK_SIZE)
	)
