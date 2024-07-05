extends Node2D

@export var pipe_scene : PackedScene
@export var player_scene : PackedScene
@export var UI_Node : Control
@onready var screen_size : Vector2 = DisplayServer.window_get_size()
@onready var pipe_spawnpoint = preload("res://scene/Utilites/PipeSpawnpoint.tscn").instantiate()


var score : int
var isFullScreen = false

func _ready() -> void:
	pipe_spawnpoint.position.y = 175
	UI_Node.get_node("Starting").show()
	get_tree().call_group("game_over", "pause")
func _process(delta) -> void:
	screen_size = DisplayServer.window_get_size()
	if Input.is_action_just_pressed("Fullscreen"):
		if !isFullScreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			isFullScreen = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			isFullScreen = false

func SpawnPlayer() -> void:
	var player = player_scene.instantiate()
	player.position = %StartPosition.position
	player.end_trigger.connect(_on_player_end_trigger)
	player.end_trigger.connect(UI_Node.get_node("GameOver")._on_player_end_trigger)
	add_child(player)

func ActivatePipe() -> void:
	add_child(pipe_spawnpoint)
	$PipeSpawnRate.start()

#new game
func _unhandled_key_input(_event) -> void:
	if Input.is_action_just_pressed("jump"):
		$BackGroundHolder.get_node("Timer").start()
		ActivatePipe()
		UI_Node.get_node("Starting")._hide()
		SpawnPlayer()
		$Ground.speed = 300
		set_process_unhandled_key_input(false)

func ChangeSkin(pipe : Node2D, newPipeTexture : Texture2D) -> void:
	pipe.get_node("pipe1/Sprite2D").texture = newPipeTexture
	pipe.get_node("pipe2/Sprite2D").texture = newPipeTexture

#game over screen popup
func _on_player_end_trigger() -> void:
	remove_child(pipe_spawnpoint)
	$PipeSpawnRate.stop()

func _on_pipe_score_update() -> void:
	%Scored.play()
	score += 1
	$UI/Score/score_counter/score_display.text = "%d" % [score]

func _on_game_over_set_process() -> void:
	set_process_unhandled_key_input(true)
	score = 0
	$UI/Score/score_counter/score_display.text = "%d" % [score]

func _on_pipe_spawn_rate_timeout():
	var pipe = pipe_scene.instantiate()
	pipe.score_update.connect(_on_pipe_score_update)
	pipe.position.x = screen_size.x + 53
	pipe.center_height = pipe_spawnpoint.get_node("Path2D/PathFollow2D").global_position.y
	add_child(pipe)
