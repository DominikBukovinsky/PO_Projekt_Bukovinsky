extends CanvasLayer

func _on_start_button_pressed():
	if get_tree():
		get_tree().change_scene_to_file("res://Scenes/main_level.tscn")
	else:
		push_error("SceneTree nenalezen")
		
func _quit_game():
	get_tree().quit()
