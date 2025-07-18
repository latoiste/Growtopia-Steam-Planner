extends Block
class_name Source

@onready var SteamScene: PackedScene = preload(ScenePaths.STEAM_SCENE);
var steam_instance: Steam;

func provide_power() -> void:
	var next_dir = get_next_dir();
	var conductor = get_block_in_dir(next_dir);
	
	if conductor:
		steam_instance = SteamScene.instantiate();
		get_parent().add_child(steam_instance);
		steam_instance.init(conductor, next_dir);
