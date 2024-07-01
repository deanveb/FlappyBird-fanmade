extends Node2D

@export var gap_length := 70
@export var speed := 300
signal score_update
var rng = RandomNumberGenerator.new()
var ScreenSize : Vector2 = DisplayServer.window_get_size()
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var center_height = rng.randi_range(163,400)
	#sprite's bottom center got offset 320px
	#start at x = 1300
	$pipe1.position.x = 1300
	$pipe2.position.x = 1300
	$pipe1.position.y = center_height
	$pipe2.position.y = center_height
	$score_count.position = $pipe1.position
	$pipe1.position.y += (320 + gap_length)
	$pipe2.position.y -= (320 + gap_length)
# Called everyframe. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$pipe1.position.x -= speed * delta
	$score_count.position.x = $pipe1.position.x
	$pipe2.position.x = $pipe1.position.x
func pause():
	speed = 0
	
func despawn():
	$".".queue_free()

func _on_score_count_area_entered(area):
	if area.name == "player hurtbox":
		score_update.emit()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
