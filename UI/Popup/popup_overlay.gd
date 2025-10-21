extends ColorRect
class_name PopupOverlay;

var tween: Tween;
var popup_content: Container;
var popup_showing: bool = false;

func _ready() -> void:
	color = Color(0, 0, 0, 0.4);
	visible = false;

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") and popup_showing:
		close_popup();
		
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouse and event.is_pressed():
		close_popup();

func show_popup(popup: Container) -> void:
	popup_content = popup;
	
	visible = true;
	popup_content.visible = true;
	popup_showing = true;
	
	tween = create_tween();
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC);
	tween.tween_property(popup_content, "position:y", 0, 0.35).from(-15);
	tween.set_parallel();
	tween.tween_property(popup_content, "modulate:a", 1, 0.3).from(0);
	
func close_popup() -> void:
	if tween:
		tween.kill();
	visible = false;
	popup_content.visible = false;
	popup_showing = false;
	
