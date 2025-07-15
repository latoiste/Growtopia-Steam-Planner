extends Block
class_name Source

@onready var SteamScene: PackedScene = preload(ScenePaths.STEAM_SCENE);
var steam_instance: Steam;

func new_source(name: String, type: String, interactable: bool, flippable: bool, output_dir: Array[Vector2]):
	block_name = name;
	block_type = type;
	self.interactable = interactable;
	self.flippable = flippable;
	set_direction(output_dir);

func set_direction(output_dir: Array[Vector2]) -> void:
	if output_dir.is_empty():
		output_direction = Constants.ALL_DIR;
	else:
		output_direction = output_dir.duplicate();

func provide_power() -> void:
	var next_dir = get_next_dir();
	var conductor = get_block_in_dir(next_dir);
	
	if conductor:
		steam_instance = SteamScene.instantiate();
		steam_instance.init(conductor, next_dir);
		get_parent().add_child(steam_instance);
