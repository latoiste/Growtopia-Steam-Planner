extends Conductor

@onready var sprite: Sprite2D = $Sprite2D;

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter() -> void:
	super();
	new_block("Steam Gear", Constants.BLOCK_ID["gear"], output_dir, input_dir);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite.rotation_degrees += delta * 360;
