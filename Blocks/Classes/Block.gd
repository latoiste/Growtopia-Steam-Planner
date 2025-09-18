extends Node2D
class_name Block

var block_name: String;
var block_id: int;
var block_pos: Vector2;
var input_direction: Array[Vector2] = [];
var output_direction: Array[Vector2] = [];
var border: Border;

static func get_block_scene_by_id(id: int) -> PackedScene:
	var _block_name: String = Constants.BLOCK_ID.find_key(id);
	var BlockScene: PackedScene;
	
	if not _block_name:
		return null;
	BlockScene = load(ScenePaths.BLOCKS[_block_name]);
	return BlockScene;

func _ready() -> void:
	for child in get_children():
		if child is Border:
			border = child;
	
func enter() -> void:
	pass

func exit() -> void:
	pass

func interact() -> void:
	pass
	
func enter_steam(_sender: Steam) -> void:
	pass;

func exit_steam() -> void:
	pass

func new_block(_block_name: String, _block_id: int, \
		output_dir: Array[Vector2] = [], input_dir: Array[Vector2] = []):
	self.block_name = _block_name;
	self.block_id = _block_id;
	set_direction(output_dir, input_dir);

func delete() -> void:
	exit();
	queue_free();
	if border:
		border.cleanup();
	
func set_direction(output_dir: Array[Vector2] = [], input_dir: Array[Vector2] = []):
	output_direction = output_dir.duplicate();
	input_direction = input_dir.duplicate();

func set_block_position(pos: Vector2, use_world_pos: bool = true) -> void:
	if not use_world_pos:
		pos = Grid.get_world_pos(pos);
	block_pos = Grid.get_grid_pos(pos);
	position = pos;

func get_block_name() -> String:
	return block_name;

func get_global_block_pos() -> Vector2:
	return Grid.get_world_pos(block_pos);

## Returns the grid pos.
func get_block_pos() -> Vector2:
	return block_pos;
	
##The indeces for blocks returned are [UP, DOWN, LEFT, RIGHT] 
func get_surrounding_blocks() -> Array[Block]:
	var blocks: Array[Block] = []
	var dirs := Constants.ALL_DIR
	
	for dir in dirs:
		var block_around := get_block_in_dir(dir);
		blocks.append(block_around);
	return blocks;

#direciton is valid means:
# - the direction exists (NOT Vector2.ZERO)
# - the block in that direction exists
# - block type is conductor
# - the input direction of that block matches (opposite of dir)
func dir_is_valid(dir: Vector2) -> bool:
	var block: Block = get_block_in_dir(dir);

	if not block:
		return false;
	if not block is Conductor:
		return false;
	if not block.input_direction.has(dir * -1):
		return false
	
	return true;

## Gets the next direction of a block.
## Returns Vector2.ZERO if its at the end.
## Override this method for different properties.
func get_next_dir(_prev_dir: Vector2 = Constants.NO_DIR) -> Vector2:
	for dir in output_direction:
		if dir_is_valid(dir):
			return dir;
	return Constants.NO_DIR;

func get_block_in_dir(dir: Vector2) -> Block:
	var pos := block_pos + dir;
	return Grid.get_block_at(pos);

#func has_border() -> bool:
	#for child in get_children():
		#if child is Border:
			#return true;
	#return false;
