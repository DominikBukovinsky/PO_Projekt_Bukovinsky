extends CharacterBody2D

var speed = 100
var health = 1

func _physics_process(delta):
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()

func take_damage(amount):
	health -= amount
	print("Enemy hit:", amount, " | HP remaining:", health)
	if health <= 0:
		queue_free()
