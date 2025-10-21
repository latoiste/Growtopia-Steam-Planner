extends CanvasLayer

@export var splash_screen: Texture2D
@export var background_color: Color

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect
@onready var texture_rect: TextureRect = $TextureRect

func _ready() -> void:
	visible = true
	color_rect.color = background_color
	texture_rect.texture = splash_screen
	await show_splash_screen()
	queue_free()

func show_splash_screen() -> void:
	animation_player.play("splash_screen_fadeout")
	await animation_player.animation_finished
