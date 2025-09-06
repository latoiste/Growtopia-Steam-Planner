extends Button
class_name ButtonTextHover

@export var hover_text: String;

@onready var timer: Timer = $Timer;
@onready var label: Label = $Label;

var tween: Tween;

func _ready() -> void:
	timer.timeout.connect(show_text);
	mouse_entered.connect(start_timer);
	mouse_exited.connect(stop_timer);
	
	label.text = hover_text;
	label.visible = false;
	
func start_timer() -> void:
	timer.start(0.5);
	
func stop_timer() -> void:
	timer.stop();
	label.visible = false;
	
func show_text() -> void:
	label.global_position = get_global_mouse_position() + Vector2(10, 20);
	label.visible = true;
	tween = create_tween();
	tween.tween_property(label, "modulate:a", 1, 0.1).from(0);
