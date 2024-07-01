extends Node
@export var path : String = "user://savegame.json"
func Save(content : Dictionary) -> void:
	var file = FileAccess.open(path, FileAccess.WRITE)
	var json : String = JSON.stringify(content)	
	file.store_string(json)
	file.close()

func Load() -> Dictionary:
	#must add new settings if there's more var to save
	if !FileAccess.file_exists(path):
		var settings : Dictionary
		settings["HighScore"] = 0
		settings["CurrentSkin"] = ""
		Save(settings)
	var file = FileAccess.open(path, FileAccess.READ)
	var json : String = file.get_as_text()
	var content : Dictionary = JSON.parse_string(json)
	file.close()
	return content
