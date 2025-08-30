extends Conductor

@onready var sprite: Sprite2D = $Sprite2D;
@onready var timer: Timer = $Timer;

enum Status {
	OFF,
	ON,
}

const ORGAN_TEXTURES = [
	preload("res://block sprites/Conductor/organ_off.png"),
	preload("res://block sprites/Conductor/organ_on.png"),
]

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block("Steam Organ", Constants.BLOCK_ID["organ"], output_dir, input_dir);
	
func enter_steam(_sender: Steam):
	timer.start();
	sprite.texture = ORGAN_TEXTURES[Status.ON]

func _on_timer_timeout() -> void:
	sprite.texture = ORGAN_TEXTURES[Status.OFF]
