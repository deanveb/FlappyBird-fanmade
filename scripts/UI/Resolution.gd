extends HBoxContainer

#FIXME: drop menu font, fullscreen resolution
@onready var option_button = $OptionButton
@onready var button_sound = $"../../../../../ButtonSound"

var Resolutions : Dictionary = {
								"2560x1440":Vector2(2560, 1440),
								"1920x1200":Vector2(1920, 1200),
								"1920x1080":Vector2(1920, 1080),
								"1680x1050":Vector2(1680, 1050),
								"1440x900":Vector2(1440, 900),
								"1366x768":Vector2(1366, 768),
								"1280x800":Vector2(1280, 800),
								"1280x720":Vector2(1280, 720),
								"1024x768":Vector2(1024, 768),
								"800x600":Vector2(800, 600),
								"640x480":Vector2(640, 480)
							   }
func _ready():
	var screenSize = DisplayServer.screen_get_size()
	Resolutions["%dx%d" % [screenSize.x, screenSize.y]] = screenSize
	for item in Resolutions:
		option_button.add_item(item)

func _on_option_button_item_selected(index):
	DisplayServer.window_set_size(Resolutions[option_button.get_item_text(index)])
	get_window().content_scale_aspect = Window.CONTENT_SCALE_ASPECT_KEEP
	get_window().content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	


func _on_option_button_button_down():
	button_sound.play()
