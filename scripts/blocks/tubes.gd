extends Conductor
@onready var sprite = $Sprite2D

var input_dir: Array[Vector2] = Constants.ALL_DIR;
var output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	new_block("tubes", "conductor", false, false, output_dir, input_dir);
