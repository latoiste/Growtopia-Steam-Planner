extends CustomPopup
class_name BugReportPopup;

@onready var github_button: Button = $PanelContainer/MarginContainer/Button;

func _ready() -> void:
	github_button.pressed.connect(redirect_to_github);
	
func redirect_to_github() -> void:
	var window := JavaScriptBridge.get_interface("window");
	if window:
		window.kirim_ke_kamboja();
