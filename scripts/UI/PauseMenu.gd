extends CanvasLayer

@export var pauseMenu : Node
#FIXME: PauseMenu overlap with Startingscreen and GameOverScreen

func _unhandled_input(_event):
	if Input.is_action_just_pressed("pause"):
		if !get_tree().paused:
			show()
			get_tree().paused = true

func _on_continue_button_down():
	hide()
	await get_tree().create_timer(0.05).timeout
	get_tree().paused = false
