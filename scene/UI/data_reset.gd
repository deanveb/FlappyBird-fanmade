extends Button

func _on_button_down():
	var data : SavedData = SavedData.new()
	data = SaveAndLoad.default_data(data)
	SaveAndLoad.Save(data)
