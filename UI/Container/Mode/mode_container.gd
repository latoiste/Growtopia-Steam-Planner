extends HBoxContainer

#func _ready() -> void:
	#for child in get_children():
		#if child is Button:
			#child.pressed.connect(Editor.set_mode.bind(child.name.to_lower()));
