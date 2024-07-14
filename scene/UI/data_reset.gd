extends Button
@onready var button_sound = $"../../../../../ButtonSound"

func _on_button_down():
	button_sound.play()
	var data : SavedData = SavedData.new()
	data = SaveAndLoad.default_data()
	SaveAndLoad.Save(data)
