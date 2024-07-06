extends Area2D

func _on_area_entered(area):
	owner.queue_free()
