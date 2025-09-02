extends Node2D
class_name Border

@onready var parent: Block = get_parent();
@onready var sprite: Sprite2D = $Sprite2D;
var connected_directions: int;
@onready var debug_area: Area2D = $DebugArea

enum Direction {
	UP = 1,
	DOWN = 2,
	LEFT = 4,
	RIGHT = 8,
	UL = 16,
	UR = 32,
	DL = 64,
	DR = 128,
}

func _ready() -> void:
	if not parent:
		return;
	call_deferred("get_connected_borders");
	call_deferred("update_neighbors");
	
func _exit_tree() -> void:
	update_neighbors();
	
func get_connected_borders() -> void:
	connected_directions = 0;
	var surrounding_blocks := parent.get_surrounding_blocks();
	for i in range(surrounding_blocks.size()):
		var block := surrounding_blocks[i];
		if block and block.border:
			connected_directions |= 2**i;
	check_diagonal_direction();
	change_sprite(connected_directions);
	
func check_diagonal_direction() -> void:
	var diagonal_directions := get_diagonal_directions_to_check();
	for direction in diagonal_directions:
		var direction_vector := direction_to_vector2(direction);
		var block := parent.get_block_in_dir(direction_vector);
		if block and block.border:
			connected_directions |= direction;
	
func update_neighbors() -> void:
	for key in Direction.keys():
		var direction: int = Direction.get(key);
		if connected_directions & direction:
			var direction_vector := direction_to_vector2(direction);
			var block := parent.get_block_in_dir(direction_vector);
			var border := block.border;
			border.get_connected_borders();
	#for key in Direction.keys():
		#var direction: int = Direction.get(key);
		#if connected_directions & direction:
			
	
	
func change_sprite(texture_index: int) -> void:
	var texture: Texture2D = ScenePaths.BORDER_TEXTURES.get(texture_index);
	if texture:
		sprite.texture = texture;
	
func direction_to_vector2(direction: Direction) -> Vector2:
	match direction:
		Direction.UP:
			return Vector2.UP;
		Direction.DOWN:
			return Vector2.DOWN;
		Direction.LEFT:
			return Vector2.LEFT;
		Direction.RIGHT:
			return Vector2.RIGHT;
		Direction.UL:
			return Vector2.UP + Vector2.LEFT;
		Direction.UR:
			return Vector2.UP + Vector2.RIGHT;
		Direction.DL:
			return Vector2.DOWN + Vector2.LEFT;
		Direction.DR:
			return Vector2.DOWN + Vector2.RIGHT;
	return Vector2.ZERO

func get_diagonal_directions_to_check() -> Array[Direction]:
	var diagonal_directions: Array[Direction];
	if (connected_directions & Direction.UP) and (connected_directions & Direction.LEFT):
		diagonal_directions.append(Direction.UL);
	if (connected_directions & Direction.UP)  and (connected_directions & Direction.RIGHT):
		diagonal_directions.append(Direction.UR);
	if (connected_directions & Direction.DOWN) and (connected_directions & Direction.LEFT):
		diagonal_directions.append(Direction.DL);
	if (connected_directions & Direction.DOWN) and (connected_directions & Direction.RIGHT):
		diagonal_directions.append(Direction.DR);
	return diagonal_directions;
