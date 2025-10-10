extends Conductor
class_name Pipe

@onready var sprite: Sprite2D = $Sprite2D;
@onready var label: Label = $Label;

var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = Constants.ALL_DIR;
var texture_index := 0;

func enter() -> void:
	super();
	new_block(BlockID.PIPE, output_dir, input_dir);
	update_sprite();
	update_neighbor_sprite();
	
func get_texture_index() -> void:
	texture_index = 0;
	var surrounding_blocks := get_surrounding_blocks();
	for i in range(surrounding_blocks.size()):
		var block := surrounding_blocks[i];
		if block is Conductor:
			texture_index += 2 ** i

func update_sprite() -> void:
	get_texture_index();
	sprite.texture = ScenePaths.PIPE_TEXTURES[texture_index];
	#label.text = str(texture_index)

func update_neighbor_sprite() -> void:
	var surrounding_blocks := get_surrounding_blocks();
	for i in range(surrounding_blocks.size()):
		var neighbor := surrounding_blocks[i];
		if neighbor is Pipe:
			#print("from :", self, " neighbor: ", neighbor);
			#the current block isnt updated in the Grid
			neighbor.update_sprite();
			
func exit() -> void:
	update_neighbor_sprite();
