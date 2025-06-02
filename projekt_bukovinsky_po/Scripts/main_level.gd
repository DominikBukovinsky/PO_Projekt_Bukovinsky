extends Node2D

var start_screen: CanvasLayer
var death_screen: CanvasLayer

func _ready():
	start_screen = preload("res://Scenes/StartScreen.tscn").instantiate()
	add_child(start_screen)

func show_death_screen():
	var ui = get_tree().get_first_node_in_group("ui")
	if ui:
		ui.hide()
	
	death_screen = preload("res://Scenes/DeathScreen.tscn").instantiate()
	add_child(death_screen)
