extends Button

@onready var timer = $Timer;

func _ready() -> void:
	var parent = get_parent();
	if parent is Source:
		pressed.connect(parent.interact);
		
func _on_pressed() -> void:
	if not disabled:
		timer.start();
		disabled = true;

func _on_timer_timeout() -> void:
	disabled = false;
