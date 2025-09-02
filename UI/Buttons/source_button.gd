extends Button
class_name SourceButton

@onready var timer: Timer = $Timer;

func _ready() -> void:
	var parent := get_parent();
	if parent is Source:
		pressed.connect(parent.interact);
	pressed.connect(_on_pressed);
	timer.timeout.connect(_on_timer_timeout);
	
func _on_pressed() -> void:
	if not disabled:
		timer.start();
		disabled = true;

func _on_timer_timeout() -> void:
	disabled = false;
