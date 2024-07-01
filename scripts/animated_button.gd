extends Button

@export var animatedSpriteNode : AnimatedSprite2D
@export var animationName : String
#PossibleUPGRADE: center images with diff size
func _ready():
	var height = animatedSpriteNode.sprite_frames.get_frame_texture(animationName, 0).get_height() * 2
	var width = animatedSpriteNode.sprite_frames.get_frame_texture(animationName, 0).get_width() * 2
	size = Vector2(height, width)
	pivot_offset = Vector2(height / 2, width / 2)
	animatedSpriteNode.position = Vector2(animatedSpriteNode.position.x + height / 2, animatedSpriteNode.position.y + width / 2)

func _on_mouse_entered():
	animatedSpriteNode.play(animationName)

func _on_mouse_exited():
	animatedSpriteNode.stop()

