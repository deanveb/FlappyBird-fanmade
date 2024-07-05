extends CharacterBody2D

signal end_trigger

const SPEED = 40000.0
const JUMP_VELOCITY = -20000.0
var start : bool
# Get the gravity from theproject settings to be synced with RigidBody nodes.
var gravity = 800

func _ready():
	var content : Dictionary = SaveAndLoad.Load()
	var path : String = "res://flappy-bird-assets-1.1.0/animation/%s.tres" % [content["CurrentSkin"]]
	%AnimatedSprite2D.sprite_frames = load(path)
	%AnimatedSprite2D.play("Flying")
	start = false
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	## Handle jump.
	if Input.is_action_just_pressed("jump"):
		%Jump.play()
		velocity.y = JUMP_VELOCITY * delta
		rotation = deg_to_rad(-30)
		start = false
		%Timer.start()
	if start:
		rotation = clamp(rotation + 0.1, deg_to_rad(-90), deg_to_rad(90))
	if round(rotation) == round(deg_to_rad(90)):
		%AnimatedSprite2D.stop()
		%AnimatedSprite2D.frame = 1
	else:
		%AnimatedSprite2D.play("Flying")
	var view = get_viewport_rect().size / 2
	var cameraPos = get_node("../Camera2D").global_position
	var bounds_uw = cameraPos.y - view.y #the camera bounds at the top
	var bounds_dw = cameraPos.y + view.y #the camera bounds at the bottom
	move_and_slide() 
	global_position.y = clamp(global_position.y, bounds_uw, bounds_dw)

func _on_timer_timeout():
	start = true
