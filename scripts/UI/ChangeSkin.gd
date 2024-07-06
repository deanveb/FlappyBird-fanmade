extends TextureButton

func _ready():
	var content : SavedData = SaveAndLoad.Load() as SavedData
	if content.current_skin == name.to_lower():
		button_pressed = true
		disabled = true

func _on_pressed():
	for item in get_parent().get_children():
		if item is TextureButton:
			item.disabled = false
			item.button_pressed = false
	disabled = true
	var content : SavedData = SaveAndLoad.Load()
	content.current_skin = name.to_lower()
	SaveAndLoad.Save(content)
