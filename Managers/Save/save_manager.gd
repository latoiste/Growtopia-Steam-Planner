extends Node
class_name SaveManager

const SAVE_FILE := "steam_sim.json";

var _js_callback := JavaScriptBridge.create_callback(on_js_recieve);

signal world_loaded;

func _ready() -> void:
	var window := JavaScriptBridge.get_interface("window");
	if window:
		window.sendToGodot = _js_callback;
	
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
	var json_string := JSON.stringify(formatted_file, "\t");	
	
	if window:
		window.downloadFile(json_string, SAVE_FILE);
	
func load_world() -> void:
	var window := JavaScriptBridge.get_interface("window");
	if window:
		#godot cant await a js promise so javascript will call on_js_recieve later
		window.uploadFile();
	
func on_js_recieve(args: Array) -> void:
	var json_string: String = args[0];
	var data: Dictionary = JSON.parse_string(json_string);
	data = clean_uploaded_json(data);
	
	world_loaded.emit();
	
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

func clean_uploaded_json(data: Dictionary) -> Dictionary:
	var cleaned_json: Dictionary = {};
	for block_id in data.keys():
		if not int(block_id) in Constants.BLOCK_ID.values():
			continue;
		if not cleaned_json.has(block_id):
			cleaned_json.set(block_id, []);
		
		var positions = data.get(block_id);
		if not positions is Array:
			continue;
			
		for pos in positions:
			if not pos is Dictionary:
				continue;
			if not (pos.has("pos_x") and pos.has("pos_y")):
				continue;
				
			var pos_x: int = int(pos["pos_x"]);
			var pos_y: int = int(pos["pos_y"]);
			if pos_x < 0 or pos_x > 99:
				continue;
			elif pos_y < 0 or pos_y > 53:
				continue;
				
			cleaned_json[block_id].append({"pos_x": pos_x, "pos_y": pos_y});
	return cleaned_json;
	
func load_blocks(block_id: int, positions: Array) -> void:
	var world: WorldManager = get_parent().get_manager("world");
	for pos in positions:
		var BlockScene := Block.get_block_scene_by_id(block_id);
		var grid_pos := Vector2(pos["pos_x"], pos["pos_y"]);
		if Grid.get_block_at(grid_pos):
			continue;
		world.place_block(BlockScene, grid_pos, false);
