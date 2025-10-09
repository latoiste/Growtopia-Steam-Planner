@tool
extends ColorRect
class_name CustomPopup;

@export var popup_content: Container:
	set(value):
		popup_content = value;
		if Engine.is_editor_hint():
			update_configuration_warnings();
	
var tween: Tween;
var popup_showing: bool = false;

func _ready() -> void:
	color = Color(0, 0, 0, 0.4);
	visible = false;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") and popup_showing:
		close_popup();

func show_popup() -> void:
	visible = true;
	popup_showing = true;
	popup_content.set_popup_size();
	
	tween = create_tween();
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(popup_content, "position:y", 0, 0.35).from(-15);
	tween.set_parallel();
	tween.tween_property(popup_content, "modulate:a", 1, 0.3).from(0);
	
func close_popup() -> void:
	if tween:
		tween.kill();
	visible = false;
	popup_showing = false;
		
func _get_configuration_warnings() -> PackedStringArray:
	var warning: PackedStringArray = [];
	if popup_content == null:
		warning.append("Missing a popup");
	else:
		warning.clear();
	return warning;
