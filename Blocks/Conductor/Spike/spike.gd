extends Conductor

@onready var sprite: Sprite2D = $Body;

var tween: Tween;
var raised: bool = false;
const input_dir: Array[Vector2] = [Constants.DOWN];

func enter() -> void:
	super();
	new_block(BlockID.SPIKES, [], input_dir);

func enter_steam(_sender: Steam) -> void:
	animate_spike();
	
func animate_spike() -> void:
	if tween and tween.is_running():
		return;
		
	var target_value: float;
	if raised:
		target_value = 0.03;
	else:
		target_value = 0.5;
	
	tween = create_tween();
	print("tween created");
	tween.tween_property(sprite, "scale:y", target_value, 0.5);
	raised = not raised;
	print("raised changed");	
