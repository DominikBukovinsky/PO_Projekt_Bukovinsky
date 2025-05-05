extends CharacterBody2D

var inputMovement = Vector2.ZERO
var speed = 70

func _physics_process(delta):
	movement()

func movement():
	inputMovement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if inputMovement != Vector2.ZERO:
		velocity = inputMovement * speed
		
	if inputMovement == Vector2.ZERO:
		velocity = Vector2.ZERO
	move_and_slide()
