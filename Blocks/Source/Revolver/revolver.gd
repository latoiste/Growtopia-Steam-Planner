extends Source

@onready var sprite: Sprite2D = $Handle;

var tween: Tween;
const output_dir: Array[Vector2] = [Constants.UP,
							   Constants.DOWN]

func enter():
	new_block("Steam Revolver", Constants.BLOCK_ID["revolver"], output_dir);

func interact():
	if tween:
		tween.kill();
	animate_handle();
	
	provide_power();

func animate_handle() -> void:
	for i in range(6):
		tween = create_tween();
		tween.tween_property(sprite, "scale", Vector2(-sprite.scale.x, sprite.scale.y), 0.25);
		await tween.finished;
