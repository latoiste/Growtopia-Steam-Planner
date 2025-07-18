extends Source

@onready var interact_button = $InteractButton;
var output_dir: Array[Vector2] = [Constants.NO_DIR,
							   Constants.DOWN,
							   Constants.LEFT, 
							   Constants.RIGHT]

func enter():
	new_block("stomper", "source", true, false, output_dir);

func interact():
	provide_power();
