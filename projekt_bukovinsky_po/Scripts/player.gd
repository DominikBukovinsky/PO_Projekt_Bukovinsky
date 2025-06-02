extends CharacterBody2D


var current_towers = 0
var max_towers = 4
var health = 100
var money = 0
@onready var anim_tree = $anim_tree
@onready var anim_state = anim_tree.get("parameters/playback")
enum player_states {MOVE, SWORD, JUMP, DEAD}
var current_states = player_states.MOVE

var inputMovement = Vector2.ZERO
var speed = 70

func _ready():
	$Sword/Area2D.set_monitoring(false) 
	$Sword/Area2D/CollisionShape2D.disabled = true
	$Sword/CollisionShape2D.disabled = true
	$Sword/Area2D.connect("body_entered", _on_sword_hit)
	update_ui()

func _physics_process(delta):
	match current_states:
		player_states.MOVE:
			movement()
		player_states.SWORD:
			sword()
	if Input.is_action_just_pressed("build_tower"):
		build_tower()

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
	$Sword/Area2D.set_monitoring(true)
	$Sword/Area2D/CollisionShape2D.disabled = false
	
	anim_state.travel("Sword")
	await get_tree().create_timer(0.3).timeout 
	
	$Sword/Area2D.set_monitoring(false)
	$Sword/Area2D/CollisionShape2D.disabled = true
	
	current_states = player_states.MOVE
	
func _on_sword_hit(body):
	print("Meč zasáhl objekt:", body.name)
	if body.is_in_group("enemies"):
		print("Zasažen nepřítel:", body.name)
		body.take_damage(1)
	else:
		print("Zasažen jiný objekt:", body.name)
	
func state_reset():
	current_states = player_states.MOVE
	
func build_tower():
	
	if current_towers >= max_towers:
		print("Maximální počet věží dosažen")
		return
		
	if money < 10:
		print("Nemáš dost peněz! Potřebuješ 10.")
		return   
	var existing_towers = get_tree().get_nodes_in_group("towers")
	for tower in existing_towers:
		if tower.global_position.distance_to(global_position) < tower.min_radius:
			print("Věže moc blízko")
			return
	var tower_scene = preload("res://Scenes/tower.tscn")
	var tower = tower_scene.instantiate()
	tower.global_position = global_position
	get_parent().add_child(tower)
	money -= 10
	current_towers += 1
	print("Postavena věž. Zbývá: ", money, " peněz")
	update_ui()
	
func add_money(amount):
	money += amount
	print("Peníze: ", money)
	update_ui()
	
func update_ui():
	var ui = get_tree().get_first_node_in_group("ui")
	if ui:
		ui.update_money(money)
		ui.update_health(health)
		ui.update_towers(current_towers, max_towers)


func _on_area_2d_body_entered(body):
	if body.is_in_group("enemies"):
		take_damage(5)

func take_damage(amount):
	health -= amount
	health = max(health, 0)
	update_ui()
	if health <= 0:
		die()

func die():
	print("Hráč zemřel!")
	set_physics_process(false)
	$CollisionShape2D.disabled = true
	show_death_screen()
		
func show_death_screen():
	var ui = get_tree().get_first_node_in_group("ui")
	if ui:
		ui.hide()
	get_tree().change_scene_to_file("res://Scenes/DeathScreen.tscn")
