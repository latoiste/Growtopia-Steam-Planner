extends Conductor

@onready var sprite: Sprite2D = $Sprite2D;

const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter() -> void:
	super();
	new_block(BlockID.GEAR, output_dir, input_dir);

func _process(delta: float) -> void:
	sprite.rotation_degrees += delta * 270;
