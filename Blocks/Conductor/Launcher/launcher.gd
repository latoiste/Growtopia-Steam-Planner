extends Conductor
@onready var sprite: Sprite2D = $Body;

var tween: Tween;
const input_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block(BlockID.LAUNCHER, [], input_dir);

func enter_steam(_sender: Steam):
	if tween:
		tween.kill()
	animate_launcher();
	
func animate_launcher():
	tween = create_tween();
	tween.tween_property(sprite, "scale:y", 0.2, 1.0).from(0.5);
