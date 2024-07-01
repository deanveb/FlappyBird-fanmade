extends Area2D

@export var speed : int = 300
var screen_size = DisplayServer.window_get_size()
var reset_position = $".".position.x

func _process(delta):
	var cameraPos : Vector2 = get_viewport_rect().size / 2
	$".".position.x -= speed * delta
	if abs(position.x - cameraPos.x)  > screen_size.x:
		$".".position.x += screen_size.x 
func pause() -> void:
	speed = 0
