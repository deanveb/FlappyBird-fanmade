extends Control

signal set_process

@export var HighScoreNode : Control
@export var CurrentScoreNode : Control
@export var StartingNode : Control

var corpseScene := preload("res://scene/Game Object/PlayerCorpse.tscn")

#FIXME: Corpse cant spawn
func DeathAnimation():
	get_node("../Flash").show()
	get_node("../Flash").get_node("AnimationPlayer").play("Fade")
	var corpse = corpseScene.instantiate()
	corpse.position = owner.get_node("player").position
	var content : Dictionary = SaveAndLoad.Load()
	var path : String = "res://flappy-bird-assets-1.1.0/sprites/Character/%s-midflap.png" % [content["CurrentSkin"]]
	corpse.get_node("Sprite2D").texture = load(path)
	get_node("..").call_deferred("add_child",corpse)
func updatetext(score : int, highscore : int):
	HighScoreNode.text = "%s \n\n %d" % ["HighScore", highscore]
	CurrentScoreNode.text = "%s \n\n %d" % ["Score", score]


func _on_retry_button_button_down():
	$"../../BackGroundHolder".get_node("Timer").stop()
	get_node("..").get_node("Corpse").queue_free()
	%ButtonSound.play()
	$".".hide() 
	$"../Starting"._show()
	get_tree().call_group("game_over","despawn")
	set_process.emit()
