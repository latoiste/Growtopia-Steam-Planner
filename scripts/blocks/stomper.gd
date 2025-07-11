extends Source
@onready var interact_button = $InteractButton;

func _ready():
	block_name = "stomper";
	block_type = "source";
	interactable = true;
	set_direction([Constants.NO_DIR,
				   Constants.DOWN,
				   Constants.LEFT, 
				   Constants.RIGHT]);

func interact():
	provide_power();
