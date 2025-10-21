extends CenterContainer
class_name CustomPopup

func _ready() -> void:
	visibility_changed.connect(func():
		if visible == true:
			set_popup_content();
	);

func set_popup_content() -> void:
	pass
