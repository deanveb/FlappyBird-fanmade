extends Area2D

@onready var player = $".."
@onready var death_sfx = %DeathSfx

func _on_area_entered(area):
	player.end_trigger.emit()
	owner.queue_free()
