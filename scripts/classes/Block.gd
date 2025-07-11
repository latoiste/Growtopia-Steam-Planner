extends Node2D
class_name Block

var block_name: String;
var block_type: String;
var block_pos: Vector2;
var interactable: bool;

func interact() -> void:
	pass

func set_block_position(pos: Vector2) -> void:
	position = pos;
	block_pos = Grid.get_grid_pos(pos);

func get_block_name() -> String:
	return block_name

func get_block_type() -> String:
	return block_type
	
func is_interactable() -> bool:
	return true if interactable else false

##The indeces for blocks returned are [UP, DOWN, LEFT, RIGHT] 
func get_surrounding_blocks() -> Array[Block]:
	var blocks: Array[Block] = []
	var dirs = Constants.ALL_DIR
	
	for dir in dirs:
		var pos = block_pos + dir
		var block_around = Grid.get_block_at(pos);
		blocks.append(block_around);
	#print(blocks)
	return blocks;

##Returns the block above.
##Returns null if theres no block
func get_block_up() -> Block:
	var pos = block_pos + Constants.UP;
	return Grid.get_block_at(pos);

##Returns the block below.
##Returns null if theres no block
func get_block_down() -> Block:
	var pos = block_pos + Constants.DOWN;
	return Grid.get_block_at(pos);

##Returns the block to its left.
##Returns null if theres no block
func get_block_left() -> Block:
	var pos = block_pos + Constants.LEFT;
	return Grid.get_block_at(pos);
	
##Returns the block to its right.
##Returns null if theres no block
func get_block_right() -> Block:
	var pos = block_pos + Constants.RIGHT;
	return Grid.get_block_at(pos);
	
#direciton is valid means:
# - the direction exists (NOT Vector2.ZERO)
# - the block in that direction exists
# - block type is conductor
# - the input direction of that block matches (opposite of dir)
func dir_is_valid(dir: Vector2) -> bool:
	var block: Block;
	match dir:
		Constants.UP:
			block = get_block_up();
		Constants.DOWN:
			block = get_block_down();
		Constants.LEFT:
			block = get_block_left();
		Constants.RIGHT:
			block = get_block_right();

	if not block:
		return false;
	if not block is Conductor:
		return false;
	if not block.input_direction.has(dir * -1):
		return false
	
	return true;

func get_dir_index(dirs: Array[Vector2]) -> int:
	var index: int = -1;
	for i in range(dirs.size()):
		var dir = dirs[i];
		if dir_is_valid(dir):
			index = i;
			break;
	return index;

#func get_next_direction()
