extends Conductor

@onready var sprite: Sprite2D = $Body;

var tween: Tween;
const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter() -> void:
	super();
	new_block("Steam Lifter Piston", Constants.BLOCK_ID["pistonlifter"], output_dir, input_dir);
	start_piston_lifter_loop();

func start_piston_lifter_loop() -> void:
	while true:
		await animate_piston_lifter();
		await get_tree().create_timer(1).timeout;

func animate_piston_lifter() -> void:
	tween = create_tween();
	tween.tween_property(sprite, "position:y", 3, 0.5);
	tween.tween_property(sprite, "position:y", 8, 0.5);
	await tween.finished;
