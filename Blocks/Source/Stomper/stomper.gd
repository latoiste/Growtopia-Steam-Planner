extends Source

@onready var sprite: Sprite2D = $Sprite2D;

var tween: Tween;
const output_dir: Array[Vector2] = [Constants.DOWN,
							   Constants.LEFT, 
							   Constants.RIGHT]

func enter():
	new_block(BlockID.STOMPER, output_dir);

func interact():
	if tween:
		tween.kill();
	animate_stomper();
	
	provide_power();

func animate_stomper() -> void:
	tween = create_tween().set_ease(Tween.EASE_OUT);
	tween.tween_property(sprite, "scale:y", 0.075, 0.2);
	tween.tween_property(sprite, "scale:y", 0.5, 1.5);
	
