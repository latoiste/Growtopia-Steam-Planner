extends Node2D
class_name Border

@onready var block: Block = get_parent();
@onready var sprite: Sprite2D = $Sprite2D;

# need to notify all 8 blcoks around it, but maybe just put it in here and not in block class

enum Direction {
	UP = 1,
	DOWN = 2,
	LEFT = 4,
	RIGHT = 8,
}



func _exit_tree() -> void:
	#notify surrounding blocks
	pass
