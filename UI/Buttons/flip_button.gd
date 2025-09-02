extends Button

var sprite: Sprite2D;

func _ready() -> void:
	var parent = get_parent();
	if parent:
		sprite = parent.get_node("Sprite2D")
	pressed.connect(_on_pressed);

func _on_pressed() -> void:
	sprite.flip_h = not sprite.flip_h;
