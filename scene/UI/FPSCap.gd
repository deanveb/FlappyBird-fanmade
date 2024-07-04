extends HBoxContainer

@onready var line_edit = $LineEdit

func _ready():
	var max_fps = SaveAndLoad.Load()["FPSCap"]
	Engine.max_fps = max_fps
	line_edit.text = str(max_fps)
	line_edit.placeholder_text = str(max_fps)

func _on_line_edit_text_submitted(new_text):
	line_edit.release_focus()
	Engine.max_fps = int(new_text)
	SaveAndLoad.Save({"FPSCap" : int(new_text)})
	line_edit.placeholder_text = new_text
