extends Node

#Switch to Start Menu when button is pressed
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")


func _on_next_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Credits_2.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")