extends Node2D

var switch : bool = false

func _on_timer_timeout():
	if !switch:
		$Fade.play("FadeOut")
		await $Fade.animation_finished
		$Day.hide()
		switch = true
	else:
		$Fade.play("FadeIn")
		$Day.show()
		switch = false
