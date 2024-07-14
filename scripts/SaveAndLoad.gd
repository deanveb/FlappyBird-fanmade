extends Node
@export var path : String = "user://savegame.tres"

#FIXME: can't use await
#FIXME: add backward compatible
func Save(content : SavedData) -> void:
	ResourceSaver.save(content, path)

func default_data() -> SavedData:
	var data : SavedData = SavedData.new()
	data.current_skin = "yellowbird"
	data.FPSCap = 60
	data.high_score = 0
	return data

func Load() -> SavedData:
	if !FileAccess.file_exists(path):
		var data : SavedData = SavedData.new()
		data = default_data()
		Save(data)
	var data : SavedData = load(path) as SavedData
	return data
