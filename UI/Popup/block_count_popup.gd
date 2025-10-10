extends CenterContainer

@onready var panel_container: PanelContainer = $PanelContainer
@onready var label: RichTextLabel = $PanelContainer/RichTextLabel

const BELLOWS_ICON = "res://Icons/Block/bellows_icon.png"

func set_popup_size():
	var block_count: Dictionary = Grid.get_block_count();
	label.clear();
	label.append_text("[font_size=24][b]Block Count:[/b][/font_size]\n");
	for block_id: int in block_count.keys():
		var block_name: String = BlockData.DB[block_id].get("name");
		var block_icon: String = BlockData.DB[block_id].get("icon");
		label.append_text("[img]%s[/img] %s: %s\n" % [block_icon, block_name, block_count.get(block_id)]);
	#panel_container.custom_minimum_size = label.size;
	
