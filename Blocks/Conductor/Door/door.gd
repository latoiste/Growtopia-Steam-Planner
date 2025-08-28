extends Conductor

@onready var sprite: Sprite2D = $Sprite2D;
@onready var interact_button: Button = $InteractButton;

const DOOR_TEXTURES = [
	preload("res://block sprites/Conductor/door_closed.png"),
	preload("res://block sprites/Conductor/door_open.png"),
]

var is_open: bool = false;
var input_dir: Array[Vector2] = Constants.ALL_DIR;

func _ready() -> void:
	interact_button.pressed.connect(enter_steam.bind(null));

func enter():
	super();
	new_block("door", "conductor", [], input_dir);

func enter_steam(_sender: Steam):
	is_open = not is_open;
	sprite.texture = DOOR_TEXTURES[1 if is_open else 0];
