extends Area2D

var speed = 100
var damage = 1
var target: Node2D

func _physics_process(delta):
	if target and is_instance_valid(target):
		var direction = (target.global_position - global_position).normalized()
		global_position += direction * speed * delta
	else:
		queue_free()

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		print("Projektil zasáhl nepřítele:", body.name)
		body.take_damage(damage)
	queue_free()
