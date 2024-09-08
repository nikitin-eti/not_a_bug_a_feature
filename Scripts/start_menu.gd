extends Node2D

#Start game when button pressed
func _on_start_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Cutscene_Start.tscn")

#Switch to credits screen when button pressed
func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Credits.tscn")
