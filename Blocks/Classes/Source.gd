extends Block
class_name Source

var steam_instance: Steam;
var audio_player: AudioStreamPlayer2D

func _ready() -> void:
	super._ready()
	
	var new_audio_player = AudioStreamPlayer2D.new()
	new_audio_player.stream = load("uid://c5g2bl6a7oi4h")
	audio_player = new_audio_player
	audio_player.tree_exiting.connect(queue_free)
	add_child(new_audio_player)

func provide_power() -> void:
	var next_dir := get_next_dir();
	var conductor := get_block_in_dir(next_dir);
	
	if conductor:
		steam_instance = ScenePaths.STEAM_SCENE.instantiate();
		add_sibling(steam_instance);
		steam_instance.init(self, next_dir);
		
		# play sound here
		audio_player.play()
