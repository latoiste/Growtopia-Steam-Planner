extends Conductor

@onready var sprite = $Sprite2D;
@onready var timer = $Timer;

const VENT_TEXTURES = [
	preload("res://block sprites/Conductor/vent_off.png"),
	preload("res://block sprites/Conductor/vent_on.png"),
]

const input_dir: Array[Vector2] = [Constants.UP, Constants.DOWN];
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block("vent", "conductor", false, true, input_dir, output_dir);

func enter_steam():
	timer.start();
	sprite.texture = VENT_TEXTURES[1];

func _on_timer_timeout() -> void:
	sprite.texture = VENT_TEXTURES[0];
