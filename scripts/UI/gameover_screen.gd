extends Control

signal set_process

@export var HighScoreNode : Control
@export var CurrentScoreNode : Control
@export var StartingNode : Control
@onready var ground_pos_y = $"../../Ground/ground_pos_y"
@onready var death_sfx = $"../../Audio/DeathSfx"
@onready var death_fall = $"../../Audio/death_fall"
@onready var title_theme = $"../../Audio/title theme"

var corpseScene := preload("res://scene/Game Object/PlayerCorpse.tscn")

func DeathAnimation() -> void:
	get_node("../Flash").show()
	get_node("../Flash").get_node("AnimationPlayer").play("Fade")
	$"../../Audio/theme song".stop()
	title_theme.play()
	var corpse = corpseScene.instantiate()
	corpse.global_position = owner.get_node("player").global_position
	death_sfx.play()
	print(corpse.global_position.y, " ", ground_pos_y.global_position.y)
	if corpse.global_position.y +20 < ground_pos_y.global_position.y:
		death_fall.play()
	var content : SavedData = SaveAndLoad.Load() as SavedData
	var path : String = "res://flappy-bird-assets-1.1.0/sprites/Character/%s-midflap.png" % [content.current_skin]
	corpse.get_node("Sprite2D").texture = load(path)
	get_node("..").call_deferred("add_child",corpse)

func updatetext(score : int, highscore : int) -> void:
	HighScoreNode.text = "%s \n\n %d" % ["HighScore", highscore]
	CurrentScoreNode.text = "%s \n\n %d" % ["Score", score]

func _on_retry_button_button_down() -> void:
	$"../../BackGroundHolder".get_node("Timer").stop()
	get_node("..").get_node("Corpse").queue_free()
	%ButtonSound.play()
	$".".hide() 
	$"../Starting"._show()
	get_tree().call_group("game_over","despawn")
	set_process.emit()

func _on_player_end_trigger() -> void:
	DeathAnimation()
	get_tree().call_group("game_over","pause")
	show()
	var content : SavedData = SaveAndLoad.Load() as SavedData
	if int(content.high_score) <= owner.score:
		content.high_score = owner.score
		SaveAndLoad.Save(content)
	updatetext(owner.score, content.high_score)
