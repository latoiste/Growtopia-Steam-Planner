extends Button
class_name ButtonOverlay

#var mouse_hovering: bool = false;
#
#func _process(delta: float) -> void:
	#if mouse_hovering:
		#print("hovering lol");
	#else:
		#print("not hovering lol")
#
#func _ready() -> void:
	#connect("mouse_entered", _on_mouse_entered);
	#connect("mouse_exited", _on_mouse_exited);
		#
#func _on_mouse_entered() -> void:
	#mouse_hovering = true;
	#
#func _on_mouse_exited() -> void:
	#mouse_hovering = false;
