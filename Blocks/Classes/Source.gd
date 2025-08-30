extends Block
class_name Source

var steam_instance: Steam;

func provide_power() -> void:
	var next_dir := get_next_dir();
	var conductor := get_block_in_dir(next_dir);
	
	if conductor:
		steam_instance = ScenePaths.STEAM_SCENE.instantiate();
		add_sibling(steam_instance);
		steam_instance.init(self, next_dir);
