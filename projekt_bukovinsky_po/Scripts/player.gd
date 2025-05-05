extends CharacterBody2D

@onready var anim_tree = $anim_tree
@onready var anim_state = anim_tree.get("parameters/playback")
enum player_states {MOVE, SWORD, JUMP, DEAD}
var current_states = player_states.MOVE

var inputMovement = Vector2.ZERO
var speed = 70

func _ready():
	$Sword/CollisionShape2D.disabled = true

func _physics_process(delta):
	match current_states:
		player_states.MOVE:
			movement()
		player_states.SWORD:
			sword()

func movement():
	inputMovement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if inputMovement != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", inputMovement)
		anim_tree.set("parameters/Walk/blend_position", inputMovement)
		anim_tree.set("parameters/Sword/blend_position", inputMovement)
		anim_tree.set("parameters/Jump/blend_position", inputMovement)
		anim_state.travel("Walk")
		
		
		velocity = inputMovement * speed
		
	if inputMovement == Vector2.ZERO:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
		
	if Input.is_action_just_pressed("sword_attack"):
		current_states = player_states.SWORD
		
	move_and_slide()

func sword():
	anim_state.travel("Sword")
	
func state_reset():
	current_states = player_states.MOVE
