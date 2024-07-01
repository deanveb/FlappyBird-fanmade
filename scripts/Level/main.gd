extends Node2D

@export var pipe_scene : PackedScene
@export var player_scene : PackedScene
@export var UI_Node : Control
var score : int
var screen_size := DisplayServer.window_get_size()
#FIXME: Declare Func return type 

func _ready():
	UI_Node.get_node("Starting").show()
	get_tree().call_group("game_over", "pause")

#new game
func _unhandled_key_input(_event):
	if Input.is_action_just_pressed("jump"):
		$PipeSpawnRate.start()
		UI_Node.get_node("Starting")._hide()
		var player = player_scene.instantiate()
		player.position = %StartPosition.position
		player.end_trigger.connect(_on_player_end_trigger)
		add_child(player)
		$Ground.speed = 300
		set_process_unhandled_key_input(false)

func ChangeSkin(pipe : Node2D, newPipeTexture : Texture2D):
	pipe.get_node("pipe1/Sprite2D").texture = newPipeTexture
	pipe.get_node("pipe2/Sprite2D").texture = newPipeTexture
	

#pipe spawner
func _on_timer_timeout():
	var pipe = pipe_scene.instantiate()
	pipe.score_update.connect(_on_pipe_score_update)
	pipe.position.x = screen_size.x + 10
	add_child(pipe)

#game over screen popup
func _on_player_end_trigger():
	var GameOverUI : Control = UI_Node.get_node("GameOver")
	await GameOverUI.DeathAnimation()
	%DeathSfx.play()
	get_tree().call_group("game_over","pause")
	$PipeSpawnRate.stop()
	remove_child($player)
	GameOverUI.show()
	var content : Dictionary = SaveAndLoad.Load()
	if content["HighScore"] <= score:
		content["HighScore"] = score
		SaveAndLoad.Save(content)
	GameOverUI.updatetext(score, content["HighScore"])

func _on_pipe_score_update():
	%Scored.play()
	score += 1
	$UI/Score/score_counter/score_display.text = "%d" % [score]

func _on_game_over_set_process():
	set_process_unhandled_key_input(true)
	score = 0
	$UI/Score/score_counter/score_display.text = "%d" % [score]
