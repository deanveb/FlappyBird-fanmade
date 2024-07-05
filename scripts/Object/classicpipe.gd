extends Node2D

@export var gap_length := 70
@export var speed := 300
@onready var center_height : int
signal score_update
var ScreenSize : Vector2 = DisplayServer.window_get_size()

func _ready():
	#sprite's bottom center got offset 320px
	#start at x = 1300
	$pipe1.global_position.x = $".".global_position.x
	$pipe2.global_position.x = $".".global_position.x
	$pipe1.global_position.y = center_height
	$pipe2.global_position.y = center_height
	$score_count.global_position = $pipe1.global_position
	$pipe1.global_position.y += (320 + gap_length)
	$pipe2.global_position.y -= (320 + gap_length)
# Called everyframe. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$pipe1.global_position.x -= speed * delta
	$score_count.global_position.x = $pipe1.global_position.x
	$pipe2.global_position.x = $pipe1.global_position.x
func pause():
	speed = 0
	
func despawn():
	$".".queue_free()

func _on_score_count_area_entered(area):
	if area.owner.name == "player":
		score_update.emit()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
