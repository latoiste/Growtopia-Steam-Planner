extends Conductor

@onready var sprite = $Sprite2D;

const DOOR_TEXTURES = [
	preload("res://block sprites/Conductor/door_closed.png"),
	preload("res://block sprites/Conductor/door_open.png"),
]

var is_open: bool = false;
var input_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block("door", "conductor", true, false, [], input_dir);

func enter_steam():
	is_open = not is_open;
	sprite.texture = DOOR_TEXTURES[1 if is_open else 0];
