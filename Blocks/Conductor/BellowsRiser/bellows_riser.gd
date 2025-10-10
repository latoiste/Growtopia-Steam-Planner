extends Conductor

@onready var sprite: Sprite2D = $Body;

var tween: Tween;
const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter() -> void:
	super();
	new_block(BlockID.BELLOWSRISER, output_dir, input_dir);
	start_bellows_riser_loop();
	
func start_bellows_riser_loop() -> void:
	while true:
		await animate_bellows_riser();
		await get_tree().create_timer(0.15).timeout;
	
func animate_bellows_riser() -> void:
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(sprite, "scale:y", 0.2, 1);
	await tween.finished;
	tween = create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(sprite, "scale:y", 0.53, 1);
	await tween.finished;
