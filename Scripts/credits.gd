extends Node

#Switch to Start Menu when button is pressed
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
