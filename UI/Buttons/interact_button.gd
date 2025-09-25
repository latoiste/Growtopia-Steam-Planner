extends Button

func _ready() -> void:
	var parent: Block = get_parent();
	if parent.has_method("interact"):
		pressed.connect(parent.interact);
