extends CharacterBody2D

@onready var score : int = 0

func _ready():
	pass

func _process(delta):
	get_node(".").position.x = get_node(".").position.x - 10

func _on_area_2d_area_entered(area):
	score += 5
