extends Conductor

@onready var sprite: Sprite2D = $Body;
@onready var flip_button: Button = $FlipButton

var tween: Tween;
var piston_direction: int = 1;
const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter() -> void:
	super();
	new_block(BlockID.PISTON, output_dir, input_dir);
	start_piston_loop();
	flip_button.flipped.connect(change_direction);

func start_piston_loop() -> void:
	while true:
		await animate_piston();
		await get_tree().create_timer(1).timeout;

func animate_piston() -> void:
	tween = create_tween();
	tween.tween_property(sprite, "position:x", 8 + (5 * piston_direction), 0.5);
	tween.tween_property(sprite, "position:x", 8, 0.5);
	await tween.finished;

func change_direction() -> void:
	piston_direction *= -1;
	
