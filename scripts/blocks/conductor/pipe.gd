extends Conductor
class_name Pipe

@onready var sprite = $Sprite2D;
@onready var label = $Label;

var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = Constants.ALL_DIR;
var texture_index = 0;

enum Direction {
	UP = 1,
	DOWN = 2,
	LEFT = 4,
	RIGHT = 8,
}

const PIPE_TEXTURES = [
	preload("res://block sprites/Conductor/pipes/pipe_base.png"),
	preload("res://block sprites/Conductor/pipes/pipe_down.png"),
	preload("res://block sprites/Conductor/pipes/pipe_up.png"),
	preload("res://block sprites/Conductor/pipes/pipe_vertical.png"),
	preload("res://block sprites/Conductor/pipes/pipe_right.png"),
	preload("res://block sprites/Conductor/pipes/pipe_corner_DR.png"),
	preload("res://block sprites/Conductor/pipes/pipe_corner_UR.png"),
	preload("res://block sprites/Conductor/pipes/pipe_T_left.png"),
	preload("res://block sprites/Conductor/pipes/pipe_left.png"),
	preload("res://block sprites/Conductor/pipes/pipe_corner_DL.png"),
	preload("res://block sprites/Conductor/pipes/pipe_corner_UL.png"),
	preload("res://block sprites/Conductor/pipes/pipe_T_right.png"),
	preload("res://block sprites/Conductor/pipes/pipe_horizontal.png"),
	preload("res://block sprites/Conductor/pipes/pipe_T_up.png"),
	preload("res://block sprites/Conductor/pipes/pipe_T_down.png"),
	preload("res://block sprites/Conductor/pipes/pipe_cross.png"),
]

func enter() -> void:
	super();
	new_block("pipe", "conductor", output_dir, input_dir);
	update_sprite();
	update_neighbor_sprite();
	
func get_texture_index() -> void:
	texture_index = 0;
	var surrounding_blocks = get_surrounding_blocks();
	for i in range(surrounding_blocks.size()):
		var block = surrounding_blocks[i];
		if block is Conductor:
			texture_index += 2 ** i

func update_sprite() -> void:
	get_texture_index();
	sprite.texture = PIPE_TEXTURES[texture_index];
	#label.text = str(texture_index)

func update_neighbor_sprite() -> void:
	var surrounding_blocks = get_surrounding_blocks();
	for i in range(surrounding_blocks.size()):
		var neighbor = surrounding_blocks[i];
		if neighbor is Pipe:
			#print("from :", self, " neighbor: ", neighbor);
			#the current block isnt updated in the Grid
			neighbor.update_sprite();
			
func exit() -> void:
	update_neighbor_sprite();
