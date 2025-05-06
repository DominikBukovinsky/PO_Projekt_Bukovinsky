# Tower.gd
extends StaticBody2D

@export var projectile_scene: PackedScene
var attack_range = 150
var attack_speed = 1.0

func _ready():
	$Timer.wait_time = attack_speed
	$Timer.start()
	# Nastav tvar Area2D podle attack_range
	$Area2D/CollisionShape2D.shape.radius = attack_range
	
	

func _on_timer_timeout():
	var target = find_closest_enemy()
	if target:
		shoot(target)

func find_closest_enemy():
	var closest = null
	var closest_distance = INF
	for body in $Area2D.get_overlapping_bodies():
		if body.is_in_group("enemies"):
			var distance = global_position.distance_to(body.global_position)
			if distance < closest_distance:
				closest = body
				closest_distance = distance
	return closest

func shoot(target):
	var projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.target = target
	get_parent().add_child(projectile)
