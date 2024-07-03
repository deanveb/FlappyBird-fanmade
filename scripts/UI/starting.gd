extends Node2D

@export var menuName : String

func _ready():
	GlobalSetting.MenuStack.push_back("%" + menuName)

func _hide():
	$Menu/Fade.play("fadeOut")
	await $Menu/Fade.animation_finished
	for item in get_children():
		item.hide()

func _show():
	$Menu/Fade.play("fadeIn")
	for item in get_children():
		item.show()

func _on_menu_button_down(destination):
	GlobalSetting.MenuStack.push_back("%" + destination)
	get_node(GlobalSetting.MenuStack[GlobalSetting.MenuStack.size() - 1]).show()
	get_node(GlobalSetting.MenuStack[GlobalSetting.MenuStack.size() - 2]).hide()
	
func _on_back_button_down():
	get_node(GlobalSetting.MenuStack[GlobalSetting.MenuStack.size() - 1]).hide()
	get_node(GlobalSetting.MenuStack[GlobalSetting.MenuStack.size() - 2]).show()
	GlobalSetting.MenuStack.pop_back()


func _on_quit_button_down():
	get_tree().quit()
