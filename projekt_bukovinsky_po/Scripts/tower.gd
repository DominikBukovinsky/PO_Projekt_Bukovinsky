# Tower.gd
extends StaticBody2D

@export var projectile_scene: PackedScene
@onready var timer = $Timer

var attack_range = 150
var attack_speed = 1.0

func _ready():
	print("Věž inicializována. Timer existuje?", timer != null)
	timer.wait_time = attack_speed
	timer.start()
	$Area2D/CollisionShape2D.shape.radius = attack_range
	
	

func _on_timer_timeout():
	print("Timer aktivován!")
	var target = find_closest_enemy()
	if target:
		print("Cíl nalezen: ", target.name)
		shoot(target)
	else:
		print("Žádný cíl v dosahu.")

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

# Tower.gd
func shoot(target):
	var projectile = projectile_scene.instantiate()
	projectile.global_position = global_position
	projectile.damage = 2
	projectile.target = target
	get_parent().add_child(projectile)
