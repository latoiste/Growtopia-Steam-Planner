extends Conductor

@onready var sprite: Sprite2D = $Sprite2D;
@onready var timer: Timer = $Timer;

const LAMP_TEXTURES: Array[Texture2D] = [
	preload("res://block sprites/Conductor/lamp_off.png"),
	preload("res://block sprites/Conductor/lamp_on.png"),
]
const input_dir: Array[Vector2] = [Constants.DOWN];

func enter() -> void:
	super();
	new_block(BlockID.LAMP, [], input_dir);
	timer.timeout.connect(reset_lamp_texture);

func enter_steam(_sender: Steam) -> void:
	timer.start(10);
	sprite.texture = LAMP_TEXTURES[1];
	
func reset_lamp_texture() -> void:
	sprite.texture = LAMP_TEXTURES[0];
