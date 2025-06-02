# Spawner.gd
extends Node2D

@export var enemy_scene: PackedScene
var spawn_interval = 2.0
var min_spawn_interval = 0.5
var spawn_speed_increase = 1

func _ready():
	$Timer.wait_time = spawn_interval
	$Timer.start()

func _on_timer_timeout():
	spawn_enemy()
	spawn_interval = max(spawn_interval - spawn_speed_increase, min_spawn_interval)
	$Timer.wait_time = spawn_interval
	$Timer.start()

func spawn_enemy():
	var enemy = enemy_scene.instantiate()
	var player = get_tree().get_first_node_in_group("player")
	if player:
		var angle = randf_range(0, 2 * PI)
		var distance = 600
		enemy.global_position = player.global_position + Vector2.RIGHT.rotated(angle) * distance
		get_parent().add_child(enemy)
