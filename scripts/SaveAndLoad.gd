extends Node
@export var path : String = "user://savegame.json"

#FIXME: can't use await
func Save(content : Dictionary) -> void:
	var data : Dictionary
	if !FileAccess.file_exists(path):
		data = content
	else:
		data = Load()
		data.merge(content, true)
	var file = FileAccess.open(path, FileAccess.WRITE)
	var json : String = JSON.stringify(data)
	file.store_string(json)
	file.close()

func Load() -> Dictionary:
	#must add new settings if there's more var to save
	if !FileAccess.file_exists(path):
		var settings : Dictionary
		settings["HighScore"] = 0
		settings["CurrentSkin"] = "yellowbird"
		settings["FPSCap"] = 60
		Save(settings)
	var file = FileAccess.open(path, FileAccess.READ)
	var json : String = file.get_as_text()
	var content : Dictionary = JSON.parse_string(json)
	file.close()
	return content
