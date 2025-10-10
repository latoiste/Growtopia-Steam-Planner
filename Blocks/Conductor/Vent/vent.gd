extends Conductor

@onready var sprite: Sprite2D = $Sprite2D;
@onready var timer: Timer = $Timer;

const VENT_TEXTURES: Array[Texture2D] = [
	preload("res://block sprites/Conductor/vent_off.png"),
	preload("res://block sprites/Conductor/vent_on.png"),
]

const input_dir: Array[Vector2] = [Constants.UP, Constants.DOWN];
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block(BlockID.VENT, output_dir, input_dir);
	timer.timeout.connect(reset_vent_texture);

func enter_steam(_sender: Steam):
	timer.start(3);
	sprite.texture = VENT_TEXTURES[1];

func reset_vent_texture() -> void:
	sprite.texture = VENT_TEXTURES[0];
