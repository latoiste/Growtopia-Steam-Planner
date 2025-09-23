extends Node
class_name SaveManager

const SAVE_FILE := "steam_sim.json";
const TEST_SAVE := "D:/GodotProjects/steam-growtopia/save_test.json";

var _js_callback := JavaScriptBridge.create_callback(on_js_recieve);

signal world_loaded;

##TODO; UNCOMMENT LATER!!!!
#func _ready() -> void:
	#var window := JavaScriptBridge.get_interface("window");
	#window.sendToGodot = _js_callback;
	
func handle_saveload_action(action: String) -> void:
	match action:
		"save":
			save();
		"load":
			load_world();

func save() -> void:
	var window := JavaScriptBridge.get_interface("window");
	var grid := Grid.get_grid();
	var formatted_file := prepare_json_file(grid);
	var json_string := JSON.stringify(formatted_file);
	
	window.downloadFile(json_string, SAVE_FILE);
	
func load_world() -> void:
	##TODO: UNCOMMENT LATER!!!
	#var window := JavaScriptBridge.get_interface("window");
	#window.uploadFile();
	#to await a js promise, javascript will call on_js_recieve later
	pass;
	
func on_js_recieve(args) -> void:
	world_loaded.emit();
	var json_string: String = args[0];
	var data: Dictionary = JSON.parse_string(json_string);
	
	for key in data.keys():
		var block_id := int(key);
		var pos: Array = data[key];
		load_blocks(block_id, pos);

func prepare_json_file(data: Dictionary) -> Dictionary:
	var formatted_file: Dictionary = {};
	
	for key: Vector2 in data.keys():
		var block_id: int = data.get(key);
		var pos := Vector2i(key);
		
		if not formatted_file.has(block_id):
			formatted_file.set(block_id, []);
			
		formatted_file[block_id].append({"pos_x": pos.x, "pos_y": pos.y});
		
	return formatted_file;

func load_blocks(block_id: int, positions: Array) -> void:
	var world: WorldManager = get_parent().get_manager("world");
	for pos in positions:
		var BlockScene := Block.get_block_scene_by_id(block_id);
		var grid_pos := Vector2(pos["pos_x"], pos["pos_y"]);
		world.place_block(BlockScene, grid_pos);
		
