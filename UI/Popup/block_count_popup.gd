extends CenterContainer

@onready var panel_container: PanelContainer = $PanelContainer
@onready var label: RichTextLabel = $PanelContainer/RichTextLabel

const BELLOWS_ICON = "res://Icons/Block/bellows_icon.png"

func set_popup_size():
	var block_count: Dictionary = Grid.get_block_count();
	label.clear();
	label.append_text("[font_size=24][b]Block Count:[/b][/font_size]\n");
	for key in block_count.keys():
		label.append_text("[img]%s[/img] %s: %s\n" % [BELLOWS_ICON, key, block_count.get(key)]);
	#panel_container.custom_minimum_size = label.size;
	
