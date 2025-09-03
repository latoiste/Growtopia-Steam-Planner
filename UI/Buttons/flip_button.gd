extends Button

@export var sprite: Sprite2D;

signal flipped;

func _ready() -> void:
	pressed.connect(on_flipped);
	
	if sprite:
		return;
	var parent = get_parent();
	if parent:
		sprite = parent.get_node("Sprite2D")

func on_flipped() -> void:
	sprite.flip_h = not sprite.flip_h;
	flipped.emit();
